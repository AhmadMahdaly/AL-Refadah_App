import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/more_page/widgets/services_tab_widget.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_states.dart';
import 'package:alrefadah/features/services_pages/buses/main/screens/buses_page.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/screens/buses_travel_page.dart';
import 'package:alrefadah/features/services_pages/guides/main/screens/guides_page.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/cubit/oprating_command_cubit.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/screens/oprating_command_page.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/screens/transfer_stage_page.dart';
import 'package:alrefadah/features/services_pages/transport_stage/screens/stage_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MorePageBody extends StatefulWidget {
  const MorePageBody({super.key});

  @override
  State<MorePageBody> createState() => _MorePageBodyState();
}

class _MorePageBodyState extends State<MorePageBody> {
  @override
  void initState() {
    initBusesData();
    initBusTravelData();
    initOpratingCommandData();
    super.initState();
  }

  void initBusTravelData() {
    final busTravelSeasonsCubit = BlocProvider.of<BusTravelCubit>(context)
      ..getSeasons();
    busTravelSeasonsCubit.stream.listen((state) {
      if (state.seasons != null) {
        final sessions = state.seasons.map((e) => e.fSeasonId.toString());
        if (sessions.isNotEmpty) {
          busTravelSeasonsCubit.selectedSeason = sessions.last;
        }
      }
    });
    final busTravelCentersCubit = BlocProvider.of<BusTravelCubit>(context)
      ..getCenters();
    busTravelCentersCubit.stream.listen((state) {
      if (state.centers != null) {
        final centers = state.centers.map((e) => e.fCenterNo.toString());
        if (centers.isNotEmpty) {
          busTravelCentersCubit.selectedCenter = centers.first;
        }
      }
    });
    context.read<BusTravelCubit>().getTrips();
  }

  void initBusesData() {
    final busesCubit = BlocProvider.of<BusesCubit>(context)..getSeasons();
    busesCubit.stream.listen((state) {
      if (state.seasons != null) {
        final sessions = state.seasons.map((e) => e.fSeasonId.toString());
        if (sessions.isNotEmpty) {
          busesCubit.selectedSeason = sessions.last;
        }
      }
    });

    context.read<BusesCubit>().getAllBuses();
  }

  void initOpratingCommandData() {
    final cubit = BlocProvider.of<OpratingCommandsCubit>(context)..getSeasons();
    cubit.stream.listen((state) {
      if (state.seasons != null) {
        final sessions = state.seasons.map((e) => e.fSeasonId.toString());
        if (sessions.isNotEmpty) {
          cubit.selectedSeasonId = sessions.last;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusesCubit, BusesState>(
      builder: (context, state) {
        if (state.isLoadingSeasons || state.isLoadingAllBuses) {
          return const AppIndicator();
        }
        return Padding(
          padding: EdgeInsets.all(16.sp),
          child: SingleChildScrollView(
            child: Column(
              spacing: 12.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'خدمات النقل',
                  style: TextStyle(
                    color: kMainColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.25.h,
                  ),
                ),
                const H(h: 5),
                ServicesTabWidget(
                  icon: SvgPicture.asset(
                    'assets/svg/place_location.svg',
                    colorFilter: const ColorFilter.mode(
                      kMainColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  text: 'مراحل النقل',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StagePage(),
                      ),
                    );
                  },
                ),
                ServicesTabWidget(
                  icon: const Icon(Icons.menu, color: kMainColor),
                  text: 'حصص مراحل النقل',
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TransferStagePage(),
                        ),
                      ),
                ),
                ServicesTabWidget(
                  icon: SvgPicture.asset(
                    'assets/svg/driver-outline.svg',
                    colorFilter: const ColorFilter.mode(
                      kMainColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  text: 'المرشدين',

                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GuidesPage(),
                        ),
                      ),
                ),
                ServicesTabWidget(
                  icon: SvgPicture.asset(
                    'assets/svg/Document.svg',
                    colorFilter: const ColorFilter.mode(
                      kMainColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  text: 'أوامر التشغيل',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OprationgCommandPage(),
                      ),
                    );
                  },
                ),
                ServicesTabWidget(
                  icon: SvgPicture.asset(
                    'assets/svg/ion_bus-outline.svg',
                    colorFilter: const ColorFilter.mode(
                      kMainColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  text: 'الحافلات',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BusesPage(),
                      ),
                    );
                  },
                ),
                ServicesTabWidget(
                  icon: SvgPicture.asset(
                    'assets/svg/refresh_02.svg',
                    colorFilter: const ColorFilter.mode(
                      kMainColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  text: 'حركة الحافلات',
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BusesMovesPage(),
                        ),
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
