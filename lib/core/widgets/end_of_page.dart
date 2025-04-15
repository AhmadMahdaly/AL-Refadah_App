import 'package:alrefadah/core/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EndOfPage extends StatelessWidget {
  const EndOfPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          kMainColor.withAlpha(20),
          BlendMode.srcIn,
        ),
        child: Image.asset(
          'assets/images/endOfPage.png',
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
