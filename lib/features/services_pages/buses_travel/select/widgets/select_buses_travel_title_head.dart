import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectBusesHeadTitle extends StatelessWidget {
  const SelectBusesHeadTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 12.h, left: 16.w, right: 16.w),
      height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 50.w,
            child: Text(
              'رقم الرحلة',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w800,
                height: 1.h,
              ),
            ),
          ),

          SizedBox(
            width: 100.w,
            child: Text(
              'تاريخ الرحلة',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w800,
                height: 1.h,
              ),
            ),
          ),
          SizedBox(
            width: 70.w,
            child: Text(
              'الشركة الناقلة',
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w800,
                height: 1.h,
              ),
            ),
          ),
          SizedBox(
            width: 70.w,
            child: Text(
              'رقم الحافلة',
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w800,
                height: 1.h,
              ),
            ),
          ),
          W(w: 2.w),
        ],
      ),
    );
  }
}
