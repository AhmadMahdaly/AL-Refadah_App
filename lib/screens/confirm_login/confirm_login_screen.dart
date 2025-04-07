import 'package:alrefadah/screens/confirm_login/widgets/confirm_card_login_number_widget.dart';
import 'package:alrefadah/screens/confirm_login/widgets/custom_timer_widget.dart';
import 'package:alrefadah/screens/confirm_login/widgets/title_of_confirm_login_widget.dart';
import 'package:alrefadah/screens/home_page/home_page.dart';
import 'package:alrefadah/utils/components/custom_button.dart';
import 'package:alrefadah/utils/components/height.dart';
import 'package:alrefadah/utils/constants/colors_constants.dart';
import 'package:alrefadah/widgets/end_of_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ConfirmLoginScreen extends StatefulWidget {
  const ConfirmLoginScreen({super.key});

  @override
  State<ConfirmLoginScreen> createState() => _ConfirmLoginScreenState();
}

class _ConfirmLoginScreenState extends State<ConfirmLoginScreen> {
  bool _onEditing = true;
  String? code;
  bool _isInAsyncCall = false;
  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _isInAsyncCall,
        opacity: 0.5,
        progressIndicator: const CircularProgressIndicator(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              bottom: isKeyboardVisible ? -260 : 0,
              left: 0,
              right: 0,
              child: const EndOfPage(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const H(h: 40),
                      Image.asset('assets/images/logo.png', width: 110.w),
                      const H(h: 20),
                      const TitleOfConfirmLoginWidget(),
                      const H(h: 16),
                      const ConfirmCardLoginNumberWidget(),
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
                        length: 6,
                        margin: EdgeInsets.symmetric(horizontal: 2.sp),
                        underlineWidth: 1,
                        itemSize: 48.sp,
                        textStyle: TextStyle(
                          fontSize: 22.sp,
                          color: kMainColor,
                          fontFamily: 'FF Shamel Family',
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
                      const CustomTimerWidget(),
                      const H(h: 60),
                      CustomButton(
                        isActive: code != null,
                        text: 'تأكيد',
                        onTap: () async {
                          if (code != null &&
                              code!.length == 6 &&
                              code == dotenv.env['VRCODE']) {
                            setState(() {
                              _isInAsyncCall = true;
                            });
                            await Future.delayed(
                              const Duration(seconds: 2),
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                );
                              },
                            );
                            setState(() {
                              _isInAsyncCall = false;
                            });
                          } else {
                            setState(() {
                              _isInAsyncCall = true;
                            });
                            await Future.delayed(
                              const Duration(seconds: 2),
                              () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('الرمز غير صحيح'),
                                    backgroundColor: kMainColor,
                                  ),
                                );
                              },
                            );
                            setState(() {
                              _isInAsyncCall = false;
                            });
                          }
                        },
                      ),
                      const H(h: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
