import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/approval/select/widgets/approval_trip_oprating.dart';
import 'package:alrefadah/features/services_pages/buses_travel/approval/select/widgets/head_table_bus_trip.dart';
import 'package:alrefadah/features/services_pages/buses_travel/approval/select/widgets/select_approval_trips_in_card.dart';
import 'package:alrefadah/features/services_pages/buses_travel/approval/select/widgets/select_approval_trips_in_card_trip_count.dart';
import 'package:alrefadah/features/services_pages/buses_travel/approval/select/widgets/trip_status.dart';
import 'package:alrefadah/features/services_pages/buses_travel/select/widgets/select_buses_travel_head_table_in_card.dart';

class SelectApprovalTripsCard extends StatelessWidget {
  const SelectApprovalTripsCard({
    required this.remainingTripsCount,
    required this.additionTrip,
    required this.trip,
    super.key,
  });
  final int remainingTripsCount;
  final int additionTrip;
  final TripModel trip;
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
                  trip.fBus.transport!.fTransportName.length > 12
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
            /// Sec Card
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    HeadTableInSelectTripCard(trip: trip),
                    SelectApprovalTripsInCard(trip: trip),
                  ],
                ),
                const Spacer(),

                /// Popup Menu Button
                ApprovalTripOprating(trip: trip),
              ],
            ),

            /// Third Card
            const H(h: 16),
            const HeadTableInSelectBusTripCard(),
            SelectApprovalTripsInCardTripCount(
              trip: trip,
              remainingTripsCount: remainingTripsCount,
              additionTrip: additionTrip,
            ),
          ],
        ),

        /// Trip Status
        TripStatus(trip: trip),
        const Divider(color: kTextColor),
      ],
    );
  }
}
