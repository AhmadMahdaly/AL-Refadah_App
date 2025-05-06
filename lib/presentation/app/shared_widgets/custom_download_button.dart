import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomDownloadButton extends StatelessWidget {
  const CustomDownloadButton({super.key, this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46.w,
      height: 46.h,
      padding: EdgeInsets.all(5.sp),
      decoration: ShapeDecoration(
        color: kMainColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: SvgPicture.asset(
          'assets/svg/download.svg',
          height: 30.h,
          fit: BoxFit.none,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }
}
