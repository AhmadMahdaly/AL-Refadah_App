import 'package:alrefadah/screens/confirm_login/confirm_login_screen.dart';
import 'package:alrefadah/utils/components/custom_button.dart';
import 'package:alrefadah/utils/components/custom_textformfield.dart';
import 'package:alrefadah/utils/components/height.dart';
import 'package:alrefadah/utils/components/width.dart';
import 'package:alrefadah/utils/constants/colors_constants.dart';
import 'package:alrefadah/widgets/end_of_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isShowPassword = true;
  bool isChecked = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const H(h: 40),
              Image.asset('assets/images/logo.png', width: 110.w),
              const H(h: 20),
              Text(
                'اهلا بك في شركة الرفادة',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kMainColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  height: 1.20.h,
                ),
              ),
              const H(h: 12),
              Text(
                'تسجيل الدخول لحسابك',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w300,
                  height: 1.20.h,
                ),
              ),
              const H(h: 32),
              CustomTextformfield(
                text: 'اسم المستخدم',
                icon: SvgPicture.asset(
                  'assets/svg/user.svg',
                  fit: BoxFit.none,
                  width: 16.w,
                  height: 16.h,
                ),
                keyboardType: TextInputType.emailAddress,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 18.h,
                  horizontal: 10.w,
                ),
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
              ),
              const H(h: 20),
              CustomTextformfield(
                text: 'كلمة المرور',
                icon: SvgPicture.asset(
                  'assets/svg/lock.svg',
                  fit: BoxFit.none,
                  width: 16.w,
                  height: 16.h,
                ),
                passwordIcon: IconButton(
                  onPressed:
                      () => setState(() {
                        isShowPassword = !isShowPassword;
                      }),
                  icon:
                      isShowPassword
                          ? SvgPicture.asset(
                            'assets/svg/eye.svg',
                            fit: BoxFit.none,
                          )
                          : SvgPicture.asset(
                            'assets/svg/EyeClosed.svg',
                            fit: BoxFit.none,
                          ),
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: isShowPassword,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 18.h,
                  horizontal: 10.w,
                ),
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.password],
              ),
              const H(h: 14),
              Align(
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
              const H(h: 40),
              Container(
                width: 297.w,
                height: 72.h,
                decoration: ShapeDecoration(
                  color: const Color(0xFFF9F9F9),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 0.84.w,
                      color: const Color(0xFFD3D3D3),
                    ),
                    borderRadius: BorderRadius.circular(2.53),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 3.37,
                      spreadRadius: 0.84,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    W(w: 16.w),
                    Image.asset(
                      'assets/images/recaptcha.png',
                      width: 60.w,
                      height: 60.h,
                    ),
                    const Spacer(),
                    Text(
                      "I'm not a robot",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    if (isLoading)
                      Container(
                        margin: EdgeInsets.only(right: 14.w, left: 14.w),
                        alignment: Alignment.center,
                        height: 20.h,
                        width: 20.w,
                        child: const CircularProgressIndicator(
                          color: kMainColor,
                          strokeWidth: 2,
                        ),
                      )
                    else
                      Checkbox(
                        value: isChecked,
                        activeColor: kMainColor,
                        checkColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        side: const BorderSide(color: Colors.grey, width: 2),

                        onChanged: (value) async {
                          setState(() {
                            isLoading = true;
                          });
                          await Future.delayed(
                            const Duration(seconds: 2),
                            () {},
                          );

                          setState(() {
                            isChecked = value!;
                            isLoading = false;
                          });
                        },
                      ),
                    W(w: 10.w),
                  ],
                ),
              ),
              const H(h: 30),
              CustomButton(
                text: 'تسجيل الدخول',
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ConfirmLoginScreen(),
                      ),
                    ),
              ),
              const H(h: 20),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'ليس لديك حساب؟ ',
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.20.h,
                      ),
                    ),
                    TextSpan(
                      text: 'مستخدم جديد',
                      style: TextStyle(
                        color: kMainColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.20.h,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const H(h: 25),
            ],
          ),
        ),
      ),
      bottomNavigationBar: EndOfPage(),
    );
  }
}
