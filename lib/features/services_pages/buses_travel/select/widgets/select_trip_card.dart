import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/approval/select/widgets/head_table_bus_trip.dart';
import 'package:alrefadah/features/services_pages/buses_travel/select/widgets/get_trip_status_style.dart';
import 'package:alrefadah/features/services_pages/buses_travel/select/widgets/popup_widgets/select_buses_travel_popup_button.dart';
import 'package:alrefadah/features/services_pages/buses_travel/select/widgets/select_buses_travel_head_table_in_card.dart';

class SelectTripCard extends StatefulWidget {
  const SelectTripCard({
    required this.remainingTripsCount,
    required this.additionTrip,
    required this.trip,
    required this.tripsByStage,
    super.key,
  });
  final int remainingTripsCount;
  final int additionTrip;
  final TripModel trip;
  final List<TripModel> tripsByStage;

  @override
  State<SelectTripCard> createState() => _SelectTripCardState();
}

class _SelectTripCardState extends State<SelectTripCard> {
  String formatText(String input) {
    if (input.length < 8) return input;

    final part1 = input.substring(0, 4); // rrrr
    final part2 = input.substring(4, 6); // tt
    final part3 = input.substring(6); // yy

    return '$part1-$part2-$part3';
  }

  @override
  Widget build(BuildContext context) {
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
                  widget.trip.fTripNo,
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
                  formatText(widget.trip.fTripDate),
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
                  widget.trip.fBus.transport!.fTransportName.length > 12
                      ? '${widget.trip.fBus.transport!.fTransportName}...'
                          .replaceAll('الشركة', '')
                          .replaceAll('شركة', '')
                          .replaceAll('الشركه', '')
                          .replaceAll('شركه', '')
                      : widget.trip.fBus.transport!.fTransportName
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
                  widget.trip.fBus.fBusNo,
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
            /// Socend card
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    HeadTableInSelectTripCard(trip: widget.trip),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Poligrams count
                        SizedBox(
                          width: 60.w,
                          child: Text(
                            widget.trip.fPilgrimsAco,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              color: kDartTextColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        /// Logined Name
                        SizedBox(
                          width: 75.w,
                          child: Text(
                            widget.trip.additionUser.fUserName.length > 12
                                ? '${widget.trip.additionUser.fUserName.substring(0, 12)}...'
                                : widget.trip.additionUser.fUserName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kDartTextColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        if (widget.trip.fTripStstus != '1')
                          /// Arraivel Date
                          SizedBox(
                            width: 80.w,
                            child: Text(
                              widget.trip.fReceiptDate == 'null'
                                  ? 'لدى الإنطلاق'
                                  : widget.trip.fReceiptDate.split('T')[0],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: kDartTextColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        if (widget.trip.fTripStstus != '1')
                          /// Arraivel Name
                          SizedBox(
                            width: 90.w,
                            child: Text(
                              widget.trip.receiptUser.fUserName == 'string'
                                  ? 'لم يتم الإستلام بعد'
                                  : widget.trip.receiptUser.fUserName,
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
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                  child: selectBusesPopupMenuButton(
                    context,
                    widget.trip,
                    widget.tripsByStage,
                  ),
                ),
              ],
            ),
            const H(h: 16),

            /// Third & last card
            /// Head last Row
            const HeadTableInSelectBusTripCard(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// ردود الحافلة
                SizedBox(
                  width: 60.w,
                  child: Text(
                    widget.trip.fBus.fTripAco.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: kDartTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                /// الردود الفعلية
                SizedBox(
                  width: 75.w,
                  child: Text(
                    widget.trip.busOccurrencesCount,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: kDartTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                /// الردود المتبقية
                SizedBox(
                  width: 80.w,
                  child: Text(
                    widget.remainingTripsCount.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: kDartTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                /// الردود الإضافية
                SizedBox(
                  width: 80.w,
                  child: Text(
                    widget.additionTrip.toString(),
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
            SvgPicture.asset(getTripStatusIcon(widget.trip.fTripStstus)),
            Text(
              getTripStatusText(widget.trip.fTripStstus),
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: getTripStatusColor(widget.trip.fTripStstus),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const Divider(color: kTextColor),
      ],
    );
  }
}
