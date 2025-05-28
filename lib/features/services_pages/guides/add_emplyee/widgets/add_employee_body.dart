import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_number_textfield.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_cubit.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddEmployeeBody extends StatefulWidget {
  const AddEmployeeBody({super.key});

  @override
  State<AddEmployeeBody> createState() => _AddEmployeeBodyState();
}

class _AddEmployeeBodyState extends State<AddEmployeeBody> {
  final firstNameControll = TextEditingController();
  final fatherNameControll = TextEditingController();
  final grandfatherNameControll = TextEditingController();
  final familyNameControll = TextEditingController();
  final emailControll = TextEditingController();
  final phoneNumberControll = TextEditingController();
  final idNoControll = TextEditingController();
  final addressControll = TextEditingController();
  final idSaveNoControll = TextEditingController();
  final bankIbanNoControll = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuidesCubit, GuidesState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                spacing: 12.h,
                children: [
                  Row(
                    spacing: 12.w,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال الاسم الأول';
                            }
                            return null;
                          },
                          controller: firstNameControll,
                          labelText: 'الاسم الأول',
                        ),
                      ),

                      Expanded(
                        child: CustomTextField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال اسم الوالد';
                            }
                            return null;
                          },
                          controller: fatherNameControll,
                          labelText: 'اسم الوالد',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 12.w,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال الاسم الجد';
                            }
                            return null;
                          },
                          controller: grandfatherNameControll,
                          labelText: 'الاسم الجد',
                        ),
                      ),

                      Expanded(
                        child: CustomTextField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال اسم العائلة';
                            }
                            return null;
                          },
                          controller: familyNameControll,
                          labelText: 'اسم العائلة',
                        ),
                      ),
                    ],
                  ),

                  /// gender dropdown
                  /// nat dropdown
                  CustomTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال البريد الإلكتروني';
                      }
                      return null;
                    },
                    controller: emailControll,
                    labelText: 'البريد الإلكتروني',
                  ),
                  CustomNumberTextformfield(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال رقم الهاتف';
                      }
                      return null;
                    },
                    controller: phoneNumberControll,
                    labelText: 'رقم الهاتف',
                    textDirection: TextDirection.rtl,
                  ),

                  /// City
                  CustomTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال العنوان';
                      }
                      return null;
                    },
                    controller: addressControll,
                    labelText: 'العنوان',
                  ),

                  /// id date exp => data picker ==> age
                  /// qual dropdown
                  /// major dropdown
                  /// bank no dropdown
                  CustomNumberTextformfield(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال حساب التوفير';
                      }
                      return null;
                    },
                    controller: idSaveNoControll,
                    labelText: 'حساب التوفير',
                    textDirection: TextDirection.rtl,
                  ),
                  CustomNumberTextformfield(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال رقم الـ IBAN';
                      }
                      return null;
                    },
                    controller: bankIbanNoControll,
                    labelText: 'رقم الـ IBAN',
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.controller,
    required this.labelText,
    super.key,
    this.validator,
  });

  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      style: TextStyle(
        fontSize: 15.sp,
        color: const Color(0xFF494949),
        fontWeight: FontWeight.w300,
        fontFamily: 'FF Shamel Family',
      ),
      cursorWidth: 1.sp,
      cursorColor: kMainColor,

      controller: controller,
      autovalidateMode: AutovalidateMode.onUnfocus,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 13.sp,
          color: const Color(0xFFA2A2A2),
          fontWeight: FontWeight.w300,
        ),
        border: textfieldBorderRadius(const Color(0xFFD6D6D6)),
        focusedBorder: textfieldBorderRadius(kMainColor),
        enabledBorder: textfieldBorderRadius(const Color(0xFFD6D6D6)),
        focusedErrorBorder: textfieldBorderRadius(Colors.red),
      ),
    );
  }

  // void dispose
}
