import 'package:alrefadah/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppWelcome extends StatelessWidget {
  const AppWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'اهلا بك في شركة الرفادة',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: kMainColor,
        fontSize: 20.sp,
        fontWeight: FontWeight.w800,
        height: 1.20.h,
      ),
    );
  }
}
