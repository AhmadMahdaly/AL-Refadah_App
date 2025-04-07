import 'dart:async';

import 'package:alrefadah/utils/components/height.dart';
import 'package:alrefadah/utils/components/width.dart';
import 'package:alrefadah/utils/constants/colors_constants.dart';
import 'package:alrefadah/widgets/end_of_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

class ConfirmLoginScreen extends StatefulWidget {
  const ConfirmLoginScreen({super.key});

  @override
  State<ConfirmLoginScreen> createState() => _ConfirmLoginScreenState();
}

class _ConfirmLoginScreenState extends State<ConfirmLoginScreen> {
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

  bool _onEditing = true;
  String? code;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const H(h: 40),
                Image.asset('assets/images/logo.png', width: 110.w),
                const H(h: 20),
                Text(
                  'تسجيل الدخول إلى حسابك',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kMainColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const H(h: 16),
                Text(
                  'أكد هويتك',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    height: 1.43.h,
                  ),
                ),
                const H(h: 10),
                Text(
                  'الرجاء إدخال كلمة المرور المرسلة ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w200,
                    height: 1.43.h,
                  ),
                ),
                const H(h: 30),
                VerificationCode(
                  length: 4,
                  margin: EdgeInsets.symmetric(horizontal: 8.sp),
                  underlineWidth: 1.2,
                  itemSize: 60.sp,
                  textStyle: TextStyle(
                    fontSize: 22.sp,
                    color: kMainColor,
                    fontWeight: FontWeight.w700,
                  ),
                  fullBorder: true,
                  underlineColor: kMainColor,
                  underlineUnfocusedColor: const Color(0xFFD3D3D3),
                  cursorColor: const Color(0xFFFCFCFC),
                  onCompleted: (String value) {
                    setState(() {
                      code = value;
                    });
                  },
                  onEditing: (bool value) {
                    setState(() {
                      _onEditing = value;
                    });
                    if (!_onEditing) FocusScope.of(context).unfocus();
                  },
                ),
                const H(h: 36),
                Text(
                  'لم تتلقى الرمز؟',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.20.h,
                  ),
                ),
                const H(h: 16),
                Row(
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
                    W(w: 12.w),
                    Text(
                      timeLeft.toString().padLeft(2, '0'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kMainColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.20.h,
                      ),
                    ),
                  ],
                ),
                const H(h: 32),
                Container(
                  width: 309.w,
                  height: 62.h,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.50.w, color: kMainColor),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'تم إرسال رمز التحقق إلى:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kTextColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w300,
                          height: 1.54.h,
                        ),
                      ),
                      W(w: 10.w),

                      Text(
                        '***55689056',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kTextColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.54.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const EndOfPage(),
    );
  }
}
