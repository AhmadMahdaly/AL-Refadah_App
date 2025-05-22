import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/trip_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectApprovalTripsInCard extends StatelessWidget {
  const SelectApprovalTripsInCard({required this.trip, super.key});
  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Poligrams count
        SizedBox(
          width: 60.w,
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

        /// Logined Name
        SizedBox(
          width: 75.w,
          child: Text(
            trip.additionUser.fUserName.length > 12
                ? '${trip.additionUser.fUserName.substring(0, 12)}...'
                : trip.additionUser.fUserName,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kDartTextColor,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        if (trip.fTripStstus != '1')
          /// Arraivel Date
          SizedBox(
            width: 80.w,
            child: Text(
              trip.fReceiptDate == 'null'
                  ? 'لدى الإنطلاق'
                  : trip.fReceiptDate.split('T')[0],
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
          /// Arraivel Name
          SizedBox(
            width: 90.w,
            child: Text(
              trip.receiptUser.fUserName == 'string'
                  ? 'لم يتم الإستلام بعد'
                  : trip.receiptUser.fUserName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kDartTextColor,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
