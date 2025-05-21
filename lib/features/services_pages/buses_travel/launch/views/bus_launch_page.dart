import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:alrefadah/core/services/cache_helper.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/custom_search_bar.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/widgets/custom_download_button.dart';
import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/screens/add_trip_page.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_state.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/select/widgets/select_buses_travel_title_head.dart';

class BusLaunchPage extends StatefulWidget {
  const BusLaunchPage({required this.trip, super.key});
  final BusesTravelGetTripModel trip;

  @override
  State<BusLaunchPage> createState() => _BusLaunchPageState();
}

class _BusLaunchPageState extends State<BusLaunchPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String searchText = '';

  void _initSearchListener() {
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), _updateSearchText);
  }

  void _updateSearchText() {
    if (mounted) {
      setState(() {
        searchText = _searchController.text.toLowerCase();
      });
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initSearchListener();
    context.read<BusTravelCubit>().getTripsByStage(
      widget.trip.fCenterNo,
      widget.trip.fStageNo,
    );
    _getUserId();
  }

  Future<void> _getUserId() async {
    userId = await CacheHelper.getUserId();
  }

  int? userId;
  String formatText(String input) {
    if (input.length < 8) return input;

    final part1 = input.substring(0, 4); // rrrr
    final part2 = input.substring(4, 6); // tt
    final part3 = input.substring(6); // yy

    return '$part1-$part2-$part3';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusTravelCubit, BusesTravelState>(
      builder: (context, state) {
        final userTrips =
            state.tripsByStage
                .where(
                  (trip) =>
                      trip.fAdditionUser == userId.toString() &&
                      trip.fTripStstus == '1',
                )
                .toList();
        return Scaffold(
          appBar: AppBar(
            leading: const LeadingIcon(),
            title: TitleAppBar(
              title: context.read<BusTravelCubit>().getStageName(
                widget.trip.fStageNo,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/svg/help_circle_outline.svg',
                  colorFilter: const ColorFilter.mode(
                    kMainColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50.h),
              child: SizedBox(
                height: 46,
                child: Row(
                  spacing: 12.w,
                  children: [
                    W(w: 4.w),
                    Expanded(
                      child: CustomSearchBar(
                        controller: _searchController,
                        clearIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => searchText = '');
                          },
                        ),
                      ),
                    ),

                    /// Download button
                    const CustomDownloadButton(),
                    W(w: 4.w),
                  ],
                ),
              ),
            ),
          ),
          body:
              state.isLoadingTripsByStage
                  ? const AppIndicator()
                  : userTrips.isEmpty
                  ? Stack(
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Center(child: Text('لا يوجد رحلات'))],
                      ),

                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: FloatingActionButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(320.r),
                          ),
                          backgroundColor: kMainColor,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => AddTripPage(
                                      trip: widget.trip,
                                      tripsByStage: userTrips,
                                    ),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.add,
                            color: kMainColorLightColor,
                          ),
                        ),
                      ),
                    ],
                  )
                  : Stack(
                    children: [
                      Column(
                        children: [
                          const SelectBusesHeadTitle(),
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.only(
                                left: 16.w,
                                right: 16.w,
                                bottom: 80.h,
                                top: 16.h,
                              ),
                              itemCount: userTrips.length,
                              itemBuilder: (context, index) {
                                final trip = userTrips[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ExpansionTile(
                                      shape: Border.all(
                                        color: kScaffoldBackgroundColor,
                                      ),
                                      minTileHeight: 20.h,
                                      collapsedIconColor: kMainColor,
                                      iconColor: kMainColor,
                                      collapsedBackgroundColor:
                                          kScaffoldBackgroundColor,
                                      childrenPadding: EdgeInsets.zero,
                                      tilePadding: EdgeInsets.zero,
                                      title: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          /// Trip No
                                          SizedBox(
                                            width: 50.w,
                                            child: Text(
                                              trip.fTripNo,
                                              overflow: TextOverflow.fade,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Cairo',
                                                color: kDartTextColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),

                                          /// Trip date
                                          SizedBox(
                                            width: 80.w,
                                            child: Text(
                                              formatText(trip.fTripDate),
                                              overflow: TextOverflow.fade,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Cairo',
                                                color: kDartTextColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),

                                          /// Transport name
                                          SizedBox(
                                            width: 75.w,
                                            child: Text(
                                              trip
                                                          .fBus
                                                          .transport!
                                                          .fTransportName
                                                          .length >
                                                      12
                                                  ? '${trip.fBus.transport!.fTransportName}...'
                                                      .replaceAll('الشركة', '')
                                                      .replaceAll('شركة', '')
                                                      .replaceAll('الشركه', '')
                                                      .replaceAll('شركه', '')
                                                  : trip
                                                      .fBus
                                                      .transport!
                                                      .fTransportName
                                                      .replaceAll('الشركة', '')
                                                      .replaceAll('شركة', '')
                                                      .replaceAll('الشركه', '')
                                                      .replaceAll('شركه', ''),
                                              overflow: TextOverflow.fade,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: kDartTextColor,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),

                                          /// Bus No
                                          SizedBox(
                                            width: 65.w,
                                            child: Text(
                                              trip.fBus.fBusNo,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: kDartTextColor,
                                                fontFamily: 'Cairo',
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const H(h: 10),
                                            const HeadInsideCard(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const W(w: 12),

                                                /// Poligrams count
                                                SizedBox(
                                                  width: 60.w,
                                                  height: 40.h,
                                                  child: Text(
                                                    trip.fPilgrimsAco,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      color: kDartTextColor,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),

                                                ///
                                                SizedBox(
                                                  width: 75.w,
                                                  height: 40.h,

                                                  child: Text(
                                                    trip
                                                                .additionUser
                                                                .fUserName
                                                                .length >
                                                            12
                                                        ? '${trip.additionUser.fUserName.substring(0, 12)}...'
                                                        : trip
                                                            .additionUser
                                                            .fUserName,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: kDartTextColor,
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: 40.h,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    spacing: 5.w,
                                                    children: [
                                                      SvgPicture.asset(
                                                        getStatusIcon(
                                                          trip.fTripStstus,
                                                        ),
                                                      ),
                                                      Text(
                                                        getStatusText(
                                                          trip.fTripStstus,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                        overflow:
                                                            TextOverflow.fade,
                                                        style: TextStyle(
                                                          color: getStatusColor(
                                                            trip.fTripStstus,
                                                          ),
                                                          fontSize: 13.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      const W(w: 12),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    /// Trip Status
                                    const Divider(color: kTextColor),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: FloatingActionButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(320.r),
                          ),
                          backgroundColor: kMainColor,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => AddTripPage(
                                      trip: widget.trip,
                                      tripsByStage: state.tripsByStage,
                                    ),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.add,
                            color: kMainColorLightColor,
                          ),
                        ),
                      ),
                    ],
                  ),
        );
      },
    );
  }
}

class HeadInsideCard extends StatelessWidget {
  const HeadInsideCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'عدد الحجاج',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: kAnalysisMediumColor,
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '   اسم المرحل',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: kAnalysisMediumColor,
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'حالة الرحلة:',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kAnalysisMediumColor,
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

String getStatusText(String status) {
  switch (status) {
    case '2':
      return 'وصلت';
    case '3':
      return 'معتمدة';
    default:
      return 'لدى الإنطلاق';
  }
}

Color getStatusColor(String status) {
  switch (status) {
    case '2':
      return const Color(0xFF46C469);
    case '3':
      return const Color(0xFF46C469);
    default:
      return Colors.orangeAccent;
  }
}

String getStatusIcon(String status) {
  switch (status) {
    case '2':
      return 'assets/svg/bus_status/done.svg';
    case '3':
      return 'assets/svg/bus_status/done.svg';
    default:
      return 'assets/svg/bus_status/waiting.svg';
  }
}
