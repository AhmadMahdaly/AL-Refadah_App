import 'package:alrefadah/core/services/permissions_manager.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/features/home_page/cubit/home_cubit.dart';
import 'package:alrefadah/features/home_page/screens/home_page.dart';
import 'package:alrefadah/features/more_page/more_page.dart';
import 'package:alrefadah/features/navigation_bar/app_navigation_bar.dart';
import 'package:alrefadah/presentation/app/empty_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLoaderPage extends StatelessWidget {
  const AppLoaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: context.read<HomeCubit>().initHomeData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // في حالة حدوث خطأ أثناء التحميل
          return const Scaffold(
            body: Center(
              child: Text(
                'حدث خطأ أثناء تحميل البيانات',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          );
        }
        // في حالة نجاح التحميل
        if (snapshot.connectionState == ConnectionState.done) {
          final homeCubit = context.read<HomeCubit>();
          final fPermNo = homeCubit.fPermNo;

          Future.microtask(() {
            if (fPermNo == PermNo.transMan ||
                fPermNo == PermNo.systemMan ||
                fPermNo == PermNo.centerMember) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const AppNavigationBar()),
              );
            } else if (fPermNo == PermNo.moveWatcher) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const HomePage()),
              );
            } else if (fPermNo == PermNo.storeWatcher ||
                fPermNo == PermNo.trackWatcher) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const MorePage()),
              );
            } else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const EmptyPage()),
              );
            }
          });
        }
        // في حالة ما إذا كانت البيانات لا تزال قيد التحميل
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: AppIndicator());
        }
        // أثناء التحميل
        return const Scaffold(body: AppIndicator());
      },
    );
  }
}
