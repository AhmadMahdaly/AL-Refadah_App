import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/trip_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeadTableInSelectTripCard extends StatelessWidget {
  const HeadTableInSelectTripCard({required this.trip, super.key});
  final TripModel trip;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 60.w,
          child: Text(
            'عدد الحجاج',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kAnalysisMediumColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          width: 75.w,
          child: Text(
            'اسم المرحل',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kAnalysisMediumColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        if (trip.fTripStstus != '1')
          SizedBox(
            width: 80.w,
            child: Text(
              'تاريخ الوصول',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kAnalysisMediumColor,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        if (trip.fTripStstus != '1')
          SizedBox(
            width: 90.w,
            child: Text(
              'اسم المستلم',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kAnalysisMediumColor,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
