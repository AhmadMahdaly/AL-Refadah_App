import 'package:alrefadah/presentation/app/app_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The root widget of the application that sets up the app's basic structure,
/// including theme, localization, and state management.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      designSize: Size(393, 852),
      minTextAdapt: true,
      child: AppContent(),
    );
  }
}
