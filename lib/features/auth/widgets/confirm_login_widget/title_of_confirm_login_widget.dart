import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';

class TitleOfConfirmLoginWidget extends StatelessWidget {
  const TitleOfConfirmLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'تسجيل الدخول إلى حسابك',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: kMainColor,
        fontSize: 21.sp,
        fontWeight: FontWeight.w800,
        height: 1.20.h,
      ),
    );
  }
}
