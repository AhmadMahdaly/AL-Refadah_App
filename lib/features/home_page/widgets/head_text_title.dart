import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeadTitle extends StatelessWidget {
  const HeadTitle({required this.title, super.key, this.padding = 25});
  final String title;
  final int? padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding!.w),
      child: Text(
        title,
        style: TextStyle(
          color: const Color(0xFF58595B),
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          height: 1.20.h,
        ),
      ),
    );
  }
}
