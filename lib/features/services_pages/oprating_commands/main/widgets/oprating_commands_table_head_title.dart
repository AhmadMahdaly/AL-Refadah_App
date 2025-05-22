import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpratingCommandsTableHeadTitle extends StatelessWidget {
  const OpratingCommandsTableHeadTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 12.h, left: 16.w, right: 16.w),
      height: 60.h,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 90.w,
            child: Text(
              'المركز',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                height: 1.h,
              ),
            ),
          ),
          SizedBox(
            width: 60.w,
            child: Text(
              'أمر التشغيل',
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
          SizedBox(
            width: 80.w,
            child: Text(
              'الحافلات المخصصة',
              textAlign: TextAlign.right,
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                height: 1.h,
              ),
            ),
          ),
          SizedBox(
            width: 80.w,

            child: Text(
              'الحافلات المستلمة',
              textAlign: TextAlign.right,
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                height: 1.h,
              ),
            ),
          ),
          const W(w: 10),
        ],
      ),
    );
  }
}
