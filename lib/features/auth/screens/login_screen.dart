import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_textfield_with_hint.dart';
import 'package:alrefadah/core/widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/core/widgets/show_snackbar.dart';
import 'package:alrefadah/features/auth/cubit/auth_cubit.dart';
import 'package:alrefadah/features/auth/cubit/auth_states.dart';
import 'package:alrefadah/features/auth/screens/confirm_login_screen.dart';
// import 'package:alrefadah/features/auth/screans/register_screen.dart';
import 'package:alrefadah/features/auth/widgets/login_page_widgets/app_welcome_widget.dart';
// import 'package:alrefadah/features/auth/widgets/login_page_widgets/forget_password_widget.dart';
import 'package:alrefadah/features/auth/widgets/login_page_widgets/login_button.dart';
import 'package:alrefadah/features/auth/widgets/login_page_widgets/title_of_welcome_page_widget.dart';
import 'package:alrefadah/presentation/app/shared_widgets/end_of_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isHidenPassword = true;
  bool isChecked = false;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();
  final FocusNode nameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    nameFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ConfirmLoginScreen()),
          );
        } else if (state is LoginErrorState) {
          showErrorDialog(
            isBack: true,
            context,
            message: 'فشل في تسجيل الدخول',
          );
        } else if (state is ResendOTPLoadingState) {
        } else if (state is ResendOTPSuccessState) {
          showCustomSnackBar(
            context,
            'تم إرسال كود التفعيل إلى جوالك',
            kGreenColor,
          );
        } else if (state is ResendOTPErrorState) {
          showCustomSnackBar(context, 'فشل في إعادة إرسال الرمز', kErrorColor);
        }
      },
      builder: (context, state) {
        final authCubit = context.read<AuthCubit>();
        return Scaffold(
          appBar: AppBar(toolbarHeight: 0),
          body: ModalProgressHUD(
            inAsyncCall: state.isLoading,
            opacity: 0.5,
            progressIndicator: const AppIndicator(),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  bottom:
                      isKeyboardVisible
                          ? -MediaQuery.of(context).viewInsets.bottom
                          : 0,
                  left: 0,
                  right: 0,
                  child: const EndOfPage(),
                ),
                SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  physics: const NeverScrollableScrollPhysics(),
                  child: AutofillGroup(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const H(h: 40),
                          Image.asset('assets/images/logo.png', width: 110.w),
                          const H(h: 20),
                          const AppWelcome(),
                          const H(h: 12),
                          const TitleOfWelcomePage(),
                          const H(h: 32),

                          /// user name textField
                          CustomTextformfieldWithHint(
                            controller: _userNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء إدخال اسم المستخدم';
                              }
                              return null;
                            },
                            text: 'اسم المستخدم',
                            passwordIcon: SvgPicture.asset(
                              'assets/svg/user.svg',
                              fit: BoxFit.none,
                              width: 20.w,
                              height: 20.h,
                            ),
                            keyboardType: TextInputType.number,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 18.h,
                              horizontal: 10.w,
                            ),
                            focusNode: nameFocus,
                            textInputAction: TextInputAction.next,
                            autofillHints: const [
                              AutofillHints.telephoneNumber,
                            ],
                          ),
                          const H(h: 20),

                          /// Password textField
                          CustomTextformfieldWithHint(
                            controller: _passwordController,
                            focusNode: passwordFocus,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء إدخال كلمة المرور';
                              }
                              if (value.length < 6) {
                                return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                              }
                              return null;
                            },
                            text: 'كلمة المرور',
                            passwordIcon: SvgPicture.asset(
                              'assets/svg/lock.svg',
                              fit: BoxFit.none,
                              width: 20.w,
                              height: 20.h,
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 18.h,
                              horizontal: 10.w,
                            ),

                            textInputAction: TextInputAction.done,
                            icon: IconButton(
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
                          // const H(h: 14),
                          // const ForgetPasswordWidget(),
                          const H(h: 40),

                          /// reCAPTCHA checkBox
                          Container(
                            width: 297.w,
                            height: 80.h,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF9F9F9),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 0.84.w,
                                  color: const Color(0xFFD3D3D3),
                                ),
                                borderRadius: BorderRadius.circular(4),
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
                                    margin: EdgeInsets.only(
                                      right: 14.w,
                                      left: 14.w,
                                    ),
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
                                    side: const BorderSide(
                                      color: Colors.grey,
                                      width: 2,
                                    ),
                                    onChanged: (value) async {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await Future.delayed(
                                        const Duration(seconds: 2),
                                        () {
                                          setState(() {
                                            isChecked = value!;
                                            isLoading = false;
                                          });
                                        },
                                      );
                                      await Future.delayed(
                                        const Duration(seconds: 10),
                                        () {
                                          if (mounted) {
                                            setState(() {
                                              isChecked = false;
                                            });
                                          }
                                        },
                                      );
                                    },
                                  ),
                                W(w: 10.w),
                              ],
                            ),
                          ),
                          const H(h: 30),

                          /// Login Button
                          LoginButton(
                            formKey: formKey,
                            isChecked: isChecked,
                            authCubit: authCubit,
                            userNameController: _userNameController,
                            passwordController: _passwordController,
                          ),
                          const H(h: 25),
                          // ///
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder:
                          //             (context) => const RegisterScreen(),
                          //       ),
                          //     );
                          //   },
                          //   child: Row(
                          //     spacing: 12.w,
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Text(
                          //         'إنشاء حساب جديد',
                          //         textAlign: TextAlign.center,
                          //         style: TextStyle(
                          //           color: kMainColor,
                          //           fontSize: 16.sp,
                          //           fontWeight: FontWeight.w400,
                          //           height: 1.43.h,
                          //         ),
                          //       ),
                          //       Icon(
                          //         Icons.arrow_forward_rounded,
                          //         color: kMainColor,
                          //         size: 20.w,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // const H(h: 25),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
