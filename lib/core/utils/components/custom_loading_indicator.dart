import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppIndicator extends StatelessWidget {
  const AppIndicator({super.key, this.size = 50});
  final double size;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Center(
        child: SpinKitSpinningLines(
          size: size.sp,
          color: kMainColor.withAlpha(70),
        ),
      ),
    );
  }
}
