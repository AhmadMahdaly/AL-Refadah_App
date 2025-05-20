import 'dart:developer';

import 'package:alrefadah/core/routes/global_variable.dart';
import 'package:alrefadah/core/services/cache_helper.dart';
import 'package:alrefadah/core/services/dio_helper.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthManager {
  static String? accessToken;

  static Future<void> loadTokens() async {
    await DioHelper.init();
  }

  static Future<bool> isLoggedIn() async {
    final token = await CacheHelper.getData(key: 'accessToken');
    if (token == null) return false;
    final isExpired = JwtDecoder.isExpired(token);
    return !isExpired;
  }

  static Future<void> logout() async {
    accessToken = null;
    await CacheHelper.clearAll();
    log('تم تسجيل الخروج تلقائيًا');
    // الحصول على أقرب سياق مستخدم في التطبيق
    final navigatorKey = GlobalVariable.navigatorKey;

    if (navigatorKey.currentContext != null) {
      await showDialog<String>(
        context: navigatorKey.currentContext!,

        builder:
            (context) => AlertDialog(
              title: const Center(child: Text('تسجيل الخروج')),
              content: const Text(
                'تم انتهاء الجلسة وتسجيل الخروج\nيجب تسجيل الدخول مرة أخرى.',
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    logoutAndRedirect(navigatorKey.currentContext!);
                  },
                  child: const Text(
                    'حسنًا',
                    style: TextStyle(color: kMainColor),
                  ),
                ),
              ],
            ),
      );
    }
  }
}

Future<void> logoutAndRedirect(BuildContext context) async {
  await CacheHelper.clearAll();
  await Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => const LoginScreen()),
    (route) => false,
  );
}
