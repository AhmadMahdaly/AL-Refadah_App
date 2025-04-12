import 'dart:convert';

import 'package:alrefadah/cubit/auth_cubit/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(LoginInitialState());

  final storage = const FlutterSecureStorage();
  final String baseUrlLogin = dotenv.env['BASEURLLOGIN'] ?? '';
  final String baseUrlLoginWithCode = dotenv.env['BASEURLLOGINWITHCODE'] ?? '';
  Future<void> login({
    required String phoneNumber,
    required String identityNumber,
  }) async {
    emit(LoginLoadingState());
    try {
      final response = await http.post(
        Uri.parse(baseUrlLogin),

        body: json.encode({
          'companyId': dotenv.env['COMPANYID'] ?? '',
          'identityNumber': identityNumber,
          'phoneNumber': phoneNumber,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
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
      final response = await http.post(
        Uri.parse('$baseUrlLoginWithCode$code'),

        body: json.encode({
          'companyId': dotenv.env['COMPANYID'] ?? '',
          'identityNumber': identityNumber,
          'phoneNumber': phoneNumber,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        emit(LoginSuccessState());
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final token = data['accessToken'].toString();
        await storage.write(key: 'auth_token', value: token);
      } else {
        emit(LoginWithCodeErrorState('خطأ'));
      }
    } catch (e) {
      emit(LoginWithCodeErrorState('خطأ'));
    }
  }

  Future<bool> checkLogin() async {
    final token = await storage.read(key: 'auth_token');
    return token != null;
  }

  Future<void> logout() async {
    await storage.delete(key: 'auth_token');
    emit(LogoutSuccessState());
  }
}
