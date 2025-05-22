import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';

class SelectIconStyle extends StatelessWidget {
  const SelectIconStyle(this.selectedIcon, {super.key});
  final String selectedIcon;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      selectedIcon,
      width: 26.sp,
      colorFilter: const ColorFilter.mode(kMainColor, BlendMode.srcIn),
    );
  }
}

class UnSelectIconStyle extends StatelessWidget {
  const UnSelectIconStyle(this.unselectedIcon, {super.key});
  final String unselectedIcon;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      unselectedIcon,
      width: 24.sp,
      colorFilter: const ColorFilter.mode(kTextColor, BlendMode.srcIn),
    );
  }
}
