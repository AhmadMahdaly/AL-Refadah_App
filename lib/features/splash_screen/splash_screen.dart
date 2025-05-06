import 'package:alrefadah/core/services/connectivity_controller.dart';
import 'package:alrefadah/features/auth/screans/check_auth_screen.dart';
import 'package:alrefadah/features/home_page/cubit/home_cubit.dart';
import 'package:alrefadah/features/splash_screen/widgets/splash_logo.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_dialog/no_network_dialog.dart';
import 'package:alrefadah/presentation/app/shared_widgets/end_of_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    initHomeData();
  }

  void initHomeData() {
    final getHomeSeasons = BlocProvider.of<HomeCubit>(context)
      ..getHomeSeasons();
    getHomeSeasons.stream.listen((state) {
      if (state.seasons.isNotEmpty) {
        getHomeSeasons.selectedSeason = state.seasons.last.fSeasonId.toString();
      }
    });
    final getHomeCenters = BlocProvider.of<HomeCubit>(context)..getCenters();
    getHomeCenters.stream.listen((state) {
      if (state.centers.isNotEmpty) {
        getHomeCenters.selectedCenter =
            state.centers.first.fCenterNo.toString();
      }
    });
    final getHomeStages = BlocProvider.of<HomeCubit>(context)..getStages();
    getHomeStages.stream.listen((state) {
      if (state.stages.isNotEmpty) {
        getHomeStages.selectedStage = state.stages.first.fStageNo.toString();
      }
    });
    context.read<HomeCubit>().getDashboardData();
  }

  Future<void> _initSplashScreen() async {
    // Set UI to immersive mode
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Wait for 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

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
