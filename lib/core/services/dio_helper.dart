import 'dart:developer';

import 'package:alrefadah/core/manager/auth_manager.dart';
import 'package:alrefadah/core/services/cache_helper.dart';
import 'package:alrefadah/data/base_api_url.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static bool isRefreshing = false;
  static List<void Function()> requestQueue = [];

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Accept': 'application/json'},
    ),
  );

  static String? accessToken;
  static String? refreshToken;

  static Future<void> init() async {
    accessToken = await CacheHelper.getData(key: 'accessToken');
    refreshToken = await CacheHelper.getData(key: 'refreshToken');

    dio.interceptors.clear();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            log('401 Detected - Trying Refresh Token');

            if (!isRefreshing) {
              // إذا لم نكن نقوم بتحديث، نبدأ بالتحديث
              isRefreshing = true;

              final success = await AuthManager.refreshAccessToken();

              isRefreshing = false;

              if (success) {
                // لو تم التجديد بنجاح، نعيد كل الطلبات التي كانت تنتظر
                for (final callback in requestQueue) {
                  callback();
                }
                requestQueue.clear();

                // نعيد تنفيذ الطلب الحالي الذي حدث له 401
                final requestOptions = e.requestOptions;
                requestOptions.headers['Authorization'] = 'Bearer $accessToken';

                final response = await dio.request<Map<String, dynamic>>(
                  requestOptions.path,
                  options: Options(
                    method: requestOptions.method,
                    headers: requestOptions.headers,
                  ),
                  data: requestOptions.data,
                  queryParameters: requestOptions.queryParameters,
                );
                return handler.resolve(response);
              } else {
                // فشل التحديث: نحذف الطابور ونعطي خطأ
                requestQueue.clear();
                return handler.reject(e);
              }
            } else {
              // لو نحن بالفعل نقوم بتحديث، ننتظر انتهاء التحديث
              requestQueue.add(() async {
                final requestOptions = e.requestOptions;
                requestOptions.headers['Authorization'] = 'Bearer $accessToken';

                final response = await dio.request<Map<String, dynamic>>(
                  requestOptions.path,
                  options: Options(
                    method: requestOptions.method,
                    headers: requestOptions.headers,
                  ),
                  data: requestOptions.data,
                  queryParameters: requestOptions.queryParameters,
                );

                handler.resolve(response);
              });
            }
          } else if (e.type == DioExceptionType.connectionTimeout ||
              e.type == DioExceptionType.receiveTimeout ||
              e.type == DioExceptionType.sendTimeout ||
              e.type == DioExceptionType.connectionError) {
            log('مشكلة في الاتصال بالشبكة: $accessToken');

            return handler.reject(
              DioException(
                requestOptions: e.requestOptions,
                error: 'مشكلة في الاتصال بالشبكة. حاول مرة أخرى.',
              ),
            );
          }

          return handler.next(e);
        },
      ),
    );
  }

  static Future<bool> refreshAccessToken() async {
    final refreshToken = await CacheHelper.getData(key: 'refreshToken');

    if (refreshToken == null) return false;

    try {
      final response = await dio.post<Map<String, dynamic>>(
        'auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        final data = response.data!;
        final newAccessToken = data['accessToken'];
        final newRefreshToken = data['refreshToken'];

        await CacheHelper.saveData(key: 'accessToken', value: newAccessToken);
        await CacheHelper.saveData(key: 'refreshToken', value: newRefreshToken);

        accessToken = newAccessToken.toString();
        dio.options.headers['Authorization'] = 'Bearer $accessToken';
        await init(); // بعد حفظ التوكن الجديد
        log('refreshAccessToken: $accessToken');

        return true;
      }
    } catch (e) {
      log('فشل تجديد التوكن: $e');
    }

    return false;
  }
}
