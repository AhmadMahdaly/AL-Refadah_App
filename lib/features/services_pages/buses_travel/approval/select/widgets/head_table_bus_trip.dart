import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';

class HeadTableInSelectBusTripCard extends StatelessWidget {
  const HeadTableInSelectBusTripCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 60.w,
          child: Text(
            'ردود الحافلة',
            textAlign: TextAlign.start,
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
            'الردود الفعلية',
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
          child: Text(
            'الردود المتبقية',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kAnalysisMediumColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          width: 80.w,
          child: Text(
            'الردود الإضافية',
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
