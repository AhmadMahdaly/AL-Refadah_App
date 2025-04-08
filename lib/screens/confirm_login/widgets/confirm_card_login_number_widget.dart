import 'package:alrefadah/utils/components/width.dart';
import 'package:alrefadah/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmCardLoginNumberWidget extends StatelessWidget {
  const ConfirmCardLoginNumberWidget({required this.phoneNumber, super.key});
  final String phoneNumber;
  String maskExceptLast4(String phoneNumber) {
    if (phoneNumber.length <= 4) return phoneNumber;
    final last4 = phoneNumber.substring(phoneNumber.length - 4);
    return '*' * (phoneNumber.length - 4) + last4;
  }

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
            maskExceptLast4(phoneNumber),
            textDirection: TextDirection.ltr,
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
