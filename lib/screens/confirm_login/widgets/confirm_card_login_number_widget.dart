import 'package:alrefadah/utils/components/width.dart';
import 'package:alrefadah/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmCardLoginNumberWidget extends StatelessWidget {
  const ConfirmCardLoginNumberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 309.w,
      height: 62.h,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50.w, color: const Color(0xFFF3E7FF)),

          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'تم إرسال رمز التحقق إلى:',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF494949),
              fontSize: 13.sp,
              fontWeight: FontWeight.w300,
              height: 1.54.h,
            ),
          ),
          W(w: 10.w),
          Text(
            '55689056***',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kTextColor,
              fontSize: 13.sp,
              fontFamily: 'FF Shamel Family',
              fontWeight: FontWeight.w300,
              height: 1.54.h,
            ),
          ),
        ],
      ),
    );
  }
}
