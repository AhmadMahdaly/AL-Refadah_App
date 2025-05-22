import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';

class TabItemName extends StatelessWidget {
  const TabItemName({required this.title, super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: kMainColor,
        fontSize: 13.sp,
        fontFamily: 'GE SS Two',
        fontWeight: FontWeight.w500,
        height: 1.54.h,
      ),
    );
  }
}
