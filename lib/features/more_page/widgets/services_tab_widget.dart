import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServicesTabWidget extends StatelessWidget {
  const ServicesTabWidget({
    required this.icon,
    required this.text,
    super.key,
    this.onTap,
  });
  final Widget icon;
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 65.h,
        padding: EdgeInsets.all(12.sp),
        decoration: ShapeDecoration(
          color: const Color(0xFFFCFCFC),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 0.50, color: Color(0xFFE9EAEB)),
            borderRadius: BorderRadius.circular(8.r),
          ),
          shadows: const [
            BoxShadow(
              color: kMainColorLightColor,
              blurRadius: 4,
              offset: Offset(1, 2),
            ),
          ],
        ),
        child: Row(
          spacing: 8.w,
          children: [
            icon,
            Text(
              text,
              style: TextStyle(
                color: kMainColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                height: 1.43.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
