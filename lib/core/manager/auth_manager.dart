import 'dart:developer';

import 'package:alrefadah/core/services/cache_helper.dart';
import 'package:alrefadah/core/services/dio_helper.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthManager {
  static String? accessToken;
  static String? refreshToken;

  static Future<void> loadTokens() async {
    accessToken = (await CacheHelper.getData(key: 'accessToken'))?.toString();
    refreshToken = (await CacheHelper.getData(key: 'refreshToken'))?.toString();

    await DioHelper.init();
  }

  static Future<bool> refreshAccessToken() async {
    try {
      final response = await DioHelper.dio.post<Map<String, dynamic>>(
        'auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        final data = response.data!;
        accessToken = data['accessToken'].toString();
        refreshToken = data['refreshToken'].toString();

        await CacheHelper.saveData(key: 'accessToken', value: accessToken);
        await CacheHelper.saveData(key: 'refreshToken', value: refreshToken);

        await DioHelper.init();

        return true;
      } else {
        await logout();
        return false;
      }
    } catch (e) {
      await logout();
      return false;
    }
  }

  static Future<bool> isLoggedIn() async {
    final accessToken = await CacheHelper.getData(key: 'accessToken');

    if (accessToken == null) return false;

    final isExpired = JwtDecoder.isExpired(accessToken);

    if (isExpired) {
      // نحاول نحدث التوكن
      final refreshed = await refreshAccessToken();
      return refreshed;
    } else {
      return true;
    }
  }

  static Future<void> logout() async {
    accessToken = null;
    refreshToken = null;
    await CacheHelper.removeAllData();

    // هنا ممكن ترجع المستخدم لصفحة تسجيل الدخول
    // مثلا: Navigator.pushReplacementNamed(context, '/login');
    log('تم تسجيل الخروج تلقائيًا');
  }
}
