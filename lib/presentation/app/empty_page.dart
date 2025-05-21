import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, toolbarHeight: 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              color: kMainColor.withAlpha(50),
              height: 150.w,
            ),
            const H(h: 8),
            Image.asset(
              'assets/images/text logo.png',
              color: kMainColor.withAlpha(50),
              width: 180.w,
              height: 80.h,
            ),
          ],
        ),
      ),
    );
  }
}
