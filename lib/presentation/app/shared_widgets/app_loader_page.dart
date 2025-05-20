import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/features/home_page/cubit/home_cubit.dart';
import 'package:alrefadah/features/navigation_bar/app_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLoaderPage extends StatelessWidget {
  const AppLoaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: context.read<HomeCubit>().initHomeData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // بعد التهيئة ننتقل إلى الصفحة الرئيسية
          Future.microtask(() {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const AppNavigationBar()),
            );
          });
        }

        // أثناء التحميل
        return const Scaffold(body: AppIndicator());
      },
    );
  }
}
