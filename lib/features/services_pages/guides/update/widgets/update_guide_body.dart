import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_number_textfield.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_textfield_with_hint.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_cubit.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_states.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_guide_model.dart';
import 'package:alrefadah/features/services_pages/guides/update/models/update_guide_model.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_dialog/show_success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateGuideBody extends StatefulWidget {
  const UpdateGuideBody({required this.employe, super.key});
  final GetGuidesModel employe;

  @override
  State<UpdateGuideBody> createState() => _UpdateGuideBodyState();
}

class _UpdateGuideBodyState extends State<UpdateGuideBody> {
  final _empNoController = TextEditingController();
  final _empNameController = TextEditingController();
  final _empNatController = TextEditingController();
  final _empIdNoController = TextEditingController();
  final _empJawNoController = TextEditingController();
  final _empEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final empNo = int.tryParse(_empNoController.text);
    return BlocBuilder<GuidesCubit, GuidesState>(
      builder: (context, state) {
        _empNoController.text = widget.employe.empNo.toString();
        _empNameController.text = widget.employe.empName;
        _empNatController.text = widget.employe.natiNo.toString();
        _empIdNoController.text = widget.employe.idNo.toString();
        _empJawNoController.text = widget.employe.jawNo;
        _empEmailController.text = widget.employe.email;
        final cubit = context.read<GuidesCubit>();
        final model = UpateGuideModel(
          fLastUpdate: DateTime.now(),
          fLastUpdateUser: 1,
          fLastUpdateSum: 0,
          fLastUpdateOper: 0,
          fCompanyId: companyId,
          fSeasonId: int.parse(cubit.selectedSeason ?? '0'),
          fCenterNo: int.parse(cubit.selectedCenter ?? '0'),

          /// غير ساري
          fEmpNo: empNo ?? 0,
        );

        return Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 12.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'رقم المرشد',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kMainColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                        height: 1.43.h,
                      ),
                    ),
                    CustomNumberTextformfield(
                      controller: _empNoController,
                      textDirection: TextDirection.rtl,
                      textInputAction: TextInputAction.next,
                      text: widget.employe.empName,
                    ),
                    Text(
                      'اسم المرشد',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kMainColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                        height: 1.43.h,
                      ),
                    ),
                    CustomTextformfieldWithHint(
                      controller: _empNameController,
                      textDirection: TextDirection.rtl,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      text: 'اسم المرشد',
                    ),
                    Text(
                      'الجنسية',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kMainColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                        height: 1.43.h,
                      ),
                    ),
                    CustomTextformfieldWithHint(
                      controller: _empNatController,
                      textDirection: TextDirection.rtl,
                      textInputAction: TextInputAction.next,
                      text: 'الجنسية',
                    ),
                    Text(
                      'رقم الهوية',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kMainColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                        height: 1.43.h,
                      ),
                    ),
                    CustomNumberTextformfield(
                      controller: _empIdNoController,
                      textDirection: TextDirection.rtl,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      text: 'رقم الهوية',
                    ),
                    Text(
                      'رقم الجوال',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kMainColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                        height: 1.43.h,
                      ),
                    ),
                    CustomNumberTextformfield(
                      controller: _empJawNoController,
                      textDirection: TextDirection.rtl,
                      textInputAction: TextInputAction.next,
                      text: 'رقم الجوال',
                    ),
                    Text(
                      'البريد الإلكتروني',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kMainColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                        height: 1.43.h,
                      ),
                    ),
                    CustomTextformfieldWithHint(
                      controller: _empEmailController,
                      textDirection: TextDirection.rtl,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,
                      text: 'البريد الإلكتروني',
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CustomButton(
                  text: 'حفظ',
                  padding: 16,
                  onTap: () async {
                    try {
                      await cubit.updateHajTransGuide(model);
                      showSuccessDialog(context);
                      Future.delayed(const Duration(seconds: 2), () {
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      });
                    } catch (e) {
                      showErrorDialog(
                        context,
                        message: 'حدث خطأ ما',
                        isBack: false,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _empNoController.dispose();
    _empNameController.dispose();
    _empNatController.dispose();
    _empIdNoController.dispose();
    _empJawNoController.dispose();
    _empEmailController.dispose();
    super.dispose();
  }
}
