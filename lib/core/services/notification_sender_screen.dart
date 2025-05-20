import 'dart:convert';

import 'package:alrefadah/core/services/setup_fcm.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class NotificationSenderScreen extends StatefulWidget {
  const NotificationSenderScreen({super.key});
  @override
  State<NotificationSenderScreen> createState() =>
      _NotificationSenderScreenState();
}

class _NotificationSenderScreenState extends State<NotificationSenderScreen> {
  String? fcmToken;

  @override
  void initState() {
    super.initState();
    _initFCM();
  }

  Future<void> _initFCM() async {
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint('FCM Token: $token');
    setState(() {
      fcmToken = token;
    });

    FirebaseMessaging.onMessage.listen(_showNotification);
  }

  static Future<void> _showNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? 'بدون عنوان',
      message.notification?.body ?? 'بدون محتوى',
      notificationDetails,
    );
  }

  Future<void> sendPushNotification() async {
    const serverKey =
        'YOUR_SERVER_KEY_HERE'; // 🔐 ضع مفتاح الـ FCM الخاص بك هنا (من Firebase Console)

    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: jsonEncode({
        'to': fcmToken,
        'notification': {
          'title': 'اشعار من التطبيق',
          'body': 'هذا إشعار مرسل من التطبيق نفسه',
        },
        'priority': 'high',
        'data': {'click_action': 'FLUTTER_NOTIFICATION_CLICK'},
      }),
    );

    debugPrint(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إرسال إشعار')),
      body: Center(
        child: ElevatedButton(
          onPressed: fcmToken == null ? null : sendPushNotification,
          child: const Text('أرسل إشعارًا لنفسي'),
        ),
      ),
    );
  }
}
