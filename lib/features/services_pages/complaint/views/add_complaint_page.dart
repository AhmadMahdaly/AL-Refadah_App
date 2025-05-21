import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/services/cache_helper.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_text_field_with_label.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/core/widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/core/widgets/custom_dialog/show_success_dialog.dart';
import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_state.dart';
import 'package:alrefadah/features/services_pages/complaint/models/add_complaint_model.dart';
import 'package:alrefadah/features/services_pages/complaint/models/complaint_type_model.dart';

class AddComplaintPage extends StatefulWidget {
  const AddComplaintPage({required this.trip, super.key});
  final TripModel trip;
  @override
  State<AddComplaintPage> createState() => _AddComplaintPageState();
}

class _AddComplaintPageState extends State<AddComplaintPage> {
  @override
  void initState() {
    context.read<BusTravelCubit>().getComplaintType();
    super.initState();
    _getUserId();
  }

  Future<void> _getUserId() async {
    userId = await CacheHelper.getUserId();
  }

  int? userId;
  final _notesController = TextEditingController();
  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  ComplaintTypeModel? selectedComplaintType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const LeadingIcon(),
        title: TitleAppBar(title: 'إضافة بلاغ لرحلة: ${widget.trip.fTripNo}'),
      ),
      body: BlocBuilder<BusTravelCubit, BusesTravelState>(
        builder: (context, state) {
          final cubit = context.read<BusTravelCubit>();
          if (state.isLoadingAddcomplaint ||
              state.isLoadingcomplaintType ||
              state.isLoadingTripsByStage) {
            return const AppIndicator();
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Form(
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 12.h,
                        children: [
                          const H(h: 0),
                          Row(
                            spacing: 12.w,
                            children: [
                              Expanded(
                                child: CustomTextFieldWithLabel(
                                  controller: TextEditingController(
                                    text: widget.trip.fSeasonId,
                                  ),
                                  text: 'الموسم',
                                  readOnly: true,
                                  enabled: false,
                                ),
                              ),
                              Expanded(
                                child: CustomTextFieldWithLabel(
                                  controller: TextEditingController(
                                    text: widget.trip.fCenterNo,
                                  ),
                                  text: 'المركز',
                                  readOnly: true,
                                  enabled: false,
                                ),
                              ),
                            ],
                          ),

                          CustomTextFieldWithLabel(
                            readOnly: true,
                            controller: TextEditingController(
                              text: context.read<BusTravelCubit>().getStageName(
                                widget.trip.fStageNo,
                              ),
                            ),
                            text: 'المرحلة',
                            enabled: false,
                          ),
                          CustomTextFieldWithLabel(
                            readOnly: true,
                            text: 'رقم الحافلة',
                            controller: TextEditingController(
                              text: widget.trip.fBusId,
                            ),
                            enabled: false,
                          ),
                          CustomTextFieldWithLabel(
                            readOnly: true,
                            controller: TextEditingController(
                              text: widget.trip.fBus.transport?.fTransportName,
                            ),
                            text: 'الشركة الناقلة',
                            enabled: false,
                          ),
                          Row(
                            spacing: 12.w,
                            children: [
                              Expanded(
                                child: CustomTextFieldWithLabel(
                                  enabled: false,
                                  readOnly: true,
                                  text: 'أمر التشغيل',
                                  controller: TextEditingController(
                                    text: widget.trip.fBus.fOperatingNo,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: CustomTextFieldWithLabel(
                                  enabled: false,
                                  readOnly: true,
                                  text: 'عدد الحجاج',
                                  controller: TextEditingController(
                                    text: widget.trip.fPilgrimsAco,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          CustomTextFieldWithLabel(
                            enabled: false,
                            text: 'المسار',
                            controller: TextEditingController(
                              text: widget.trip.fTrackNo.toString(),
                            ),
                          ),
                          CustomTextFieldWithLabel(
                            enabled: false,
                            text: 'المرشد',
                            controller: TextEditingController(
                              text: widget.trip.fTrackNo.toString(),
                            ),
                          ),
                          DropdownButtonFormField<ComplaintTypeModel>(
                            validator: (value) {
                              if (value == null) {
                                return 'الرجاء إدخال رقم الحافلة';
                              }
                              return null;
                            },
                            isExpanded: true,
                            dropdownColor: kScaffoldBackgroundColor,

                            decoration: InputDecoration(
                              border: dropdownBorderRadius(kAnalysisLightColor),
                              focusedBorder: dropdownBorderRadius(
                                kAnalysisLightColor,
                              ),
                              enabledBorder: dropdownBorderRadius(
                                kAnalysisLightColor,
                              ),
                              focusedErrorBorder: dropdownBorderRadius(
                                kErrorColor,
                              ),
                              label: Text(
                                'اختر نوع البلاغ',
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
                              height: 1.25.h,
                            ),

                            value: selectedComplaintType,
                            items:
                                state.complaintType.map((type) {
                                  return DropdownMenuItem<ComplaintTypeModel>(
                                    value: type,
                                    child: Text(type.fComplaintTypeName),
                                  );
                                }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedComplaintType = newValue;
                              });
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: const Color(0xFF494949),
                              fontWeight: FontWeight.w300,
                              fontFamily: 'FF Shamel Family',
                            ),
                            cursorWidth: 1.sp,
                            cursorColor: kMainColor,
                            minLines: 1,
                            maxLines: 2,
                            controller: _notesController,
                            autovalidateMode: AutovalidateMode.onUnfocus,
                            decoration: InputDecoration(
                              labelText: 'الملاحظات',
                              labelStyle: TextStyle(
                                fontSize: 13.sp,
                                color: const Color(0xFFA2A2A2),
                                fontWeight: FontWeight.w300,
                              ),
                              border: textfieldBorderRadius(
                                const Color(0xFFD6D6D6),
                              ),
                              focusedBorder: textfieldBorderRadius(kMainColor),
                              enabledBorder: textfieldBorderRadius(
                                const Color(0xFFD6D6D6),
                              ),
                              focusedErrorBorder: textfieldBorderRadius(
                                Colors.red,
                              ),
                            ),
                          ),
                          const H(h: 100),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CustomButton(
                        text: 'إضافة بلاغ',
                        onTap: () async {
                          try {
                            await cubit.addComplaint(
                              AddComplaintModel(
                                fComplaintNo: 1,
                                fComplaintTypeNo:
                                    selectedComplaintType!.fComplaintTypeNo,
                                fCompanyId: companyId,
                                fSeasonId: int.parse(widget.trip.fSeasonId),
                                fComplaintTypeName:
                                    selectedComplaintType!.fComplaintTypeName,
                                fCenterNo: int.parse(widget.trip.fCenterNo),
                                fCenterName: widget.trip.fCenterNo,
                                fBusId: int.parse(widget.trip.fBusId),
                                fBusName: widget.trip.fBus.fBusNo,
                                fComplaintDate: DateTime.now(),
                                fComplaintDescription: _notesController.text,
                                fComplaintStatus:
                                    selectedComplaintType!
                                        .fComplaintTypeStatus!,
                                fAdditionDate: DateTime.now(),
                                fAdditionUser: userId!,
                                fAdditionUserName: widget.trip.fAdditionUser,
                              ),
                            );
                            if (context
                                .read<BusTravelCubit>()
                                .state
                                .isSuccessAddcomplaint) {
                              await context
                                  .read<BusTravelCubit>()
                                  .getTripsByStage(
                                    widget.trip.fCenterNo,
                                    widget.trip.fStageNo,
                                  );
                              if (context.mounted) {
                                showSuccessDialog(context);
                                Future.delayed(const Duration(seconds: 2), () {
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                });
                              }
                            } else {
                              if (context.mounted) {
                                showErrorDialog(
                                  isBack: true,
                                  context,
                                  message: 'هناك خطأ في إضافة البلاغ',
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
                                message: 'هناك خطأ في إضافة البلاغ',
                                icon: Icons.error_outline_rounded,
                                color: kErrorColor,
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
