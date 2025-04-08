import 'package:alrefadah/screens/home_page/home_page.dart';
import 'package:alrefadah/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CheckAuth extends StatelessWidget {
  const CheckAuth({super.key});

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<bool> checkLogin() async {
    final token = await storage.read(key: 'auth_token');
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: checkLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            ); // شاشة تحميل مؤقتة
          } else {
            if ((snapshot.data ?? false) == true) {
              return const HomePage(); // لو التوكن موجود
            } else {
              return const LoginScreen(); // لو مش موجود
            }
          }
        },
      ),
    );
  }
}
