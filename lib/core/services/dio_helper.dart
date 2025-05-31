import 'package:alrefadah/core/manager/auth_manager.dart';
import 'package:alrefadah/core/services/cache_helper.dart';
import 'package:alrefadah/data/base_api_url.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static bool _hasShown401Dialog = false;
  static bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.response?.statusCode == 500;
  }

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      headers: {'Accept': 'application/json'},
    ),
  );

  static String? accessToken;

  static Future<void> init() async {
    accessToken = await CacheHelper.getData(key: 'accessToken');

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
          if (e.response?.statusCode == 401 && !_hasShown401Dialog) {
            _hasShown401Dialog = true;
            await AuthManager.logout();
          }
          return handler.next(e); // مرر الخطأ كما هو
        },
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          final shouldRetry = _shouldRetry(error);

          if (shouldRetry) {
            const maxRetries = 3;
            const retryDelay = Duration(seconds: 2);
            var retryCount =
                (error.requestOptions.extra['retryCount'] as int?) ?? 0;

            if (retryCount < maxRetries) {
              retryCount++;
              await Future.delayed(retryDelay);

              final newOptions = Options(
                method: error.requestOptions.method,
                headers: error.requestOptions.headers,
                extra: {
                  ...error.requestOptions.extra,
                  'retryCount': retryCount,
                },
              );

              try {
                final response = await dio.request<dynamic>(
                  error.requestOptions.path,
                  data: error.requestOptions.data,
                  queryParameters: error.requestOptions.queryParameters,
                  options: newOptions,
                );
                return handler.resolve(response);
              } catch (e) {
                return handler.reject(e as DioException);
              }
            }
          }

          // في حال لم تنجح المحاولة أو لا يستحق إعادة المحاولة
          if (error.response?.statusCode == 401 && !_hasShown401Dialog) {
            _hasShown401Dialog = true;
            await AuthManager.logout();
          }

          return handler.next(error);
        },
      ),
    );
  }
}
