import 'package:alrefadah/core/manager/auth_manager.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/features/auth/screens/login_screen.dart';
import 'package:alrefadah/presentation/app/app_loader_page.dart';
import 'package:flutter/material.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: AuthManager.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppIndicator();
          } else if (snapshot.hasData && (snapshot.data ?? false)) {
            return const AppLoaderPage();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
