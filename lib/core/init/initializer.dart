// import 'package:alrefadah/core/bloc_observer/my_observer.dart';
import 'package:alrefadah/core/init/init_firebase.dart';
import 'package:alrefadah/core/manager/auth_manager.dart';
import 'package:alrefadah/core/services/connectivity_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConnectivityController.instance.init();
  await dotenv.load();
  // Bloc.observer = MyObserver();
  final defaultApp =
      Firebase.apps.where((app) => app.name == '[DEFAULT]').isNotEmpty;
  if (!defaultApp) {
    await initFirebase();
  }

  await AuthManager.loadTokens();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
