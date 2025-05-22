import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_number_textfield.dart';
import 'package:alrefadah/features/auth/screens/forget_password_screens/reset_password_screen.dart';
import 'package:alrefadah/features/auth/widgets/confirm_login_widget/custom_timer_widget.dart';
import 'package:alrefadah/presentation/app/shared_widgets/end_of_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class GetVerificationCodeForgetPasswordScreen extends StatefulWidget {
  const GetVerificationCodeForgetPasswordScreen({super.key});

  @override
  State<GetVerificationCodeForgetPasswordScreen> createState() =>
      _GetVerificationCodeForgetPasswordScreenState();
}

class _GetVerificationCodeForgetPasswordScreenState
    extends State<GetVerificationCodeForgetPasswordScreen> {
  List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  String code = '';
  final bool _isInAsyncCall = false;
  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
    for (final focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
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
                        SizedBox(
                          width: 250.w,
                          child: Text(
                            'الرجاء إدخال كلمة المرور المرسلة إلى جوالك ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kGrayColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                              height: 1.43.h,
                            ),
                          ),
                        ),
                        const H(h: 40),

                        /// Verification code
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Row(
                            spacing: 8.w,
                            children: List.generate(6, (index) {
                              return Expanded(
                                child: CustomNumberTextformfield(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  textAlign: TextAlign.center,
                                  controller: controllers[index],
                                  focusNode: focusNodes[index],
                                  maxLength: 1,
                                  textInputAction:
                                      index == 5
                                          ? TextInputAction.done
                                          : TextInputAction.next,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      if (index < focusNodes.length - 1) {
                                        FocusScope.of(
                                          context,
                                        ).requestFocus(focusNodes[index + 1]);
                                      } else {
                                        FocusScope.of(context).unfocus();
                                      }
                                    } else {
                                      if (index > 0) {
                                        FocusScope.of(
                                          context,
                                        ).requestFocus(focusNodes[index - 1]);
                                      }
                                    }

                                    // تحديث المتغير code
                                    setState(() {
                                      code =
                                          controllers.map((c) => c.text).join();
                                    });
                                  },
                                ),
                              );
                            }),
                          ),
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

                        /// timer
                        const CustomTimerWidget(),
                        const H(h: 60),
                        CustomButton(
                          text: 'تأكيد',
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const ResetPasswordScreen(),
                                ),
                              );
                            }
                          },
                        ),
                        const H(h: 20),
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
