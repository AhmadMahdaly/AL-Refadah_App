import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:alrefadah/core/manager/auth_manager.dart';
import 'package:alrefadah/core/services/cache_helper.dart';
import 'package:alrefadah/core/services/dio_helper.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/auth/cubit/auth_states.dart';
import 'package:alrefadah/features/auth/models/user_login_model.dart';
import 'package:alrefadah/features/auth/models/user_register_model.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(LoginInitialState());

  static const storage = FlutterSecureStorage();
  Future<void> login({
    required String phoneNo,
    required String password,
  }) async {
    try {
      emit(LoginLoadingState());
      await CacheHelper.saveData(key: 'phoneNo', value: phoneNo);
      final response = await DioHelper.dio.post<Map<String, dynamic>>(
        '/Authentication/login',
        data: {
          'loginParameter': phoneNo,
          'password': password,
          'companyId': companyId,
        },
      );
      if (response.statusCode == 200 && response.data!['success'] == true) {
        final userId = response.data!['userId'];
        await CacheHelper.saveData(key: 'userId', value: userId);
        emit(LoginSuccessState());
      } else {
        emit(LoginErrorState('فشل تسجيل الدخول'));
      }
    } on DioException catch (e) {
      final message =
          (e.response?.data as Map<String, dynamic>?)?['message']?.toString() ??
          'حدث خطأ';
      emit(LoginErrorState(message));
    } catch (e) {
      emit(LoginErrorState('حدث خطأ غير متوقع'));
    }
  }

  Future<void> loginWithCode({required String code}) async {
    emit(LoginWithCodeLoadingState());
    final userId = await CacheHelper.getData(key: 'userId');
    try {
      final response = await DioHelper.dio.post<Map<String, dynamic>>(
        '/Authentication/loginWithCode',
        data: {'code': code, 'userId': userId},
      );
      final loginData = LoginResponse.fromJson(response.data!);

      if (response.statusCode == 200 && loginData.success == true) {
        final accessToken = loginData.accessToken;
        await CacheHelper.saveData(key: 'accessToken', value: accessToken);
        final fPermName = loginData.role.fPermName;
        await CacheHelper.saveData(key: 'fPermName', value: fPermName);
        final fPermNo = loginData.role.fPermNo;
        await CacheHelper.saveData(key: 'fPermNo', value: fPermNo);
        final fUserName = loginData.user.fUserName;
        await CacheHelper.saveData(key: 'fUserName', value: fUserName);
        await DioHelper.init();
        emit(LoginWithCodeSuccessState());
      } else {
        emit(LoginWithCodeErrorState('فشل تسجيل الدخول'));
      }
    } on DioException catch (e) {
      final message =
          (e.response?.data as Map<String, dynamic>?)?['message']?.toString() ??
          'حدث خطأ';
      emit(LoginWithCodeErrorState(message));
    } catch (e) {
      emit(LoginWithCodeErrorState('حدث خطأ غير متوقع'));
    }
  }

  Future<void> register(UserRegisterModel userRegisterModel) async {
    try {
      emit(RegisterLoadingState());

      final response = await DioHelper.dio.post<Map<String, dynamic>>(
        '/Authentication/register',
        data: userRegisterModel.toJson(),
      );
      await CacheHelper.saveData(
        key: 'phoneNo',
        value: userRegisterModel.fJawNo,
      );
      await CacheHelper.saveData(
        key: 'password',
        value: userRegisterModel.fUserPass,
      );
      if (response.statusCode == 200) {
        final userId = response.data!['fUserId'];
        await CacheHelper.saveData(key: 'userId', value: userId);
        emit(RegisterSuccessState());
      } else {
        emit(RegisterErrorState('فشل إنشاء الحساب'));
      }
    } catch (e) {
      emit(RegisterErrorState('حدث خطأ غير متوقع'));
    }
  }

  Future<void> verifyRegister(String code) async {
    try {
      emit(VerifyRegisterLoadingState());
      final userId = await CacheHelper.getData(key: 'userId');
      final response = await DioHelper.dio.post<Map<String, dynamic>>(
        '/Authentication/verifyRegister',
        data: {'userId': userId, 'code': code},
      );
      if (response.statusCode == 200) {
        emit(VerifyRegisterSuccessState());
      } else {
        emit(VerifyRegisterErrorState('فشل إنشاء الحساب'));
      }
    } catch (e) {
      emit(VerifyRegisterErrorState('حدث خطأ غير متوقع'));
    }
  }

  Future<void> resendOTP() async {
    try {
      emit(ResendOTPLoadingState());
      final phoneNo = await CacheHelper.getData(key: 'phoneNo');
      final password = await CacheHelper.getData(key: 'password');
      final response = await DioHelper.dio.post<Map<String, dynamic>>(
        '/Authentication/ResendOTP',
        data: {
          'loginParameter': phoneNo,
          'password': password,
          'companyId': companyId,
        },
      );
      if (response.statusCode == 200) {
        final userId = response.data!['userId'];
        await CacheHelper.saveData(key: 'userId', value: userId);
        emit(ResendOTPSuccessState());
      } else {
        emit(ResendOTPErrorState('فشل إعادة إرسال الرمز'));
      }
    } catch (e) {
      emit(ResendOTPErrorState('حدث خطأ غير متوقع'));
    }
  }

  Future<void> verifyLogin(String code) async {
    try {
      emit(VerifyLoginLoadingState());

      final response = await DioHelper.dio.post<Map<String, dynamic>>(
        '/Authentication/ConfirmLogin?userId=$code&companyId=$companyId',
      );
      if (response.statusCode == 200) {
        emit(VerifyLoginSuccessState());
      } else {
        emit(VerifyLoginErrorState('فشل إنشاء الحساب'));
      }
    } catch (e) {
      emit(VerifyLoginErrorState('حدث خطأ غير متوقع'));
    }
  }

  Future<void> checkAuth() async {
    if (await AuthManager.isLoggedIn()) {
      emit(AuthStateStatus(AuthStatus.authenticated));
    } else {
      emit(AuthStateStatus(AuthStatus.unauthenticated));
    }
  }

  /// تسجيل خروج حقيقي
  Future<void> logout() async {
    await AuthManager.logout();
    emit(AuthStateStatus(AuthStatus.unauthenticated));
  }
}
