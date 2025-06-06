import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_number_textfield.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_textfield_with_hint.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/core/widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/core/widgets/custom_dialog/show_success_dialog.dart';
import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/guides/add_emplyee/models/add_emplyee_model.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_cubit.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_states.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_centers_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddEmployeePageByCenter extends StatefulWidget {
  const AddEmployeePageByCenter({required this.center, super.key});
  final GetGuidesCenterModel center;

  @override
  State<AddEmployeePageByCenter> createState() =>
      _AddEmployeePageByCenterState();
}

class _AddEmployeePageByCenterState extends State<AddEmployeePageByCenter> {
  @override
  void initState() {
    super.initState();
    context.read<GuidesCubit>().fetchEmployeeData();
  }

  @override
  void dispose() {
    firstNameControll.dispose();
    fatherNameControll.dispose();
    grandfatherNameControll.dispose();
    familyNameControll.dispose();
    emailControll.dispose();
    phoneNumberControll.dispose();
    idNoControll.dispose();
    addressControll.dispose();
    idSaveNoControll.dispose();
    bankIbanNoControll.dispose();
    idDateExpControll.dispose();
    birthdayControll.dispose();
    super.dispose();
  }

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
  final idDateExpControll = TextEditingController();
  final birthdayControll = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int? natEmp;
  int? age;
  int? city;
  int? qualEmp;
  int? major;
  int? bankNo;

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // التاريخ الابتدائي
      firstDate: DateTime(2024), // أقل تاريخ ممكن
      lastDate: DateTime(2050), // أقصى تاريخ ممكن
    );
    if (picked != null) {
      // تحديث النص المعروض داخل TextField
      setState(() {
        year = picked.year.toString();
        month = picked.month.toString().padLeft(2, '0');
        day = picked.day.toString().padLeft(2, '0');
        idDateExpControll.text = '$year-$month-$day';
        idDateEx = '$year$month$day';
      });
    }
  }

  int calculateAge(String birthDateString) {
    final birthDate = DateTime.parse(birthDateString);
    final today = DateTime.now();

    var age = today.year - birthDate.year;

    // التحقق إذا كان لم يحتفل بعيد ميلاده بعد هذه السنة
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  String? idDateEx;
  Future<void> _selectBirthDayDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000), // التاريخ الابتدائي
      firstDate: DateTime(1950), // أقل تاريخ ممكن
      lastDate: DateTime(2020), // أقصى تاريخ ممكن
    );
    if (picked != null) {
      // تحديث النص المعروض داخل TextField
      setState(() {
        year = picked.year.toString();
        month = picked.month.toString().padLeft(2, '0');
        day = picked.day.toString().padLeft(2, '0');
        birthdayControll.text = '$year-$month-$day';
        birthdayDate = '$year$month$day';
      });
    }
  }

  final List<Map<String, dynamic>> genderList = [
    {'id': 1, 'label': 'ذكر'},
    {'id': 2, 'label': 'أنثى'},
  ];
  int? selectedGender;

  String? birthdayDate;
  String? year;
  String? month;
  String? day;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const LeadingIcon(),
        title: TitleAppBar(
          title: 'إضافة موظف لمركز ${widget.center.fCenterName}',
        ),
      ),
      body: BlocBuilder<GuidesCubit, GuidesState>(
        builder: (context, state) {
          return state.isLoadingAddEmpoloyee ||
                  state.isLoadingEmpData ||
                  state.isLoadingGuides
              ? const AppIndicator()
              : Padding(
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
                            /// الاسم الأول
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

                            /// اسم الوالد
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
                            /// اسم الجد
                            Expanded(
                              child: CustomTextField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'الرجاء إدخال اسم الجد';
                                  }
                                  return null;
                                },
                                controller: grandfatherNameControll,
                                labelText: 'اسم الجد',
                              ),
                            ),

                            /// اسم العائلة
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
                        Row(
                          spacing: 12.w,
                          children: [
                            /// تاريخ الميلاد
                            Expanded(
                              child: CustomTextField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'الرجاء إدخال تاريخ الميلاد';
                                  }
                                  return null;
                                },
                                readOnly: true,
                                controller: birthdayControll,
                                labelText: 'تاريخ الميلاد',
                                icon: const Icon(
                                  Icons.calendar_today,
                                  color: kMainColor,
                                ),
                                onTap: () {
                                  _selectBirthDayDate(context);
                                },
                              ),
                            ),

                            /// الجنس
                            Expanded(
                              child: DropdownButtonFormField<int>(
                                value: selectedGender,

                                items:
                                    genderList
                                        .map(
                                          (gender) => DropdownMenuItem<int>(
                                            value: gender['id'] as int?,
                                            child: Text(
                                              gender['label'].toString(),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                decoration: InputDecoration(
                                  fillColor: kScaffoldBackgroundColor,
                                  filled: true,
                                  border: textfieldBorderRadius(
                                    kMainColorLightColor,
                                  ),
                                  focusedBorder: textfieldBorderRadius(
                                    kMainColorLightColor,
                                  ),
                                  enabledBorder: textfieldBorderRadius(
                                    kMainColorLightColor,
                                  ),
                                  focusedErrorBorder: textfieldBorderRadius(
                                    Colors.red,
                                  ),
                                  label: Text(
                                    'الجنس',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: const Color(0xFFA2A2A2),
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: kMainColor,
                                ),
                                style: TextStyle(
                                  color: kMainColor,
                                  fontSize: 15.sp,
                                  fontFamily: 'GE SS Two',
                                  fontWeight: FontWeight.w300,
                                  height: 1.43.h,
                                ),
                                onChanged: (value) {
                                  if (value != null) {
                                    selectedGender = value;
                                  }
                                },
                                validator:
                                    (value) =>
                                        value == null
                                            ? 'يرجى اختيار الجنس'
                                            : null,
                              ),
                            ),
                          ],
                        ),

                        /// الجنسية
                        DropdownButtonFormField<int>(
                          borderRadius: BorderRadius.circular(10.r),
                          isExpanded: true,
                          decoration: InputDecoration(
                            fillColor: kScaffoldBackgroundColor,
                            filled: true,
                            border: textfieldBorderRadius(kMainColorLightColor),
                            focusedBorder: textfieldBorderRadius(
                              kMainColorLightColor,
                            ),
                            enabledBorder: textfieldBorderRadius(
                              kMainColorLightColor,
                            ),
                            focusedErrorBorder: textfieldBorderRadius(
                              Colors.red,
                            ),
                            label: Text(
                              'الجنسية',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: const Color(0xFFA2A2A2),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: kMainColor,
                          ),
                          style: TextStyle(
                            color: kMainColor,
                            fontSize: 15.sp,
                            fontFamily: 'GE SS Two',
                            fontWeight: FontWeight.w300,
                            height: 1.43.h,
                          ),
                          items:
                              state.nationalities.map((op) {
                                return DropdownMenuItem<int>(
                                  value: op.id,
                                  child: Text(op.name),
                                );
                              }).toList(),
                          onChanged: (op) {
                            if (op != null) {
                              natEmp = op;
                            }
                          },
                          value: natEmp,
                          validator: (value) {
                            if (value == null) {
                              return 'الرجاء اختيار الجنسية';
                            }
                            return null;
                          },
                        ),

                        /// البريد الإلكتروني
                        CustomTextField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال البريد الإلكتروني';
                            }
                            return null;
                          },
                          controller: emailControll,
                          labelText: 'البريد الإلكتروني',
                          textDirection: TextDirection.ltr,
                        ),

                        /// رقم الهاتف
                        CustomNumberTextformfield(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال رقم الهاتف';
                            }
                            return null;
                          },
                          controller: phoneNumberControll,
                          labelText: 'رقم الهاتف',
                          textDirection: TextDirection.ltr,
                        ),

                        /// المدينة
                        DropdownButtonFormField<int>(
                          borderRadius: BorderRadius.circular(10.r),
                          isExpanded: true,

                          decoration: InputDecoration(
                            fillColor: kScaffoldBackgroundColor,
                            filled: true,
                            border: textfieldBorderRadius(kMainColorLightColor),
                            focusedBorder: textfieldBorderRadius(
                              kMainColorLightColor,
                            ),
                            enabledBorder: textfieldBorderRadius(
                              kMainColorLightColor,
                            ),
                            focusedErrorBorder: textfieldBorderRadius(
                              Colors.red,
                            ),
                            label: Text(
                              'المدينة',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: const Color(0xFFA2A2A2),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: kMainColor,
                          ),
                          style: TextStyle(
                            color: kMainColor,
                            fontSize: 15.sp,
                            fontFamily: 'GE SS Two',
                            fontWeight: FontWeight.w300,
                            height: 1.43.h,
                          ),
                          items:
                              state.cities.map((op) {
                                return DropdownMenuItem<int>(
                                  value: op.id,
                                  child: Text(op.name),
                                );
                              }).toList(),
                          onChanged: (op) {
                            if (op != null) {
                              city = op;
                            }
                          },
                          value: city,
                          validator: (value) {
                            if (value == null) {
                              return 'الرجاء اختيار المدينة';
                            }
                            return null;
                          },
                        ),

                        /// العنوان
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

                        /// رقم الهوية
                        CustomNumberTextformfield(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال رقم الهوية';
                            } else if (value.length < 10) {
                              return 'رقم الهوية لا يقل عن عشرة أرقام';
                            }
                            return null;
                          },

                          controller: idNoControll,
                          labelText: 'رقم الهوية',
                          textDirection: TextDirection.ltr,
                        ),

                        /// تاريخ انتهاء رقم الهوية
                        CustomTextField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال تاريخ انتهاء الهوية';
                            }
                            return null;
                          },
                          readOnly: true,
                          controller: idDateExpControll,
                          labelText: 'تاريخ انتهاء الهوية',
                          icon: const Icon(
                            Icons.calendar_today,
                            color: kMainColor,
                          ),
                          onTap: () {
                            _selectDate(context);
                          },
                        ),

                        /// الشهادة
                        DropdownButtonFormField<int>(
                          borderRadius: BorderRadius.circular(10.r),
                          isExpanded: true,
                          decoration: InputDecoration(
                            fillColor: kScaffoldBackgroundColor,
                            filled: true,
                            border: textfieldBorderRadius(kMainColorLightColor),
                            focusedBorder: textfieldBorderRadius(
                              kMainColorLightColor,
                            ),
                            enabledBorder: textfieldBorderRadius(
                              kMainColorLightColor,
                            ),
                            focusedErrorBorder: textfieldBorderRadius(
                              Colors.red,
                            ),
                            label: Text(
                              'الشهادة',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: const Color(0xFFA2A2A2),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: kMainColor,
                          ),
                          style: TextStyle(
                            color: kMainColor,
                            fontSize: 15.sp,
                            fontFamily: 'GE SS Two',
                            fontWeight: FontWeight.w300,
                            height: 1.43.h,
                          ),
                          items:
                              state.certificates.map((op) {
                                return DropdownMenuItem<int>(
                                  value: op.id,
                                  child: Text(op.name),
                                );
                              }).toList(),
                          onChanged: (op) {
                            if (op != null) {
                              qualEmp = op;
                            }
                          },
                          value: qualEmp,
                          validator: (value) {
                            if (value == null) {
                              return 'الرجاء اختيار الشهادة';
                            }
                            return null;
                          },
                        ),

                        /// التخصص
                        DropdownButtonFormField<int>(
                          borderRadius: BorderRadius.circular(10.r),
                          isExpanded: true,

                          decoration: InputDecoration(
                            fillColor: kScaffoldBackgroundColor,
                            filled: true,
                            border: textfieldBorderRadius(kMainColorLightColor),
                            focusedBorder: textfieldBorderRadius(
                              kMainColorLightColor,
                            ),
                            enabledBorder: textfieldBorderRadius(
                              kMainColorLightColor,
                            ),
                            focusedErrorBorder: textfieldBorderRadius(
                              Colors.red,
                            ),
                            label: Text(
                              'التخصص',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: const Color(0xFFA2A2A2),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: kMainColor,
                          ),
                          style: TextStyle(
                            color: kMainColor,
                            fontSize: 15.sp,
                            fontFamily: 'GE SS Two',
                            fontWeight: FontWeight.w300,
                            height: 1.43.h,
                          ),
                          items:
                              state.majors.map((op) {
                                return DropdownMenuItem<int>(
                                  value: op.id,
                                  child: Text(op.name),
                                );
                              }).toList(),
                          onChanged: (op) {
                            if (op != null) {
                              major = op;
                            }
                          },
                          value: major,
                          validator: (value) {
                            if (value == null) {
                              return 'الرجاء اختيار التخصص';
                            }
                            return null;
                          },
                        ),

                        /// البنك
                        DropdownButtonFormField<int>(
                          borderRadius: BorderRadius.circular(10.r),
                          isExpanded: true,

                          decoration: InputDecoration(
                            fillColor: kScaffoldBackgroundColor,
                            filled: true,
                            border: textfieldBorderRadius(kMainColorLightColor),
                            focusedBorder: textfieldBorderRadius(
                              kMainColorLightColor,
                            ),
                            enabledBorder: textfieldBorderRadius(
                              kMainColorLightColor,
                            ),
                            focusedErrorBorder: textfieldBorderRadius(
                              Colors.red,
                            ),
                            label: Text(
                              'البنك',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: const Color(0xFFA2A2A2),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: kMainColor,
                          ),
                          style: TextStyle(
                            color: kMainColor,
                            fontSize: 15.sp,
                            fontFamily: 'GE SS Two',
                            fontWeight: FontWeight.w300,
                            height: 1.43.h,
                          ),
                          items:
                              state.banks.map((op) {
                                return DropdownMenuItem<int>(
                                  value: op.id,
                                  child: Text(op.name),
                                );
                              }).toList(),
                          onChanged: (op) {
                            if (op != null) {
                              bankNo = op;
                            }
                          },
                          value: bankNo,
                          validator: (value) {
                            if (value == null) {
                              return 'الرجاء اختيار البنك';
                            }
                            return null;
                          },
                        ),

                        /// رقم الحساب
                        CustomNumberTextformfield(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال رقم الحساب';
                            }
                            return null;
                          },
                          controller: idSaveNoControll,
                          labelText: 'رقم الحساب',
                          textDirection: TextDirection.ltr,
                        ),

                        /// Bank IBAN No
                        CustomTextField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال رقم الـ IBAN';
                            }
                            return null;
                          },
                          controller: bankIbanNoControll,
                          labelText: 'رقم الـ IBAN',
                          textDirection: TextDirection.ltr,
                        ),
                        12.verticalSpace,

                        /// send data
                        CustomButton(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              final guide = AddEmployeeModel(
                                fEmpFirst: firstNameControll.text,
                                fEmpFather: fatherNameControll.text,
                                fEmpGrandfather: grandfatherNameControll.text,
                                fEmpFamily: familyNameControll.text,

                                fEmpName:
                                    '${firstNameControll.text} ${fatherNameControll.text} ${grandfatherNameControll.text} ${familyNameControll.text}',
                                fEmpFirstE: 'string',
                                fEmpFatherE: 'string',
                                fEmpGrandfatherE: 'string',
                                fEmpFamilyE: 'string',
                                fEmpNameE: 'string',
                                fGender: selectedGender ?? 0,
                                fBirthDate: birthdayDate!,
                                fAge: calculateAge(birthdayControll.text),
                                fNatiNo: natEmp ?? 0,
                                fIdNo: int.parse(idNoControll.text),
                                fIdDateExpiry: idDateEx!,
                                fBankNo: bankNo ?? 0,
                                fJawNo: phoneNumberControll.text,
                                fQualiNo: qualEmp ?? 0,
                                fMajorNo: major ?? 0,

                                fIdSaveNo: idSaveNoControll.text,
                                fBankIbanNo: bankIbanNoControll.text,
                                fHomeCity: city ?? 0,
                                fEmail: emailControll.text,
                                fHomeAddress: addressControll.text,
                                fCompanyId: companyId,
                                fSeasonId: int.parse(
                                  BlocProvider.of<GuidesCubit>(
                                        context,
                                      ).selectedSeason ??
                                      '0',
                                ),
                                fCenterNo: widget.center.fCenterNo,
                              );
                              try {
                                await context.read<GuidesCubit>().addEmployee(
                                  guide,
                                );
                                if (context
                                    .read<GuidesCubit>()
                                    .state
                                    .isAddEmpoloyeeSuccess) {
                                  await context
                                      .read<GuidesCubit>()
                                      .fetchCenters();
                                  if (context.mounted) {
                                    showSuccessDialog(context, seconds: 2);
                                    Future.delayed(
                                      const Duration(seconds: 2),
                                      () {
                                        if (context.mounted) {
                                          Navigator.pop(context);
                                        }
                                      },
                                    );
                                  }
                                } else {
                                  if (context.mounted) {
                                    showErrorDialog(
                                      isBack: true,
                                      context,
                                      message: 'هناك خطأ في إضافة الموظف',
                                      icon: Icons.error_outline_rounded,
                                      color: kErrorColor,
                                    );
                                  }
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  showErrorDialog(
                                    isBack: true,
                                    context,
                                    message: 'هناك خطأ عام في إضافة الموظف',
                                    icon: Icons.error_outline_rounded,
                                    color: kErrorColor,
                                  );
                                }
                              }
                            }
                          },
                          text: 'إضافة الموظف',
                        ),
                        24.verticalSpace,
                      ],
                    ),
                  ),
                ),
              );
        },
      ),
    );
  }
}
