/// Model
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddEmployeeModel {
  AddEmployeeModel({
    required this.fEmpFirst,
    required this.fEmpFamily,
    required this.fEmpFirstE,
    required this.fEmpFamilyE,
    required this.fEmpName,
    required this.fEmpNameE,
    required this.fGender,
    required this.fBirthDate,
    required this.fAge,
    required this.fNatiNo,
    required this.fIdNo,
    required this.fIdDateExpiry,
    required this.fBankNo,
    required this.fJawNo,
    required this.fQualiNo,
    required this.fMajorNo,
    required this.fEmpFather,
    required this.fEmpGrandfather,
    required this.fEmpFatherE,
    required this.fEmpGrandfatherE,
    required this.fIdSaveNo,
    required this.fBankIbanNo,
    required this.fHomeCity,
    required this.fEmail,
    required this.fHomeAddress,
    required this.fCompanyId,
    required this.fSeasonId,
    required this.fCenterNo,
  });
  final String fEmpFirst;
  final String fEmpFamily;
  final String fEmpFirstE;
  final String fEmpFamilyE;
  final String fEmpName;
  final String fEmpNameE;
  final int fGender;
  final String fBirthDate;
  final int fAge;
  final int fNatiNo;
  final int fIdNo;
  final String fIdDateExpiry;
  final int fBankNo;
  final String fJawNo;
  final int fQualiNo;
  final int fMajorNo;
  final String fEmpFather;
  final String fEmpGrandfather;
  final String fEmpFatherE;
  final String fEmpGrandfatherE;
  final String fIdSaveNo;
  final String fBankIbanNo;
  final int fHomeCity;
  final String fEmail;
  final String fHomeAddress;
  final int fCompanyId;
  final int fSeasonId;
  final int fCenterNo;

  Map<String, dynamic> toJson() {
    return {
      'fCenterNo': fCenterNo,
      'fEmpFirst': fEmpFirst,
      'fEmpFamily': fEmpFamily,
      'fEmpFirstE': fEmpFirstE,
      'fEmpFamilyE': fEmpFamilyE,
      'fEmpName': fEmpName,
      'fEmpNameE': fEmpNameE,
      'fGender': fGender,
      'fBirthDate': fBirthDate,
      'fAge': fAge,
      'fNatiNo': fNatiNo,
      'fIdNo': fIdNo,
      'fIdDateExpiry': fIdDateExpiry,
      'fBankNo': fBankNo,
      'fJawNo': fJawNo,
      'fQualiNo': fQualiNo,
      'fMajorNo': fMajorNo,
      'fEmpFather': fEmpFather,
      'fEmpGrandfather': fEmpGrandfather,
      'fEmpFatherE': fEmpFatherE,
      'fEmpGrandfatherE': fEmpGrandfatherE,
      'fIdSaveNo': fIdSaveNo,
      'fBankIbanNo': fBankIbanNo,
      'fHomeCity': fHomeCity,
      'fEmail': fEmail,
      'fHomeAddress': fHomeAddress,
      'fCompanyId': fCompanyId,
      'fSeasonId': fSeasonId,
    };
  }
}

/// Repo
// Future<void> addEmpoloyee(List<AddEmployeeModel> model) async {
//   final response = await DioHelper.dio.post<Map<String, dynamic>>(
//     '/Employees/AddEmployeeAndGuide',
//     data: model.map((e) => e.toJson()).toList(),
//   );
//   if (response.statusCode == 200) {
//   return response.data;
//   } else {
//     throw Exception('فشل الإرسال: ${response.statusCode}');
//   }
// }

/// Cubit
//   Future<void> addHajTransGuide(List<AddEmployeeModel> model) async {
//   emit(state.copyWith(isLoadingAddEmpoloyee: true));
//   try {
//     await repository.addHajTransGuide(model);
//     emit(state.copyWith(isLoadingAddEmpoloyee: false, isAddEmpoloyeeSuccess: true));
//   } catch (e) {
//     emit(state.copyWith(isLoadingAddEmpoloyee: false, error: 'حدث خطأ'));
//   }
// }

/// States
// isLoadingAddEmpoloyee, isAddEmpoloyeeSuccess,

/// Ui
class AddGuidePage extends StatefulWidget {
  const AddGuidePage({super.key});

  @override
  State<AddGuidePage> createState() => _AddGuidePageState();
}

class _AddGuidePageState extends State<AddGuidePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          spacing: 10.h,
          children: const [
            // Row(
            //   spacing: 8.w,
            //   children: [
            //     /// الموسم
            //     Expanded(
            //       child: CustomTextFieldWithLabel(
            //         controller: seasonIdController,
            //         text: 'الموسم',
            //         readOnly: true,
            //         enabled: false,
            //       ),
            //     ),

            //     /// المركز
            //     Expanded(
            //       child: CustomTextFieldWithLabel(
            //         controller: centerNoController,
            //         text: 'المركز',
            //         readOnly: true,
            //         enabled: false,
            //       ),
            //     ),
            //   ],
            // ),

            /// الاسم الاول
            // CustomTextFieldWithLabel(
            //   controller: fEmpFirstController,
            //   text: 'الاسم الاول',
            //   readOnly: false,
            //   enabled: true,
            // ),
            // /// الاسم الثاني
            // CustomTextFieldWithLabel(
            //   controller: fEmpFamilyController,
            //   text: 'الاسم الثاني',
            //   readOnly: false,
            //   enabled: true,
            // ),
          ],
        ),
      ),
    );
  }
}
