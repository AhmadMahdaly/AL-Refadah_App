import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/features/auth/screans/forget_password_screens/get_user_code_forget_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GetUserCodeForgetPasswordScreen(),
          ),
        );
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'نسيت كلمة المرور؟',
          style: TextStyle(
            color: kMainColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
