import 'package:alrefadah/core/services/cache_helper.dart';
import 'package:alrefadah/core/services/connectivity_controller.dart';
import 'package:alrefadah/core/services/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConnectivityController.instance.init();
  await dotenv.load();
  // Bloc.observer = MyObserver();
  await ConnectivityController.instance.init();
  await CacheHelper.init();
  await DioHelper.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
