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
import 'package:alrefadah/features/services_pages/buses_travel/approval/views/approval_arrivel_dialog.dart';
import 'package:alrefadah/features/services_pages/buses_travel/approval/views/confirm_arrivel_dialog.dart';
import 'package:alrefadah/features/services_pages/buses_travel/approval/widgets/head_table_bus_trip.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_state.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/select/widgets/select_buses_travel_head_table_in_card.dart';
import 'package:alrefadah/features/services_pages/buses_travel/select/widgets/select_buses_travel_title_head.dart';
import 'package:alrefadah/features/services_pages/buses_travel/show/screens/show_trip.dart';
import 'package:alrefadah/features/services_pages/complaint/views/add_complaint_page.dart';

class BusApprovalPage extends StatefulWidget {
  const BusApprovalPage({required this.trip, super.key});
  final BusesTravelGetTripModel trip;

  @override
  State<BusApprovalPage> createState() => _BusApprovalPageState();
}

class _BusApprovalPageState extends State<BusApprovalPage> {
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
    context.read<BusTravelCubit>().getTripArrivingByStage(widget.trip.fStageNo);
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
        final buses = state.arrivingTripsByStage;
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
          ),
          body:
              state.isLoadingArrivingTripByStage
                  ? const AppIndicator()
                  : buses == null || buses.isEmpty
                  ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Center(child: Text('لا يوجد رحلات'))],
                  )
                  : Column(
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
                          itemCount: buses.length,
                          itemBuilder: (context, index) {
                            final trip = buses[index];
                            final tripAco = trip.fBus.fTripAco;

                            final accuTrip = int.tryParse(
                              trip.busOccurrencesCount,
                            );
                            final remainingTripsCount =
                                tripAco - (accuTrip ?? 0) < 0
                                    ? 0
                                    : tripAco - (accuTrip ?? 0);
                            final additionTrip =
                                (accuTrip ?? 0) - tripAco < 0
                                    ? 0
                                    : (accuTrip ?? 0) - tripAco;
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
                                    Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            HeadTableInSelectTripCard(
                                              trip: trip,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                /// Poligrams count
                                                SizedBox(
                                                  width: 40.w,
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

                                                /// Logined Name
                                                SizedBox(
                                                  width: 90.w,
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
                                                if (trip.fTripStstus != '1')
                                                  /// Arraivel Date
                                                  SizedBox(
                                                    width: 90.w,
                                                    child: Text(
                                                      trip.fReceiptDate ==
                                                              'null'
                                                          ? 'لدى الإنطلاق'
                                                          : trip.fReceiptDate
                                                              .split('T')[0],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        color: kDartTextColor,
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                if (trip.fTripStstus != '1')
                                                  /// Arraivel Name
                                                  SizedBox(
                                                    width: 90.w,
                                                    child: Text(
                                                      trip
                                                                  .receiptUser
                                                                  .fUserName ==
                                                              'string'
                                                          ? 'لم يتم الإستلام بعد'
                                                          : trip
                                                              .receiptUser
                                                              .fUserName,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: kDartTextColor,
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Spacer(),

                                        /// Popup Menu Button
                                        Container(
                                          width: 40.w,
                                          height: 40.h,
                                          decoration: ShapeDecoration(
                                            color: kMainExtrimeLightColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                            ),
                                          ),
                                          child: PopupMenuButton<String>(
                                            iconColor: kMainColor,
                                            constraints: BoxConstraints(
                                              minWidth: 150.w,
                                            ),
                                            color: kScaffoldBackgroundColor,
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                color: kScaffoldBackgroundColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                            ),
                                            onSelected: (value) async {
                                              if (value == 'show') {
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            ShowBusTravelTrip(
                                                              trip: trip,
                                                            ),
                                                  ),
                                                );
                                              } else if (value == 'notice') {
                                                if (context.mounted) {
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                              AddComplaintPage(
                                                                trip: trip,
                                                              ),
                                                    ),
                                                  );
                                                }
                                              } else if (value == 'done') {
                                                if (context.mounted) {
                                                  await confirmArrTripMethod(
                                                    context,
                                                    trip,
                                                    userId!,
                                                  );
                                                }
                                              } else if (value == 'approval') {
                                                if (context.mounted) {
                                                  await approvalTMethod(
                                                    context,
                                                    trip,
                                                    userId!,
                                                  );
                                                }
                                              }
                                            },
                                            itemBuilder: (
                                              BuildContext context,
                                            ) {
                                              return [
                                                if (trip.fTripStstus == '1')
                                                  PopupMenuItem(
                                                    height: 40.h,
                                                    value: 'done',
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          'assets/svg/add-square.svg',
                                                          colorFilter:
                                                              const ColorFilter.mode(
                                                                kGreenColor,
                                                                BlendMode.srcIn,
                                                              ),
                                                        ),
                                                        W(w: 8.w),
                                                        Text(
                                                          'تأكيد الوصول',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: kGreenColor,
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            height: 1.67.h,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                if (trip.fTripStstus == '2')
                                                  PopupMenuItem(
                                                    height: 40.h,
                                                    value: 'approval',
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          'assets/svg/add-square.svg',
                                                          colorFilter:
                                                              const ColorFilter.mode(
                                                                kGreenColor,
                                                                BlendMode.srcIn,
                                                              ),
                                                        ),
                                                        W(w: 8.w),
                                                        Text(
                                                          'اعتماد الرحلة',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: kGreenColor,
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            height: 1.67.h,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                PopupMenuItem(
                                                  height: 40.h,
                                                  value: 'notice',
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .notification_important_outlined,
                                                        color: kErrorColor,
                                                      ),

                                                      W(w: 8.w),
                                                      Text(
                                                        'إضافة بلاغ',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: kErrorColor,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          height: 1.67.h,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ];
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const H(h: 16),
                                    const HeadTableInSelectBusTripCard(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 60.w,
                                          child: Text(
                                            trip.fBus.fTripAco.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                              color: kDartTextColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 75.w,
                                          child: Text(
                                            trip.busOccurrencesCount,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                              color: kDartTextColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 80.w,
                                          child: Text(
                                            remainingTripsCount.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                              color: kDartTextColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 80.w,
                                          child: Text(
                                            additionTrip.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                              color: kDartTextColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                /// Trip Status
                                Row(
                                  spacing: 5.w,
                                  children: [
                                    Text(
                                      'حالة الرحلة:',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: kAnalysisMediumColor,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const W(w: 12),
                                    SvgPicture.asset(
                                      getStatusIcon(trip.fTripStstus),
                                    ),
                                    Text(
                                      getStatusText(trip.fTripStstus),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                        color: getStatusColor(trip.fTripStstus),
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(color: kTextColor),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
        );
      },
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
