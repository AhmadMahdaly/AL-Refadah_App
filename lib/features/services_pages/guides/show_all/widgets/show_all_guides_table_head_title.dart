import 'package:alrefadah/core/themes/app_theme.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowAllGuidesTableHeadTitle extends StatelessWidget {
  const ShowAllGuidesTableHeadTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 12.h, left: 16.w, right: 16.w),
      height: 60.h,
      padding: EdgeInsets.all(10.sp),
      decoration: ShapeDecoration(
        gradient: customGradient(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8.r),
            topLeft: Radius.circular(8.r),
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              'رقم المرشد',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          Text(
            'اسم المرشد',
            textAlign: TextAlign.start,

            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          // Text(
          //   'الجنسية',
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontSize: 14.sp,
          //     fontWeight: FontWeight.w800,
          //   ),
          // ),
          const W(w: 10),
        ],
      ),
    );
  }
}
