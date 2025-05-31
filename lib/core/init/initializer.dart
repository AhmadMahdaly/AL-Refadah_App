import 'dart:ui';

import 'package:alrefadah/core/bloc_observer/my_observer.dart';
import 'package:alrefadah/core/manager/auth_manager.dart';
import 'package:alrefadah/core/services/connectivity_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConnectivityController.instance.init();
  await dotenv.load();
  Bloc.observer = MyObserver();
  final defaultApp =
      Firebase.apps.where((app) => app.name == '[DEFAULT]').isNotEmpty;
  if (!defaultApp) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: dotenv.env['CURRENT_KEY'] ?? '',
        appId: dotenv.env['MOBILE_SDK_APP_ID'] ?? '',
        messagingSenderId: dotenv.env['PROJECT_NUMBER'] ?? '',
        projectId: dotenv.env['PROJECT_ID'] ?? '',
      ),
    );

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    /// Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
    ;
  }

  await AuthManager.loadTokens();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
