import 'package:alrefadah/core/services/permissions_manager.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/home_page/cubit/home_cubit.dart';
import 'package:alrefadah/features/more_page/widgets/services_tab_widget.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_states.dart';
import 'package:alrefadah/features/services_pages/buses/main/screens/buses_page.dart';
import 'package:alrefadah/features/services_pages/buses_travel/approval/main/views/approval_trips_page.dart';
import 'package:alrefadah/features/services_pages/buses_travel/incoming/main/views/incoming_trips_page.dart';
import 'package:alrefadah/features/services_pages/buses_travel/launch/main/views/launch_trips_page.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/screens/buses_travel_page.dart';
import 'package:alrefadah/features/services_pages/complaint/show_all/views/all_complaint_page.dart';
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
  /// init
  @override
  void initState() {
    super.initState();
    initBusesData();
    initBusTravelData();
    initOpratingCommandData();
    _checkPermissions();
  }

  /// get permissions
  Future<void> _checkPermissions() async {
    fPermNo = context.read<HomeCubit>().fPermNo;
  }

  String? fPermNo;

  ///
  void initBusTravelData() {
    final busTravelSeasonsCubit = BlocProvider.of<BusTravelCubit>(context)
      ..getSeasons();
    busTravelSeasonsCubit.stream.listen((state) {
      if (!mounted) return;
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
      if (!mounted) return;
      if (state.centers != null) {
        final centers = state.centers.map((e) => e.fCenterNo.toString());
        if (centers.isNotEmpty) {
          busTravelCentersCubit.selectedCenter = centers.first;
        }
      }
    });
  }

  void initBusesData() {
    final busesCubit = BlocProvider.of<BusesCubit>(context)..getSeasons();
    busesCubit.stream.listen((state) {
      if (!mounted) return;
      if (state.seasons != null) {
        final sessions = state.seasons.map((e) => e.fSeasonId);
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
      if (!mounted) return;
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
              spacing: 14.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'خدمات النقل',
                    style: TextStyle(
                      color: kMainColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.25.h,
                    ),
                  ),
                ),
                const H(h: 5),

                /// Pages
                /// مراحل النقل
                if (fPermNo == PermNo.transMan || fPermNo == PermNo.systemMan)
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

                /// حصص مراحل النقل
                if (fPermNo == PermNo.transMan || fPermNo == PermNo.systemMan)
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

                /// المرشدين
                if (fPermNo == PermNo.transMan || fPermNo == PermNo.systemMan)
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

                /// أوامر التشغيل
                if (fPermNo == PermNo.transMan || fPermNo == PermNo.systemMan)
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

                /// الحافلات
                if (fPermNo == PermNo.transMan ||
                    fPermNo == PermNo.systemMan ||
                    fPermNo == PermNo.storeWatcher)
                  ServicesTabWidget(
                    icon: const Icon(
                      Icons.directions_bus_outlined,
                      color: kMainColor,
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

                /// حركة الحافلات
                if (fPermNo == PermNo.transMan || fPermNo == PermNo.systemMan)
                  ServicesTabWidget(
                    icon: const Icon(
                      Icons.autorenew_rounded,
                      color: kMainColor,
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

                /// إطلاق الحافلات
               if (fPermNo == PermNo.transMan || fPermNo == PermNo.systemMan||fPermNo == PermNo.centerMember ||
                    fPermNo == PermNo.storeWatcher)
                  ServicesTabWidget(
                    icon: Icon(Icons.logout, color: kMainColor, size: 20.sp),
                    text: 'إطلاق الحافلات',
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BusesTravelLaunchPage(),
                          ),
                        ),
                  ),

                /// الحافلات القادمة
               if (fPermNo == PermNo.transMan || fPermNo == PermNo.systemMan||fPermNo == PermNo.trackWatcher ||
                    fPermNo == PermNo.centerMember)
                  ServicesTabWidget(
                    icon: RotatedBox(
                      quarterTurns: 2,
                      child: Icon(
                        Icons.login_outlined,
                        size: 20.sp,
                        color: kMainColor,
                      ),
                    ),
                    text: 'الحافلات القادمة',
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const IncomingTripsPage(),
                          ),
                        ),
                  ),

                /// الحافلات الواصلة
               if (fPermNo == PermNo.transMan || fPermNo == PermNo.systemMan||fPermNo == PermNo.centerMember ||
                    fPermNo == PermNo.trackWatcher)
                  ServicesTabWidget(
                    icon: SvgPicture.asset(
                      'assets/svg/map-marker.svg',
                      width: 20.sp,
                      colorFilter: const ColorFilter.mode(
                        kMainColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    text: 'الحافلات الواصلة',
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ApprovalTripsPage(),
                          ),
                        ),
                  ),

                /// البلاغات
                if (fPermNo == PermNo.transMan || fPermNo == PermNo.systemMan)
                  ServicesTabWidget(
                    icon: Icon(
                      Icons.report_problem_outlined,
                      size: 22.sp,
                      color: kMainColor,
                    ),
                    text: 'البلاغات',
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AllComplaintPage(),
                          ),
                        ),
                  ),
                const H(h: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
