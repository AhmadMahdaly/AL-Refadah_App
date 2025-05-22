import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DelayedTripHeadTitle extends StatelessWidget {
  const DelayedTripHeadTitle({super.key, this.padding = 25});
  final int? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: padding!.w),
      width: double.infinity,
      height: 100.h,
      padding: EdgeInsets.all(10.sp),
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: Alignment(0, 0.50),
          end: Alignment(1, 0.50),
          colors: [Color(0xFF6400CA), Color(0xFF6946C4)],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12.r),
            topLeft: Radius.circular(12.r),
          ),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 10,
            offset: Offset(6, 6),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        spacing: 12.w,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// رقم الرحلة
          SizedBox(
            width: 50.w,
            child: Text(
              'رقم الرحلة',
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

          /// وقت الإنطلاق
          SizedBox(
            width: 50.w,
            child: Text(
              'وقت الإنطلاق',
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

          /// وقت الوصول
          SizedBox(
            width: 50.w,
            child: Text(
              'وقت الوصول',
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

          /// الوصول المتوقع بالدقائق
          SizedBox(
            width: 50.w,
            child: Text(
              'الوصول المتوقع بالدقائق',
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

          /// التأخير بالدقائق
          SizedBox(
            width: 50.w,
            child: Text(
              'التأخير بالدقائق',
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
        ],
      ),
    );
  }
}
