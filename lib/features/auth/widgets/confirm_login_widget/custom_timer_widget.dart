import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/auth/cubit/auth_cubit.dart';

class CustomTimerWidget extends StatefulWidget {
  const CustomTimerWidget({super.key});

  @override
  State<CustomTimerWidget> createState() => _CustomTimerWidgetState();
}

class _CustomTimerWidgetState extends State<CustomTimerWidget> {
  bool isButtonDisabled = false; // لمنع الضغط على الزر أثناء العد التنازلي
  int timeLeft = 30; // المدة بالثواني
  Timer? timer;
  @override
  void initState() {
    super.initState();
    startTimer(); // بدء العد التنازلي
  }

  void startTimer() {
    setState(() {
      isButtonDisabled = true;
      timeLeft = 30;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          isButtonDisabled = false;
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
          onTap:
              isButtonDisabled
                  ? null
                  : () async {
                    startTimer(); // إعادة بدء العد التنازلي عند الضغط على الزر
                    setState(() {
                      isButtonDisabled = true; // تعطيل الزر أثناء العد التنازلي
                    });
                    await context.read<AuthCubit>().resendOTP();
                  },
          child: Text(
            'اعادة إرسال الرمز',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isButtonDisabled ? kTextColor : kMainColor,
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
            color: isButtonDisabled ? kTextColor : kMainColor,
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
