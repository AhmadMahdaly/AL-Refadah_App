import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/buses_travel/incoming/select/widgets/incoming_confirm_dialog.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_state.dart';
import 'package:alrefadah/features/services_pages/buses_travel/select/widgets/get_trip_status_style.dart';
import 'package:alrefadah/features/services_pages/buses_travel/select/widgets/select_buses_travel_head_table_in_card.dart';
import 'package:alrefadah/features/services_pages/buses_travel/select/widgets/select_buses_travel_title_head.dart';
import 'package:alrefadah/features/services_pages/buses_travel/show/screens/show_trip.dart';

class SelectIncomingTripsBody extends StatelessWidget {
  const SelectIncomingTripsBody({required this.searchText, super.key});
  final String searchText;
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
        final trips = state.incomingTripsByStage;
        final filteredIncomingTrips =
            searchText.isEmpty
                ? (trips.toList()
                  ..sort((a, b) => b.fTripNo.compareTo(a.fTripNo)))
                : trips.where((trip) {
                  final fBusNo = trip.fBus.fBusNo.toLowerCase();
                  final fTripNo = trip.fTripNo;
                  final arabicSearch = convertArabicToLatin(searchText);
                  return fTripNo.contains(searchText) ||
                      fTripNo.contains(arabicSearch) ||
                      fBusNo.contains(arabicSearch) ||
                      fBusNo.contains(searchText);
                }).toList();
        return state.isLoadingIncomingTripByStage
            ? const AppIndicator()
            : filteredIncomingTrips == null || filteredIncomingTrips.isEmpty
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
                    itemCount: filteredIncomingTrips.length,
                    itemBuilder: (context, index) {
                      final trip = filteredIncomingTrips[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ExpansionTile(
                            shape: Border.all(color: kScaffoldBackgroundColor),
                            minTileHeight: 20.h,
                            collapsedIconColor: kMainColor,
                            iconColor: kMainColor,
                            collapsedBackgroundColor: kScaffoldBackgroundColor,
                            childrenPadding: EdgeInsets.zero,
                            tilePadding: EdgeInsets.zero,
                            title: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    trip.fBus.transport!.fTransportName.length >
                                            12
                                        ? '${trip.fBus.transport!.fTransportName}...'
                                            .replaceAll('الشركة', '')
                                            .replaceAll('شركة', '')
                                            .replaceAll('الشركه', '')
                                            .replaceAll('شركه', '')
                                        : trip.fBus.transport!.fTransportName
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      HeadTableInSelectTripCard(trip: trip),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          /// Poligrams count
                                          SizedBox(
                                            width: 40.w,
                                            height: 40.h,
                                            child: Text(
                                              trip.fPilgrimsAco,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Cairo',
                                                color: kDartTextColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),

                                          /// Addition User
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
                                                  : trip.additionUser.fUserName,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: kDartTextColor,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          if (trip.fTripStstus != '1')
                                            /// Receipt Date
                                            SizedBox(
                                              width: 90.w,
                                              height: 40.h,
                                              child: Text(
                                                trip.fReceiptDate == 'null'
                                                    ? 'لدى الإنطلاق'
                                                    : trip.fReceiptDate.split(
                                                      'T',
                                                    )[0],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  color: kDartTextColor,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          if (trip.fTripStstus != '1')
                                            /// Receipt User
                                            SizedBox(
                                              width: 90.w,
                                              height: 40.h,

                                              child: Text(
                                                trip.receiptUser.fUserName ==
                                                        'string'
                                                    ? 'لم يتم الإستلام بعد'
                                                    : trip
                                                        .receiptUser
                                                        .fUserName,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: kDartTextColor,
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500,
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
                                        borderRadius: BorderRadius.circular(
                                          5.r,
                                        ),
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
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
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
                                        }
                                        if (value == 'done') {
                                          if (context.mounted) {
                                            await confirmDialog(context, trip);
                                          }
                                        }
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return [
                                          PopupMenuItem(
                                            height: 40.h,
                                            value: 'show',
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/svg/view.svg',
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                        kMainColor,
                                                        BlendMode.srcIn,
                                                      ),
                                                ),

                                                W(w: 8.w),
                                                Text(
                                                  'مشاهدة',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: kMainColor,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w300,
                                                    height: 1.67.h,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

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
                                                    textAlign: TextAlign.center,
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
                                        ];
                                      },
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
                                getTripStatusIcon(trip.fTripStstus),
                              ),
                              Text(
                                getTripStatusText(trip.fTripStstus),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  color: getTripStatusColor(trip.fTripStstus),
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
            );
      },
    );
  }
}
