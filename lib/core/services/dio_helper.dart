import 'package:alrefadah/core/manager/auth_manager.dart';
import 'package:alrefadah/core/services/cache_helper.dart';
import 'package:alrefadah/data/base_api_url.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static bool _hasShown401Dialog = false;

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
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
  }
}
