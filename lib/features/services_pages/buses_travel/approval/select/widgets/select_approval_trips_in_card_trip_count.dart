import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/trip_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectApprovalTripsInCardTripCount extends StatelessWidget {
  const SelectApprovalTripsInCardTripCount({
    required this.trip,
    required this.remainingTripsCount,
    required this.additionTrip,
    super.key,
  });

  final TripModel trip;
  final int remainingTripsCount;
  final int additionTrip;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }
}
