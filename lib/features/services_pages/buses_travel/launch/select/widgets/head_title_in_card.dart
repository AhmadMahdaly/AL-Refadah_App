import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeadInsideCard extends StatelessWidget {
  const HeadInsideCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
        SizedBox(
          child: Text(
            'حالة الرحلة:',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kAnalysisMediumColor,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
