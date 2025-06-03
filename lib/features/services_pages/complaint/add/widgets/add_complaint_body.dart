import 'package:alrefadah/core/services/cache_helper.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_text_field_with_label.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/core/widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/core/widgets/custom_dialog/show_success_dialog.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_state.dart';
import 'package:alrefadah/features/services_pages/complaint/add/models/add_complaint_model.dart';
import 'package:alrefadah/features/services_pages/complaint/add/models/complaint_type_model.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_cubit.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/by_criteria/assignment_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddComplaintBody extends StatefulWidget {
  const AddComplaintBody({required this.trip, super.key});
  final TripModel trip;

  @override
  State<AddComplaintBody> createState() => _AddComplaintBodyState();
}

class _AddComplaintBodyState extends State<AddComplaintBody> {
  @override
  void initState() {
    super.initState();
    _getUserId();
    initData();
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

  Future<void> initData() async {
    await Future.wait([
      context.read<BusTravelCubit>().getComplaintType(),
      context.read<GuidesCubit>().getGuideByCriteria(widget.trip.fCenterNo),
    ]);

    ///
    final guidesState = context.read<GuidesCubit>().state;
    guidesList =
        guidesState.guidesByCriteria
            .where((emp) => emp.employee?.fEmpName.isNotEmpty ?? false)
            .toList();
    if (guidesState.isLoadingGetByCriteria && guidesList.isNotEmpty) {
      selectedGuide = guidesList.firstWhereOrNull(
        (guide) => guide.fEmpNo == widget.trip.fEmpNo,
      );
    }
  }

  AssignmentModel? selectedGuide;
  List<AssignmentModel> guidesList = [];
  ComplaintTypeModel? selectedComplaintType;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusTravelCubit, BusTravelState>(
      builder: (context, state) {
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

                        /// الموسم والمركز
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

                        /// المرحلة
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

                        /// رقم الحافلة
                        CustomTextFieldWithLabel(
                          readOnly: true,
                          text: 'رقم الحافلة',
                          controller: TextEditingController(
                            text: widget.trip.fBus.fBusNo,
                          ),
                          enabled: false,
                        ),

                        /// الشركة الناقلة
                        CustomTextFieldWithLabel(
                          readOnly: true,
                          controller: TextEditingController(
                            text: widget.trip.fBus.transport?.fTransportName,
                          ),
                          text: 'الشركة الناقلة',
                          enabled: false,
                        ),

                        /// أمر التشغيل وعدد الحجاج
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

                        /// المسار
                        CustomTextFieldWithLabel(
                          enabled: false,
                          text: 'المسار',
                          controller: TextEditingController(
                            text: widget.trip.fTrackNo.toString(),
                          ),
                        ),

                        /// المرشد
                        CustomTextFieldWithLabel(
                          enabled: false,
                          text: 'المرشد',
                          controller: TextEditingController(
                            text:
                                guidesList.contains(selectedGuide)
                                    ? selectedGuide!.employee?.fEmpName
                                    : 'لم يتم اختيار مرشد',
                          ),
                        ),

                        /// نوع البلاغ
                        DropdownButtonFormField<ComplaintTypeModel>(
                          validator: (value) {
                            if (value == null) {
                              return 'الرجاء إدخال نوع البلاغ';
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

                        /// الملاحظات
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

                /// Button
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomButton(text: 'إضافة بلاغ', onTap: _handleAdd),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  /// handle add Button
  Future<void> _handleAdd() async {
    try {
      await context.read<BusTravelCubit>().addComplaint(
        AddComplaintModel(
          fComplaintNo: 1,
          fComplaintTypeNo: selectedComplaintType!.fComplaintTypeNo,
          fCompanyId: companyId,
          fSeasonId: int.parse(widget.trip.fSeasonId),
          fComplaintTypeName: selectedComplaintType!.fComplaintTypeName,
          fCenterNo: int.parse(widget.trip.fCenterNo),
          fCenterName: widget.trip.fCenterNo,
          fBusId: int.parse(widget.trip.fBusId),
          fBusName: widget.trip.fBus.fBusNo,
          fComplaintDate: DateTime.now(),
          fComplaintDescription: _notesController.text,
          fComplaintStatus: selectedComplaintType!.fComplaintTypeStatus!,
          fAdditionDate: DateTime.now(),
          fAdditionUser: userId!,
          fAdditionUserName: widget.trip.fAdditionUser,
        ),
      );
      if (context.read<BusTravelCubit>().state.isSuccessAddcomplaint) {
        await context.read<BusTravelCubit>().getTripsByStage(
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
  }
}
