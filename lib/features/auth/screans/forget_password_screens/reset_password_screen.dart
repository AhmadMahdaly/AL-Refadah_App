import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_textfield_with_hint.dart';
import 'package:alrefadah/features/auth/screans/login_screen.dart';
import 'package:alrefadah/presentation/app/shared_widgets/end_of_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final bool _isInAsyncCall = false;
  final _userCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isHidenPassword = true;
  @override
  void dispose() {
    super.dispose();
    _userCodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: ModalProgressHUD(
        inAsyncCall: _isInAsyncCall,
        opacity: 0.5,
        progressIndicator: const AppIndicator(),
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const H(h: 40),
                        Image.asset('assets/images/logo.png', width: 110.w),
                        const H(h: 20),
                        Text(
                          'إستعادة كلمة المرور',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kMainColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            height: 1.20.h,
                          ),
                        ),
                        const H(h: 16),
                        Text(
                          'الرجاء إدخال كلمة المرور الجديدة',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kGrayColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                            height: 1.43.h,
                          ),
                        ),
                        const H(h: 40),

                        CustomTextformfieldWithHint(
                          controller: _userCodeController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال كلمة المرور';
                            }
                            return null;
                          },
                          text: 'كلمة المرور',
                          passwordIcon: IconButton(
                            onPressed:
                                () => setState(() {
                                  isHidenPassword = !isHidenPassword;
                                }),
                            icon:
                                isHidenPassword
                                    ? SvgPicture.asset(
                                      'assets/svg/eye.svg',
                                      fit: BoxFit.none,
                                    )
                                    : SvgPicture.asset(
                                      'assets/svg/EyeClosed.svg',
                                      fit: BoxFit.none,
                                    ),
                          ),
                          obscureText: isHidenPassword,
                          autofillHints: const [AutofillHints.password],
                        ),

                        const H(h: 20),
                        CustomTextformfieldWithHint(
                          controller: _userCodeController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال تأكيد كلمة المرور';
                            }
                            return null;
                          },
                          text: 'تأكيد كلمة المرور',
                          passwordIcon: IconButton(
                            onPressed:
                                () => setState(() {
                                  isHidenPassword = !isHidenPassword;
                                }),
                            icon:
                                isHidenPassword
                                    ? SvgPicture.asset(
                                      'assets/svg/eye.svg',
                                      fit: BoxFit.none,
                                    )
                                    : SvgPicture.asset(
                                      'assets/svg/EyeClosed.svg',
                                      fit: BoxFit.none,
                                    ),
                          ),
                          obscureText: isHidenPassword,
                          autofillHints: const [AutofillHints.password],
                        ),
                        const H(h: 40),
                        CustomButton(
                          text: 'تغيير كلمة المرور',
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              // _isInAsyncCall = true;
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) => false,
                              );
                            }
                          },
                        ),
                      ],
                    ),
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
