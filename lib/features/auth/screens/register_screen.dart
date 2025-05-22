import 'dart:developer';

import 'package:alrefadah/core/services/cache_helper.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_number_textfield.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_textfield_with_hint.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/auth/cubit/auth_cubit.dart';
import 'package:alrefadah/features/auth/cubit/auth_states.dart';
import 'package:alrefadah/features/auth/models/user_register_model.dart';
import 'package:alrefadah/features/auth/screens/verify_register_screen.dart';
import 'package:alrefadah/features/auth/widgets/register_widgets/register_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isShowPassword = true;
  bool isChecked = false;
  bool isLoading = false;
  final _userNameController = TextEditingController();
  final _userTypeController = TextEditingController();
  final _userCodeController = TextEditingController();
  final _userIdController = TextEditingController();
  final _userPhoneController = TextEditingController();
  final _userEmailController = TextEditingController();
  final _userSectionController = TextEditingController();
  final _userStatusController = TextEditingController();
  final _userCenterNoController = TextEditingController();
  final _userPasswordController = TextEditingController();
  final _userConfirmPasswordController = TextEditingController();
  final _userNameFocusNode = FocusNode();
  final _userTypeFocusNode = FocusNode();
  final _userCodeFocusNode = FocusNode();
  final _userIdFocusNode = FocusNode();
  final _userPhoneFocusNode = FocusNode();
  final _userEmailFocusNode = FocusNode();
  final _userSectionFocusNode = FocusNode();
  final _userStatusFocusNode = FocusNode();
  final _userCenterNoFocusNode = FocusNode();
  final _userPasswordFocusNode = FocusNode();
  final _userConfirmPasswordFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool _isInAsyncCall = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          setState(() {
            _isInAsyncCall = true;
          });
        } else if (state is RegisterSuccessState) {
          setState(() {
            _isInAsyncCall = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const VerifyRegisterScreen(),
            ),
          );
        } else if (state is RegisterErrorState) {
          setState(() {
            _isInAsyncCall = false;
          });
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Center(child: Text(state.message))));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'إنشاء حساب جديد',
            style: TextStyle(
              color: kMainColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              height: 1.h,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: _isInAsyncCall,
          opacity: 0.5,
          progressIndicator: const AppIndicator(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: SingleChildScrollView(
              child: AutofillGroup(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'لديك حساب بالفعل؟',
                            style: TextStyle(
                              color: kTextColor,
                              fontSize: 14.sp,
                              fontFamily: 'GE SS Two',
                              fontWeight: FontWeight.w300,
                              height: 1.43.h,
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Text(
                              ' تسجيل الدخول',
                              style: TextStyle(
                                color: kMainColor,
                                fontSize: 14.sp,
                                fontFamily: 'GE SS Two',
                                fontWeight: FontWeight.w300,
                                height: 1.43.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const H(h: 20),

                      /// user name textField
                      const RegisterTitle(text: 'اسم المستخدم'),
                      CustomTextformfieldWithHint(
                        controller: _userNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال اسم المستخدم';
                          }
                          return null;
                        },
                        text: 'اسم المستخدم',
                        keyboardType: TextInputType.name,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 18.h,
                          horizontal: 10.w,
                        ),
                        focusNode: _userNameFocusNode,
                        onFieldSubmitted: (value) {
                          FocusScope.of(
                            context,
                          ).requestFocus(_userTypeFocusNode);
                        },
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.username],
                      ),

                      /// user type
                      const RegisterTitle(text: 'نوع المستخدم'),
                      CustomTextformfieldWithHint(
                        controller: _userTypeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال نوع المستخدم';
                          }
                          return null;
                        },
                        text: 'نوع المستخدم',
                        keyboardType: TextInputType.text,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 18.h,
                          horizontal: 10.w,
                        ),
                        focusNode: _userTypeFocusNode,
                        onFieldSubmitted: (value) {
                          FocusScope.of(
                            context,
                          ).requestFocus(_userCodeFocusNode);
                        },
                        autofillHints: const [AutofillHints.username],
                        textInputAction: TextInputAction.next,
                      ),

                      /// user code
                      const RegisterTitle(text: 'كود المستخدم'),
                      CustomNumberTextformfield(
                        controller: _userCodeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال كود المستخدم';
                          } else if (value.length < 6) {
                            return 'الكود التعريفي يجب أن يتكون من 6 أرقام';
                          }
                          return null;
                        },
                        text: 'كود المستخدم',
                        keyboardType: TextInputType.number,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 18.h,
                          horizontal: 10.w,
                        ),
                        focusNode: _userCodeFocusNode,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_userIdFocusNode);
                        },
                        autofillHints: const [AutofillHints.username],
                        textInputAction: TextInputAction.next,
                      ),

                      ///
                      const RegisterTitle(text: 'الكود التعريفي ID'),
                      CustomNumberTextformfield(
                        controller: _userIdController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال الكود التعريفي';
                          } else if (value.length < 6) {
                            return 'الكود التعريفي يجب أن يتكون من 6 أرقام';
                          }
                          return null;
                        },
                        text: 'الكود التعريفي ID',
                        keyboardType: TextInputType.number,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 18.h,
                          horizontal: 10.w,
                        ),
                        focusNode: _userIdFocusNode,
                        onFieldSubmitted: (value) {
                          FocusScope.of(
                            context,
                          ).requestFocus(_userPhoneFocusNode);
                        },
                        autofillHints: const [AutofillHints.username],
                        textInputAction: TextInputAction.next,
                      ),

                      ///
                      const RegisterTitle(text: 'رقم الجوال'),
                      CustomNumberTextformfield(
                        controller: _userPhoneController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال رقم الجوال';
                          }
                          return null;
                        },
                        text: 'رقم الجوال',
                        keyboardType: TextInputType.phone,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 18.h,
                          horizontal: 10.w,
                        ),
                        focusNode: _userPhoneFocusNode,
                        onFieldSubmitted: (value) {
                          FocusScope.of(
                            context,
                          ).requestFocus(_userEmailFocusNode);
                        },
                        autofillHints: const [AutofillHints.telephoneNumber],
                        textInputAction: TextInputAction.next,
                      ),

                      ///
                      const RegisterTitle(text: 'البريد الإلكتروني'),
                      CustomTextformfieldWithHint(
                        controller: _userEmailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال البريد الإلكتروني';
                          }
                          return null;
                        },
                        text: 'البريد الإلكتروني',
                        keyboardType: TextInputType.emailAddress,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 18.h,
                          horizontal: 10.w,
                        ),
                        focusNode: _userEmailFocusNode,
                        onFieldSubmitted: (value) {
                          FocusScope.of(
                            context,
                          ).requestFocus(_userSectionFocusNode);
                        },
                        autofillHints: const [AutofillHints.email],
                        textInputAction: TextInputAction.next,
                      ),

                      ///
                      const RegisterTitle(text: 'القسم'),
                      CustomNumberTextformfield(
                        controller: _userSectionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال القسم';
                          } else if (value.length < 6) {
                            // 100001
                            return 'الرجاء إدخال قسم صحيح';
                          }
                          return null;
                        },
                        text: 'القسم',
                        keyboardType: TextInputType.number,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 18.h,
                          horizontal: 10.w,
                        ),
                        focusNode: _userSectionFocusNode,
                        onFieldSubmitted: (value) {
                          FocusScope.of(
                            context,
                          ).requestFocus(_userStatusFocusNode);
                        },
                        autofillHints: const [AutofillHints.username],
                        textInputAction: TextInputAction.next,
                      ),

                      ///
                      const RegisterTitle(text: 'الحالة'),
                      CustomNumberTextformfield(
                        controller: _userStatusController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال الحالة';
                          }
                          return null;
                        },
                        text: 'الحالة',
                        keyboardType: TextInputType.number,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 18.h,
                          horizontal: 10.w,
                        ),
                        focusNode: _userStatusFocusNode,
                        onFieldSubmitted: (value) {
                          FocusScope.of(
                            context,
                          ).requestFocus(_userCenterNoFocusNode);
                        },
                        autofillHints: const [AutofillHints.username],
                        textInputAction: TextInputAction.next,
                      ),

                      ///
                      const RegisterTitle(text: 'رقم المركز'),
                      CustomNumberTextformfield(
                        controller: _userCenterNoController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال رقم المركز';
                          }
                          return null;
                        },
                        text: 'رقم المركز',
                        keyboardType: TextInputType.number,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 18.h,
                          horizontal: 10.w,
                        ),
                        focusNode: _userCenterNoFocusNode,
                        onFieldSubmitted: (value) {
                          FocusScope.of(
                            context,
                          ).requestFocus(_userPasswordFocusNode);
                        },
                        autofillHints: const [AutofillHints.username],
                        textInputAction: TextInputAction.next,
                      ),

                      /// Password textField
                      const RegisterTitle(text: 'كلمة المرور'),
                      CustomTextformfieldWithHint(
                        controller: _userPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال كلمة المرور';
                          }
                          return null;
                        },
                        text: 'كلمة المرور',
                        keyboardType: TextInputType.visiblePassword,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 18.h,
                          horizontal: 10.w,
                        ),
                        textInputAction: TextInputAction.next,
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
                        obscureText: isShowPassword,
                        autofillHints: const [AutofillHints.password],
                        focusNode: _userPasswordFocusNode,
                        onFieldSubmitted: (value) {
                          FocusScope.of(
                            context,
                          ).requestFocus(_userConfirmPasswordFocusNode);
                        },
                      ),

                      ///
                      const RegisterTitle(text: 'تأكيد كلمة المرور'),
                      CustomTextformfieldWithHint(
                        controller: _userConfirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال كلمة المرور';
                          }
                          if (value != _userPasswordController.text) {
                            return 'كلمة المرور غير متطابقة';
                          }
                          return null;
                        },
                        text: 'تأكيد كلمة المرور',
                        keyboardType: TextInputType.visiblePassword,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 18.h,
                          horizontal: 10.w,
                        ),
                        textInputAction: TextInputAction.done,
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
                        focusNode: _userConfirmPasswordFocusNode,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).unfocus();
                        },
                        obscureText: isShowPassword,
                        autofillHints: const [AutofillHints.password],
                      ),
                      const H(h: 20),
                      CustomButton(
                        text: 'إنشاء حساب',
                        onTap: () async {
                          final userPhone = _userPhoneController.text;
                          await CacheHelper.saveData(
                            key: 'userPhone',
                            value: userPhone,
                          );
                          if (formKey.currentState!.validate()) {
                            try {
                              await context.read<AuthCubit>().register(
                                UserRegisterModel(
                                  fUserType: 1,
                                  fUserCode: _userCodeController.text,
                                  fUserPass: _userPasswordController.text,
                                  fUserName: _userNameController.text,
                                  fIdNo: int.parse(_userIdController.text),
                                  fJawNo: _userPhoneController.text,
                                  fEmail: _userEmailController.text,
                                  fVerificatOption: 1,
                                  fSectionNo: int.parse(
                                    _userSectionController.text,
                                  ),
                                  fUserStatus: int.parse(
                                    _userStatusController.text,
                                  ),
                                  fCompanyId: companyId,
                                  fCenterNo: int.parse(
                                    _userCenterNoController.text,
                                  ),
                                ),
                              );
                            } catch (e) {
                              log('Error: $e');
                            }
                          }
                        },
                      ),
                      const H(h: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _userTypeController.dispose();
    _userCodeController.dispose();
    _userIdController.dispose();
    _userPhoneController.dispose();
    _userEmailController.dispose();
    _userSectionController.dispose();
    _userStatusController.dispose();
    _userCenterNoController.dispose();
    _userPasswordController.dispose();
    _userConfirmPasswordController.dispose();
    _userNameFocusNode.dispose();
    _userTypeFocusNode.dispose();
    _userCodeFocusNode.dispose();
    _userIdFocusNode.dispose();
    _userPhoneFocusNode.dispose();
    _userEmailFocusNode.dispose();
    _userSectionFocusNode.dispose();
    _userStatusFocusNode.dispose();
    _userCenterNoFocusNode.dispose();
    _userPasswordFocusNode.dispose();
    _userConfirmPasswordFocusNode.dispose();
  }
}
