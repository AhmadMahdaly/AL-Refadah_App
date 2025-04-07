import 'dart:async';

import 'package:alrefadah/utils/components/width.dart';
import 'package:alrefadah/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTimerWidget extends StatefulWidget {
  const CustomTimerWidget({super.key});

  @override
  State<CustomTimerWidget> createState() => _CustomTimerWidgetState();
}

class _CustomTimerWidgetState extends State<CustomTimerWidget> {
  int timeLeft = 30; // المدة بالثواني
  Timer? timer;
  @override
  void initState() {
    super.initState();
    startTimer(); // بدء العد التنازلي
  }

  void startTimer() {
    setState(() {
      timeLeft = 30;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: startTimer,
          child: Text(
            'اعادة إرسال الرمز',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kMainColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              height: 1.20.h,
            ),
          ),
        ),
        W(w: 6.w),
        Text(
          '00:${timeLeft.toString().padLeft(2, '0')}',
          style: TextStyle(
            color: kMainColor,
            fontSize: 17.sp,
            fontFamily: 'FF Shamel Family',
            fontWeight: FontWeight.w600,
            height: 1.20.h,
          ),
        ),
      ],
    );
  }
}
