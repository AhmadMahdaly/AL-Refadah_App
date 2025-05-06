import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_number_textfield.dart';
import 'package:alrefadah/features/auth/cubit/auth_cubit.dart';
import 'package:alrefadah/features/auth/cubit/auth_states.dart';
import 'package:alrefadah/features/auth/screans/forget_password_screens/get_verification_code_forget_password_screen.dart';
import 'package:alrefadah/presentation/app/shared_widgets/end_of_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class GetUserCodeForgetPasswordScreen extends StatefulWidget {
  const GetUserCodeForgetPasswordScreen({super.key});

  @override
  State<GetUserCodeForgetPasswordScreen> createState() =>
      _GetUserCodeForgetPasswordScreenState();
}

class _GetUserCodeForgetPasswordScreenState
    extends State<GetUserCodeForgetPasswordScreen> {
  bool _isInAsyncCall = false;
  final _userCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    _userCodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is VerifyLoginLoadingState) {
          setState(() {
            _isInAsyncCall = true;
          });
        } else if (state is VerifyLoginSuccessState) {
          setState(() {
            _isInAsyncCall = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => const GetVerificationCodeForgetPasswordScreen(),
            ),
          );
        } else if (state is VerifyLoginErrorState) {
          setState(() {
            _isInAsyncCall = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(child: Text(state.message)),
              backgroundColor: kErrorColor,
            ),
          );
        }
      },
      child: Scaffold(
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
                            'برجاء إدخال الرقم التعريفي الخاص بك',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kGrayColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                              height: 1.43.h,
                            ),
                          ),
                          const H(h: 40),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'الرقم التعريفي ID',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: kMainColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w300,
                                height: 1.43.h,
                              ),
                            ),
                          ),
                          const H(h: 20),
                          CustomNumberTextformfield(
                            controller: _userCodeController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء إدخال كود المستخدم';
                              }
                              return null;
                            },
                            text: 'كود المستخدم',
                          ),
                          const H(h: 40),
                          CustomButton(
                            text: 'استعادة كلمة المرور',
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                BlocProvider.of<AuthCubit>(
                                  context,
                                ).verifyLogin(_userCodeController.text);
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
      ),
    );
  }
}
