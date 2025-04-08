import 'package:alrefadah/cubit/auth_cubit/auth_cubit.dart';
import 'package:alrefadah/cubit/auth_cubit/auth_states.dart';
import 'package:alrefadah/screens/confirm_login/confirm_login_screen.dart';
import 'package:alrefadah/screens/login/widgets/app_welcome_widget.dart';
import 'package:alrefadah/screens/login/widgets/title_of_welcome_page_widget.dart';
import 'package:alrefadah/utils/components/custom_button.dart';
import 'package:alrefadah/utils/components/custom_textformfield.dart';
import 'package:alrefadah/utils/components/height.dart';
import 'package:alrefadah/utils/components/width.dart';
import 'package:alrefadah/utils/constants/colors_constants.dart';
import 'package:alrefadah/widgets/end_of_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isShowPassword = true;
  bool isChecked = false;
  bool isLoading = false;
  final _phoneController = TextEditingController();
  final _userIdController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _isInAsyncCall = false;

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AppLoginLoadingState) {
          setState(() {
            _isInAsyncCall = true;
          });
        } else if (state is AppLoginSuccessState) {
          setState(() {
            _isInAsyncCall = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ConfirmLoginScreen(
                    phoneNumber: _phoneController.text,
                    identityNumber: _userIdController.text,
                  ),
            ),
          );
        } else if (state is AppLoginErrorState) {
          setState(() {
            _isInAsyncCall = false;
          });
          showDialog<String>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('خطأ'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('موافق'),
                  ),
                ],
              );
            },
          );
        }
      },
      builder: (context, state) {
        final authCubit = context.read<AuthCubit>();
        return Scaffold(
          body: ModalProgressHUD(
            inAsyncCall: _isInAsyncCall,
            opacity: 0.5,
            progressIndicator: const CircularProgressIndicator(),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  bottom: isKeyboardVisible ? -250 : 0,
                  left: 0,
                  right: 0,
                  child: const EndOfPage(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: SingleChildScrollView(
                    child: AutofillGroup(
                      onDisposeAction: AutofillContextAction.cancel,
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            const H(h: 40),
                            Image.asset('assets/images/logo.png', width: 110.w),
                            const H(h: 20),
                            const AppWelcome(),
                            const H(h: 12),
                            const TitleOfWelcomePage(),
                            const H(h: 32),
                            CustomTextformfield(
                              controller: _userIdController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الرجاء إدخال رقم الهوية';
                                } else if (value.length < 10) {
                                  return 'رقم الهوية يجب أن يكون 10 أرقام';
                                } else if (!RegExp(
                                  r'^[0-9]+$',
                                ).hasMatch(value)) {
                                  return 'رقم الهوية يجب أن يحتوي على أرقام فقط';
                                }
                                return null;
                              },
                              text: 'رقم الهوية',
                              icon: const Icon(Icons.numbers_outlined),
                              keyboardType: TextInputType.number,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 18.h,
                                horizontal: 10.w,
                              ),
                              textInputAction: TextInputAction.next,
                            ),
                            const H(h: 20),

                            CustomTextformfield(
                              controller: _phoneController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الرجاء إدخال رقم الجوال';
                                } else if (value.length < 10) {
                                  return 'رقم الجوال يجب أن يكون 10 أرقام';
                                } else if (!RegExp(
                                  r'^[0-9]+$',
                                ).hasMatch(value)) {
                                  return 'رقم الجوال يجب أن يحتوي على أرقام فقط';
                                }
                                return null;
                              },
                              text: 'رقم الجوال',
                              icon: const Icon(Icons.phone_android_outlined),
                              keyboardType: TextInputType.number,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 18.h,
                                horizontal: 10.w,
                              ),
                              textInputAction: TextInputAction.done,

                              autofillHints: const [
                                AutofillHints.telephoneNumber,
                              ],
                            ),

                            // const H(h: 14),
                            // const ForgetPasswordWidget(),
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
                              onTap: () async {
                                if (formKey.currentState!.validate() &&
                                    isChecked) {
                                  await authCubit.login(
                                    phoneNumber: _phoneController.text,
                                    identityNumber: _userIdController.text,
                                  );
                                }
                              },
                            ),
                            const H(h: 25),
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
      },
    );
  }

  @override
  void dispose() {
    _userIdController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
