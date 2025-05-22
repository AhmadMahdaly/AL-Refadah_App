import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StageHeadTitle extends StatelessWidget {
  const StageHeadTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 12.h, left: 16.w, right: 16.w),
      height: 90.h,
      padding: EdgeInsets.all(10.sp),
      decoration: ShapeDecoration(
        color: kMainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8.r),
            topLeft: Radius.circular(8.r),
          ),
        ),
      ),
      child: Row(
        spacing: 12.w,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// اسم المرحلة
          SizedBox(
            width: 80.w,
            child: Text(
              'اسم المرحلة',
              textAlign: TextAlign.center,
              style: TextStyle(
                overflow: TextOverflow.fade,
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                height: 1.5.h,
              ),
            ),
          ),

          /// من
          SizedBox(
            width: 40.w,
            child: Text(
              'من',
              textAlign: TextAlign.left,
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                height: 1.h,
              ),
            ),
          ),

          /// إلى
          SizedBox(
            width: 40.w,
            child: Text(
              'إلى',
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                height: 1.h,
              ),
            ),
          ),

          /// الزمن المتوقع للرحلة
          SizedBox(
            width: 50.w,
            child: Text(
              'الزمن المتوقع بالدقائق',
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                height: 1.5.h,
              ),
            ),
          ),

          /// الحالة
          SizedBox(
            width: 40.w,
            child: Text(
              'الحالة',
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                height: 1.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
