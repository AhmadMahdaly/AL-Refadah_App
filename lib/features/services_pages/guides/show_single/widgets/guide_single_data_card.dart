import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuideSingleDataCard extends StatelessWidget {
  const GuideSingleDataCard({
    required this.title,
    required this.info,
    super.key,
  });
  final String title;
  final String info;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      width: MediaQuery.of(context).size.width,
      decoration: ShapeDecoration(
        color: kMainExtrimeLightColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10.h,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16.h, right: 16.w),
            child: Text(
              title,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: kMainColor,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                height: 1.85.h,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16.h, right: 16.w),
            child: Text(
              info,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: kDartTextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
