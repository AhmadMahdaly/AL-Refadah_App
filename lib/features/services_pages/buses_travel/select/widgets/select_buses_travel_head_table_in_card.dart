import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeadTableInSelectTripCard extends StatelessWidget {
  const HeadTableInSelectTripCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 50.w,
          height: 40.h,
          child: Text(
            'عدد الحجاج   ',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: kAnalysisMediumColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          width: 80.w,
          height: 40.h,
          child: Text(
            'اسم المرحل',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: kAnalysisMediumColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          width: 80.w,
          height: 40.h,
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
        SizedBox(
          width: 90.w,
          height: 40.h,
          child: Text(
            'اسم المستلم',
            textAlign: TextAlign.left,
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
