import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleAppBar extends StatelessWidget {
  const TitleAppBar({required this.title, super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: kMainColor,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        height: 1.20.h,
      ),
    );
  }
}
