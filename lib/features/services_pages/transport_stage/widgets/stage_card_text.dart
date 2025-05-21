import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';

class StageCardText extends StatelessWidget {
  const StageCardText({
    required this.text,
    required this.width,
    this.align = TextAlign.start,
    super.key,
  });
  final String text;
  final double width;
  final TextAlign align;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        textAlign: align,
        style: TextStyle(
          color: kDartTextColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
