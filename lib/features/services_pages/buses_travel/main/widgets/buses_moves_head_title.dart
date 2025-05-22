import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';

class BusesMovesHeadTitle extends StatelessWidget {
  const BusesMovesHeadTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 2.h, left: 16.w, right: 16.w),
      height: 80.h,

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
          W(w: 0.w),
          SizedBox(
            width: 45.w,
            child: Text(
              'الحالة',
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w800,
                height: 1.5.h,
              ),
            ),
          ),
          SizedBox(
            width: 75.w,
            child: Text(
              'المرحلة',
              textAlign: TextAlign.center,
              style: TextStyle(
                overflow: TextOverflow.fade,
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w800,
                height: 1.5.h,
              ),
            ),
          ),

          SizedBox(
            width: 60.w,
            child: Text(
              'المخصص',
              textAlign: TextAlign.center,
              style: TextStyle(
                overflow: TextOverflow.fade,
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w800,
                height: 1.5.h,
              ),
            ),
          ),
          SizedBox(
            width: 50.w,
            child: Text(
              'المرحل',
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w800,
                height: 1.5.h,
              ),
            ),
          ),
          SizedBox(
            width: 50.w,
            child: Text(
              'المتبقي',
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w800,
                height: 1.5.h,
              ),
            ),
          ),
          W(w: 40.w),
        ],
      ),
    );
  }
}
