import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';

class RegisterTitle extends StatelessWidget {
  const RegisterTitle({required this.text, super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h, top: 18.h),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kMainColor,
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
          height: 1.43.h,
        ),
      ),
    );
  }
}
