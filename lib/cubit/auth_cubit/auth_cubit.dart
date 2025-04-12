import 'dart:convert';

import 'package:alrefadah/cubit/auth_cubit/auth_states.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(LoginInitialState());

  final dio = Dio();
  final storage = FlutterSecureStorage();

  final String baseUrlLogin = dotenv.env['BASEURLLOGIN'] ?? '';
  final String baseUrlLoginWithCode = dotenv.env['BASEURLLOGINWITHCODE'] ?? '';
  Future<void> login({
    required String phoneNumber,
    required String identityNumber,
  }) async {
    emit(LoginLoadingState());
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final response = await dio.post<Map<String, dynamic>>(
        baseUrlLogin,
        data: json.encode({
          'companyId': dotenv.env['COMPANYID'] ?? '',
          'identityNumber': identityNumber,
          'phoneNumber': phoneNumber,
        }),
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        emit(LoginSuccessState());
      } else {
        emit(LoginErrorState('خطأ'));
      }
    } catch (e) {
      emit(LoginErrorState('خطأ'));
    }
  }

  Future<void> loginWithCode({
    required String phoneNumber,
    required String identityNumber,
    required String code,
  }) async {
    emit(LoginLoadingState());
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      final response = await dio.post<Map<String, dynamic>>(
        '$baseUrlLoginWithCode$code',

        data: json.encode({
          'companyId': dotenv.env['COMPANYID'] ?? '',
          'identityNumber': identityNumber,
          'phoneNumber': phoneNumber,
        }),
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        final data = response.data!;
        final accessToken = data['accessToken'].toString();
        final refreshToken = data['refreshToken'].toString();
        await saveTokens(accessToken, refreshToken);
        headers.addAll({'Authorization': 'Bearer $accessToken'});
        emit(LoginSuccessState());
      } else {
        emit(LoginWithCodeErrorState('خطأ'));
      }
    } catch (e) {
      emit(LoginWithCodeErrorState('خطأ'));
    }
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await storage.write(key: 'access_token', value: accessToken);
    await storage.write(key: 'refresh_token', value: refreshToken);
  }

  Future<String?> getAccessToken() => storage.read(key: 'access_token');
  Future<String?> getRefreshToken() => storage.read(key: 'refresh_token');

  void isLogin() {}

  void setupDio() {
    emit(SetUpLoadingState());
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          emit(SetUpSuccessState());
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            final refreshed = await refreshToken();
            if (refreshed) {
              final retryToken = await getAccessToken();
              error.requestOptions.headers['Authorization'] =
                  'Bearer $retryToken';
              final response = await dio.fetch<Response<dynamic>>(
                error.requestOptions,
              );
              emit(SetUpSuccessState());
              return handler.resolve(response);
            } else if (!refreshed) {
              //error
              emit(SetUpErrorState());
            }
          }
          emit(SetUpErrorState());
          return handler.next(error);
        },
      ),
    );
  }

  Future<bool> refreshToken() async {
    emit(RefreshTokenLoadingState());
    final refresh = await getRefreshToken();
    if (refresh == null) return false;

    try {
      final response = await dio.post<dynamic>(
        baseUrlLogin,
        data: {'refresh_token': refresh},
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>;
        final newAccessToken = data['access_token'];
        final newRefreshToken = data['refresh_token'];
        await saveTokens(newAccessToken as String, newRefreshToken as String);
        emit(RefreshTokenSuccessState());
      } else {
        await storage.deleteAll();
        emit(RefreshTokenErrorState());
        return false;
      }
      emit(RefreshTokenSuccessState());
      return true;
    } catch (e) {
      ////////
      emit(RefreshTokenErrorState());
      return false;
    }
  }

  Future<void> logout() async {
    await storage.deleteAll();
    emit(LogoutSuccessState());
  }

  Future<bool> isLoggedIn() async {
    emit(IsLoginLoadingState());
    try {
      final access = await getAccessToken();
      final refresh = await getRefreshToken();
      emit(IsLoginSuccessState());
      return access != null && refresh != null;
    } catch (e) {
      emit(IsLoginErrorState());
      return false;
    }
  }
}
