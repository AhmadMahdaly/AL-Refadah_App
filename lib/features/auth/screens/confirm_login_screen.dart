import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_number_textfield.dart';
import 'package:alrefadah/core/widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/features/auth/cubit/auth_cubit.dart';
import 'package:alrefadah/features/auth/cubit/auth_states.dart';
import 'package:alrefadah/features/auth/widgets/confirm_login_widget/confirm_button.dart';
import 'package:alrefadah/features/auth/widgets/confirm_login_widget/confirm_card_login_number_widget.dart';
import 'package:alrefadah/features/auth/widgets/confirm_login_widget/custom_timer_widget.dart';
import 'package:alrefadah/features/auth/widgets/confirm_login_widget/title_of_confirm_login_widget.dart';
import 'package:alrefadah/presentation/app/app_loader_page.dart';
import 'package:alrefadah/presentation/app/shared_widgets/end_of_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ConfirmLoginScreen extends StatefulWidget {
  const ConfirmLoginScreen({super.key});

  @override
  State<ConfirmLoginScreen> createState() => _ConfirmLoginScreenState();
}

class _ConfirmLoginScreenState extends State<ConfirmLoginScreen> {
  /// Verification code controller
  List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  String code = '';

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

  bool _isInAsyncCall = false;
  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LoginWithCodeLoadingState) {
          setState(() {
            _isInAsyncCall = true;
          });
        } else if (state is LoginWithCodeSuccessState) {
          setState(() {
            _isInAsyncCall = false;
          });
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const AppLoaderPage()),
            (route) => false,
          );
        } else if (state is LoginWithCodeErrorState) {
          setState(() {
            _isInAsyncCall = false;
          });
          if (mounted) {
            Navigator.pop(context);
            showErrorDialog(isBack: true, context, message: 'كود غير صالح');
          }
        }
      },
      builder: (BuildContext context, AuthStates state) {
        final authCubit = context.read<AuthCubit>();
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
                  bottom:
                      isKeyboardVisible
                          ? -MediaQuery.of(context).viewInsets.bottom
                          : 0,
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
                                            controllers
                                                .map((c) => c.text)
                                                .join();
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

                          /// Confirm button
                          ConfirmButton(
                            code: code,
                            authCubit: authCubit,
                            widget: widget,
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
      },
    );
  }
}
