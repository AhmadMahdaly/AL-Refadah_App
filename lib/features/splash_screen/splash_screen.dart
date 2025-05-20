import 'package:alrefadah/core/services/connectivity_controller.dart';
import 'package:alrefadah/core/services/setup_fcm.dart';
import 'package:alrefadah/core/widgets/custom_dialog/no_network_dialog.dart';
import 'package:alrefadah/features/auth/screens/check_auth_screen.dart';
import 'package:alrefadah/features/splash_screen/widgets/splash_logo.dart';
import 'package:alrefadah/presentation/app/shared_widgets/end_of_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initSplashScreen();
    Future.microtask(() async {
      await setupFCM();
    });
  }

  Future<void> _initSplashScreen() async {
    // Set UI to immersive mode
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Wait for 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;
    await Future.microtask(setupFCM);
    // Navigate to authentication check screen
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ValueListenableBuilder(
            valueListenable: ConnectivityController.instance.isConnected,
            builder: (_, value, __) {
              if (value) {
                return const CheckAuthScreen();
              } else {
                return const NoNetworkDialog();
              }
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // Restore system UI mode
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashLogoWidget(),
      bottomNavigationBar: EndOfPage(),
    );
  }
}
