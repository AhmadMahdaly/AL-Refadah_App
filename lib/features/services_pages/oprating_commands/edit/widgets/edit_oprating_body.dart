import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_number_textfield.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/cubit/oprating_command_cubit.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/cubit/oprating_command_states.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/models/add_transport_operating_model.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/models/get_all_operatings_model.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_dialog/show_success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditOpratingBody extends StatefulWidget {
  const EditOpratingBody({required this.data, super.key});
  final GetAllOperatingsModel data;

  @override
  State<EditOpratingBody> createState() => _EditOpratingBodyState();
}

class _EditOpratingBodyState extends State<EditOpratingBody> {
  String transType = '0';
  var _busQtyController = TextEditingController();

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    context.read<OpratingCommandsCubit>().getCenters();
    transType = widget.data.fTransportType.toString();
    _busQtyController = TextEditingController(
      text: widget.data.fBusAco.toString(),
    );
  }

  @override
  void dispose() {
    _busQtyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpratingCommandsCubit, OperatingCommandState>(
      builder: (context, state) {
        return state.isLoadingEditOperating
            ? const AppIndicator()
            : Stack(
              fit: StackFit.expand,
              children: [
                const H(h: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 12.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'عدد الحافلات',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kMainColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w300,
                            height: 1.43.h,
                          ),
                        ),
                        CustomNumberTextformfield(
                          controller: _busQtyController,
                          textInputAction: TextInputAction.done,

                          text: 'عدد الحافلات',
                        ),
                        Text(
                          'نوع النقل',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kMainColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w300,
                            height: 1.43.h,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildRadioOption(title: 'تقليدي', value: '1'),

                            buildRadioOption(title: 'ترددي', value: '2'),
                          ],
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
                          final model = AddTransportOperatingModel(
                            fOperatingNo: widget.data.fOperatingNo,
                            fTransportType: int.parse(transType),
                            fBusAco: int.parse(_busQtyController.text),
                            fOperatingStatus: 1,
                            fCenterNo: widget.data.fCenterNo,

                            fLastUpdateUser: 1,
                            fLastUpdateSum: 1,
                            fLastUpdateOper: 1,
                            fCompanyId:
                                state.centers
                                    .firstWhere(
                                      (element) =>
                                          element.fCenterNo ==
                                          widget.data.fCenterNo,
                                    )
                                    .fCompanyId,
                            fSeasonId: int.parse(
                              context
                                  .read<OpratingCommandsCubit>()
                                  .selectedSeasonId!,
                            ),
                            fLastUpdate: DateTime.now(),
                          );
                          await context
                              .read<OpratingCommandsCubit>()
                              .editOperating(model);
                          await context
                              .read<OpratingCommandsCubit>()
                              .getAllTransportOperating();

                          showSuccessDialog(context);
                          Future.delayed(const Duration(seconds: 2), () {
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          });
                        } catch (e) {
                          showErrorDialog(
                            isBack: true,
                            context,
                            message: 'حدث خطأ في تحديث البيانات',
                            icon: Icons.error_outline,
                            color: kErrorColor,
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

  Widget buildRadioOption({required String value, required String title}) {
    final isSelected = value == transType;
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: () {
        setState(() {
          transType = value;
        });
      },
      child: Container(
        width: 170.w,
        height: 60.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            width: 1,
            color: isSelected ? kMainColor : const Color(0xFFD6D6D6),
          ),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: transType, // ✅ هذا هو المفتاح
              onChanged: (val) {
                setState(() {
                  transType = val!;
                });
              },
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              activeColor: kMainColor,
            ),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? kMainColor : const Color(0xFFD6D6D6),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                height: 1.71.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
