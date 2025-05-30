import 'dart:io';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> initFirebase() async {
  Platform.isAndroid
      ? await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: dotenv.env['CURRENT_KEY'] ?? '',
          appId: dotenv.env['MOBILE_SDK_APP_ID'] ?? '',
          messagingSenderId: dotenv.env['PROJECT_NUMBER'] ?? '',
          projectId: dotenv.env['PROJECT_ID'] ?? '',
        ),
      )
      : await Firebase.initializeApp();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  /// Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}
