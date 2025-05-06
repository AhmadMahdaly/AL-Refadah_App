import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeadTitle extends StatelessWidget {
  const HeadTitle({required this.title, super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: const Color(0xFF58595B),
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        height: 1.20.h,
      ),
    );
  }
}
