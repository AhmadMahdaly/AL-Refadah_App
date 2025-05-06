import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/screens/add_trip.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_state.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/select/widgets/popup_widgets/select_buses_travel_popup_button.dart';
import 'package:alrefadah/features/services_pages/buses_travel/select/widgets/select_buses_travel_head_table_in_card.dart';
import 'package:alrefadah/features/services_pages/buses_travel/select/widgets/select_buses_travel_search_field.dart';
import 'package:alrefadah/features/services_pages/buses_travel/select/widgets/select_buses_travel_title_head.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_download_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SelectTripPage extends StatefulWidget {
  const SelectTripPage({required this.trip, super.key});
  final BusesTravelGetTripModel trip;

  @override
  State<SelectTripPage> createState() => _SelectTripPageState();
}

class _SelectTripPageState extends State<SelectTripPage> {
  @override
  void initState() {
    super.initState();
    context.read<BusTravelCubit>().getTripsByStage(
      widget.trip.fCenterNo,
      widget.trip.fStageNo,
    );
  }

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
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              context.read<BusTravelCubit>().getStageName(widget.trip.fStageNo),
              style: TextStyle(
                color: kMainColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                height: 1.20.h,
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
                    const Expanded(child: SelectBusesSearchField()),
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
                  : state.tripsByStage.isEmpty
                  ? const Center(child: Text('لا يوجد رحلات'))
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

                          itemCount: state.tripsByStage.length,
                          itemBuilder: (context, index) {
                            state.tripsByStage.sort(
                              (a, b) => a.fTripNo.compareTo(b.fTripNo),
                            );
                            final trip = state.tripsByStage[index];

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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      /// Trip No
                                      SizedBox(
                                        width: 50.w,
                                        height: 55.h,

                                        child: Text(
                                          trip.fTripNo,
                                          overflow: TextOverflow.fade,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: kDartTextColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),

                                      /// Trip date
                                      SizedBox(
                                        width: 100.w,
                                        height: 55.h,

                                        child: Text(
                                          formatText(trip.fTripDate),
                                          // trip.fTripDate.split('T')[0],
                                          overflow: TextOverflow.fade,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: kDartTextColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),

                                      /// Transport name
                                      SizedBox(
                                        width: 60.w,
                                        height: 55.h,
                                        child: Text(
                                          trip.company.fCompanyName.length > 12
                                              ? '${trip.company.fCompanyName.substring(0, 12)}...'
                                              : trip.company.fCompanyName,
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
                                        width: 75.w,
                                        height: 55.h,

                                        child: Text(
                                          trip.fBusId,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: kDartTextColor,
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
                                            const HeadTableInSelectTripCard(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,

                                              children: [
                                                /// Poligrams count
                                                SizedBox(
                                                  width: 40.w,
                                                  height: 40.h,
                                                  child: Text(
                                                    trip.fPilgrimsAco,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
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
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: kDartTextColor,
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),

                                                /// Arraivel Date
                                                SizedBox(
                                                  width: 90.w,
                                                  height: 40.h,

                                                  child: Text(
                                                    trip.fReceiptDate == 'null'
                                                        ? 'لدى الإنطلاق'
                                                        : trip.fReceiptDate
                                                            .split('T')[0],
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: kDartTextColor,
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),

                                                /// Arraivel Name
                                                SizedBox(
                                                  width: 90.w,
                                                  height: 40.h,

                                                  child: Text(
                                                    trip
                                                                .receiptUser
                                                                .fUserName ==
                                                            'string'
                                                        ? 'لم يتم الإستلام بعد'
                                                        : trip
                                                            .receiptUser
                                                            .fUserName,
                                                    textAlign: TextAlign.center,
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
                                            const H(h: 24),

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
                                                  getStatusIcon(
                                                    trip.fTripStatus,
                                                  ),
                                                ),
                                                Text(
                                                  getStatusText(
                                                    trip.fTripStatus,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.fade,
                                                  style: TextStyle(
                                                    color: getStatusColor(
                                                      trip.fTripStatus,
                                                    ),
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w500,
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
                                          child: selectBusesPopupMenuButton(
                                            context,
                                            trip,
                                            state.tripsByStage,
                                          ),
                                        ),
                                      ],
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
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(320.r),
            ),
            backgroundColor: kMainColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => AddTrip(
                        trip: widget.trip,
                        tripsByStage: state.tripsByStage,
                      ),
                ),
              );
            },
            child: const Icon(Icons.add, color: kMainColorLightColor),
          ),
        );
      },
    );
  }
}

String getStatusText(String status) {
  switch (status) {
    case '2':
      return 'مستلمة';
    case '3':
      return 'مستبدلة';
    default:
      return 'لدى التسليم';
  }
}

Color getStatusColor(String status) {
  switch (status) {
    case '2':
      return const Color(0xFF46C469);
    case '3':
      return Colors.purple;
    default:
      return Colors.orangeAccent;
  }
}

String getStatusIcon(String status) {
  switch (status) {
    case '2':
      return 'assets/svg/bus_status/done.svg';
    case '3':
      return 'assets/svg/bus_status/swap.svg';
    default:
      return 'assets/svg/bus_status/waiting.svg';
  }
}
