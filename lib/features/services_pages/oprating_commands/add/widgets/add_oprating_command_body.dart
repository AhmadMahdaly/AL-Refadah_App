import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_number_textfield.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/core/widgets/custom_dialog/show_success_dialog.dart';
import 'package:alrefadah/core/widgets/show_snackbar.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/cubit/oprating_command_cubit.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/cubit/oprating_command_states.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/models/get_all_operatings_model.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/models/operating_command_get_centers_model.dart';
import 'package:alrefadah/presentation/app/shared_widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddOpratingCommandBody extends StatefulWidget {
  const AddOpratingCommandBody({super.key});
  @override
  State<AddOpratingCommandBody> createState() => _AddOpratingCommandBodyState();
}

class _AddOpratingCommandBodyState extends State<AddOpratingCommandBody> {
  String transType = '0';
  final _opratController = TextEditingController();
  final _busQtyController = TextEditingController();

  OperatindCommandGetCentersModel? selectedCenter;
  @override
  void initState() {
    super.initState();
    context.read<OpratingCommandsCubit>().getCenters();
  }

  @override
  void dispose() {
    _opratController.dispose();
    _busQtyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpratingCommandsCubit, OperatingCommandState>(
      builder: (context, state) {
        if (state.isLoadingCenters || state.isLoadingAddOperating) {
          return const AppIndicator();
        } else if (state.centers.isNotEmpty) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: DropdownButtonFormField<String>(
                  padding: EdgeInsets.zero,
                  isExpanded: true,
                  dropdownColor: kScaffoldBackgroundColor,
                  decoration: InputDecoration(
                    border: dropdownBorderRadius(kMainColorLightColor),
                    focusedBorder: dropdownBorderRadius(kMainColorLightColor),
                    enabledBorder: dropdownBorderRadius(kMainColorLightColor),
                    focusedErrorBorder: dropdownBorderRadius(Colors.red),
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
                  hint: const Text('اختر المركز'),
                  value: selectedCenter?.fCenterNo.toString(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedCenter = state.centers.firstWhere(
                        (element) => element.fCenterNo.toString() == newValue,
                      );
                    });
                  },
                  items:
                      state.centers.map((center) {
                        return DropdownMenuItem<String>(
                          value: center.fCenterNo.toString(),
                          child: Text(center.fCenterName),
                        );
                      }).toList(),
                ),
              ),
              if (selectedCenter != null) ...[
                H(h: 16.h),
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      const H(h: 12),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: SingleChildScrollView(
                          child: Column(
                            spacing: 12.h,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'رقم أمر التشغيل',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kMainColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w300,
                                  height: 1.43.h,
                                ),
                              ),

                              CustomNumberTextformfield(
                                controller: _opratController,
                                textInputAction: TextInputAction.next,
                                text: 'رقم أمر التشغيل',
                              ),

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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              if (_opratController.text.isEmpty ||
                                  _busQtyController.text.isEmpty) {
                                showCustomSnackBar(
                                  context,
                                  'يجب إدخال البيانات المطلوبة',
                                  kErrorColor,
                                );
                              }
                              try {
                                final model = GetAllOperatingsModel(
                                  fOperatingNo: _opratController.text,

                                  ///
                                  fTransportType: int.parse(transType),

                                  ///
                                  fBusAco: int.parse(_busQtyController.text),

                                  ///
                                  fOperatingStatus: 1,

                                  ///
                                  fCenterNo: selectedCenter!.fCenterNo,
                                  center: CenterOprModel(
                                    fLastUpdate: DateTime.now(),
                                    isAdded: '1',
                                    fCenterCode: selectedCenter!.fCenterCode,
                                    fCenterName: selectedCenter!.fCenterName,
                                    fCenterNameE: selectedCenter!.fCenterNameE!,
                                    fCenterType: selectedCenter!.fCenterType!,
                                    fCenterEmail: selectedCenter!.fCenterEmail!,
                                    fCenterJaw: selectedCenter!.fCenterJaw!,
                                    fLatitudeMak:
                                        selectedCenter!.fLatitudeMak.toString(),
                                    fLongitudeMak:
                                        selectedCenter!.fLongitudeMak
                                            .toString(),
                                    fLatitudeArafat:
                                        selectedCenter!.fLatitudeArafat
                                            .toString(),
                                    fLongitudeArafat:
                                        selectedCenter!.fLongitudeArafat
                                            .toString(),
                                    fLatitudeMona:
                                        selectedCenter!.fLatitudeMona
                                            .toString(),
                                    fLongitudeMona:
                                        selectedCenter!.fLongitudeMona
                                            .toString(),
                                    fCenterTransport:
                                        selectedCenter!.fCenterTransport
                                            .toString(),
                                    fLastUpdateUser:
                                        selectedCenter!.fLastUpdateUser
                                            .toString(),
                                    fLastUpdateSum:
                                        selectedCenter!.fLastUpdateSum
                                            .toString(),
                                    fLastUpdateOper:
                                        selectedCenter!.fLastUpdateOper
                                            .toString(),
                                    fCompanyId:
                                        selectedCenter!.fCompanyId.toString(),
                                    fSeasonId:
                                        selectedCenter!.fSeasonId.toString(),
                                    fCenterNo:
                                        selectedCenter!.fCenterNo.toString(),
                                    fSectionNo:
                                        selectedCenter!.fSectionNo.toString(),
                                    fCenterStatus:
                                        selectedCenter!.fCenterStatus
                                            .toString(),
                                  ),
                                  fLastUpdateUser: 1,
                                  fLastUpdateSum: 0,
                                  fLastUpdateOper: 0,

                                  fCompanyId: selectedCenter!.fCompanyId,
                                  fSeasonId: selectedCenter!.fSeasonId,
                                  busReceiptCount: 0,

                                  /// المستلم
                                );
                                await context
                                    .read<OpratingCommandsCubit>()
                                    .addOperating(model);
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
                                showCustomSnackBar(
                                  context,
                                  'هناك خطأ في البيانات',
                                  kErrorColor,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        } else {
          return NoDataWidget(
            onPressed: () => context.read<OpratingCommandsCubit>().getCenters(),
          );
        }
      },
    );
  }

  Widget buildRadioOption({required String value, required String title}) {
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
            color: value == transType ? kMainColor : const Color(0xFFD6D6D6),
          ),
        ),
        child: Row(
          children: [
            Radio(
              value: value,
              onChanged: (value) {
                setState(() {
                  transType = value!;
                });
              },
              groupValue: transType,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              activeColor: kMainColor,
            ),
            Text(
              title,
              style: TextStyle(
                color:
                    value == transType ? kMainColor : const Color(0xFFD6D6D6),
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
