import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheHelper {
  static FlutterSecureStorage storage = const FlutterSecureStorage();

  static Future<void> init() async {}

  /// حفظ قيمة
  static Future<void> saveData({
    required String key,
    required dynamic value,
  }) async {
    await storage.write(key: key, value: value.toString());
  }

  /// جلب قيمة
  static Future<String?> getData({required String key}) {
    return storage.read(key: key);
  }

  /// حذف قيمة
  static Future<void> removeData({required String key}) async {
    await storage.delete(key: key);
  }

  /// حذف كل الذاكرة
  static Future<void> removeAllData() async {
    await storage.deleteAll();
  }
}
