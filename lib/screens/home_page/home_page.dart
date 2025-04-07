import 'package:alrefadah/utils/components/height.dart';
import 'package:alrefadah/utils/components/width.dart';
import 'package:alrefadah/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const H(h: 30),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 30.h,
                width: 130.w,
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/logo.png'),
                    Image.asset('assets/images/text logo.png'),
                  ],
                ),
              ),
            ),
            const H(h: 20),
            Row(
              children: [
                Container(
                  width: 60.w,
                  height: 60.h,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(320.r),
                  ),
                  child: Image.asset(
                    'assets/images/user.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                W(w: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'أهلا بك',
                      style: TextStyle(
                        color: kMainColor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.23.h,
                      ),
                    ),
                    const H(h: 10),
                    Text(
                      'عبدالله محمد',
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                        height: 1.14.h,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
