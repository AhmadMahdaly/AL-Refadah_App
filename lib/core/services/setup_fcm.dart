import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

/// دالة لمعالجة الإشعارات عندما يكون التطبيق مغلقًا
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  await showNotification(message);
}

/// تهيئة الإشعارات عند بدء تشغيل التطبيق
Future<void> setupFCM() async {
  try {
    const androidSettings = AndroidInitializationSettings('ic_notification');
    const initSettings = InitializationSettings(android: androidSettings);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    final messaging = FirebaseMessaging.instance;
    await messaging.requestPermission();

    /// طلب الإذن للإشعارات
    await flutterLocalNotificationsPlugin.initialize(initSettings);
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    /// استقبال الإشعارات أثناء تشغيل التطبيق
    FirebaseMessaging.onMessage.listen(showNotification);

    /// استقبال الإشعارات عند النقر على الإشعار
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // لا يفضل عرض إشعار هنا، الأفضل التنقل إلى صفحة بناءً على message.data
      debugPrint('Notification clicked: ${message.data}');
    });
  } on PlatformException catch (e) {
    debugPrint('Error loading ic_launcher: ${e.message}');
  }
}

/// دالة لإظهار الإشعار المحلي
Future<void> showNotification(RemoteMessage message) async {
  final androidDetails = AndroidNotificationDetails(
    dotenv.env['CHANNEL_ID'] ?? '',
    'General Notifications',
    importance: Importance.max,
    priority: Priority.high,
  );

  // const iosDetails = DarwinNotificationDetails();
  final notificationDetails = NotificationDetails(android: androidDetails);
  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title ?? '',
    message.notification?.body ?? '',
    notificationDetails,
  );
}
