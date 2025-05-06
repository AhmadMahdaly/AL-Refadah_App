import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashLogoWidget extends StatelessWidget {
  const SplashLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: 100.w,
            fit: BoxFit.contain,
          ),
          Image.asset(
            'assets/images/text logo.png', // Fixed file naming convention
            width: 217.w,
            height: 79.h,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
