import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    required this.text,
    required this.number,
    super.key,
    this.left = 0,
    this.right = 0,
  });

  final String text;
  final num number;
  final int? left;
  final int? right;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 100.h,
      margin: EdgeInsets.only(left: left!.w, right: right!.w),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 10,
            offset: Offset(6, 6),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 44.h,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kMainColor,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.43.h,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          Container(
            height: 50.h,
            decoration: const ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment(0, 0.50),
                end: Alignment(1, 0.50),
                colors: [Color(0xFF6400CA), Color(0xFF6946C4)],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Center(
              child: Text(
                number.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kMainExtrimeLightColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.43.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
