import 'package:alrefadah/core/services/cache_helper.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_text_field_with_label.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/core/widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/core/widgets/custom_dialog/show_success_dialog.dart';
import 'package:alrefadah/core/widgets/custom_dropdown/inactive_dropdown.dart';
import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_states.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/get_all_buses_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/add_trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/track_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_state.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_cubit.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_states.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/by_criteria/assignment_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class EditTripByStage extends StatefulWidget {
  const EditTripByStage({required this.trip, super.key});
  final TripModel trip;
  @override
  State<EditTripByStage> createState() => _EditTripByStageState();
}

class _EditTripByStageState extends State<EditTripByStage> {
  @override
  void initState() {
    super.initState();
    initData();
    _getUserId();
  }

  Future<void> _getUserId() async {
    userId = await CacheHelper.getUserId();
  }

  int? userId;
  Future<void> initData() async {
    await Future.wait([
      context.read<BusTravelCubit>().getTripsByStage(
        widget.trip.fCenterNo,
        widget.trip.fStageNo,
      ),
      context.read<BusTravelCubit>().getTrackTrip(),
      context.read<GuidesCubit>().getGuideByCriteria(widget.trip.fCenterNo),
      context.read<BusesCubit>().getAllBusesByCrietia(widget.trip.fCenterNo),
    ]);
    final busesState = context.read<BusesCubit>().state;
    busesList =
        busesState.allBusesByCrietia
            .where((bus) => bus.fBusNo != null && bus.fBusNo.isNotEmpty)
            .toList();

    selectedBus = busesList.firstWhereOrNull(
      (bus) => bus.fBusNo == widget.trip.fBus.fBusNo,
    );
    final trackStates = context.read<BusTravelCubit>().state;
    trackTrip =
        trackStates.track.where((track) {
          final trackName = track.fTrackName;
          return trackName != null && trackName.isNotEmpty;
        }).toList();
    selectedTrack = trackTrip.firstWhere(
      (track) => track.fTrackNo == widget.trip.fTrackNo,
      orElse: TrackModel.new, // Replace with a default TrackModel instance
    );

    ///
    final guidesState = context.read<GuidesCubit>().state;
    guidesList =
        guidesState.guidesByCriteria
            .where((emp) => emp.employee?.fEmpName.isNotEmpty ?? false)
            .toList();
  }

  /// controllers
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int? selectedGuide;
  TrackModel? selectedTrack;
  List<TrackModel> trackTrip = [];
  GetAllBusesModel? selectedBus;
  List<GetAllBusesModel> busesList = [];
  List<AssignmentModel> guidesList = [];
  String transType = '0';
  bool? isGuideSelected;
  final formattedDate = DateFormat('yyyyMMdd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusTravelCubit, BusTravelState>(
      builder: (context, state) {
        final busTravelState = context.read<BusTravelCubit>().state;

        return BlocBuilder<GuidesCubit, GuidesState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: const LeadingIcon(),
                title: TitleAppBar(title: 'تعديل رحلة: ${widget.trip.fTripNo}'),
              ),
              body:
                  busTravelState.isAddingTripByStage ||
                          busTravelState.isLoadingTripsByStage ||
                          context
                              .read<BusesCubit>()
                              .state
                              .isLoadingAllBusesByCrietia
                      ? const AppIndicator()
                      : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: AutofillGroup(
                          onDisposeAction: AutofillContextAction.cancel,
                          child: Form(
                            key: formKey,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,

                                    spacing: 16.h,
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
                                              text: 'موسم',
                                              readOnly: true,
                                              enabled: false,
                                            ),
                                          ),
                                          Expanded(
                                            child: CustomTextFieldWithLabel(
                                              controller: TextEditingController(
                                                text: widget.trip.fCenterNo,
                                              ),
                                              text: 'رقم المركز',
                                              readOnly: true,
                                              enabled: false,
                                            ),
                                          ),
                                        ],
                                      ),

                                      CustomTextFieldWithLabel(
                                        readOnly: true,
                                        controller: TextEditingController(
                                          text: context
                                              .read<BusTravelCubit>()
                                              .getStageName(
                                                widget.trip.fStageNo,
                                              ),
                                        ),
                                        text: 'المرحلة',
                                        enabled: false,
                                      ),
                                      BlocBuilder<BusesCubit, BusesState>(
                                        builder: (context, state) {
                                          /// رقم الحافلة
                                          return DropdownButtonFormField<
                                            GetAllBusesModel
                                          >(
                                            validator: (value) {
                                              if (value == null) {
                                                return 'الرجاء إدخال رقم الحافلة';
                                              }
                                              return null;
                                            },
                                            isExpanded: true,
                                            dropdownColor:
                                                kScaffoldBackgroundColor,

                                            decoration: InputDecoration(
                                              border: dropdownBorderRadius(
                                                kMainColorLightColor,
                                              ),
                                              focusedBorder:
                                                  dropdownBorderRadius(
                                                    kMainColorLightColor,
                                                  ),
                                              enabledBorder:
                                                  dropdownBorderRadius(
                                                    kMainColorLightColor,
                                                  ),
                                              focusedErrorBorder:
                                                  dropdownBorderRadius(
                                                    kErrorColor,
                                                  ),
                                              label: Text(
                                                'رقم الحافلة',
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: const Color(
                                                    0xFFA2A2A2,
                                                  ),
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

                                            value: selectedBus,
                                            items:
                                                busesList.map((bus) {
                                                  final busNo = bus.fBusNo;
                                                  return DropdownMenuItem<
                                                    GetAllBusesModel
                                                  >(
                                                    value: bus,
                                                    child: Text(busNo),
                                                  );
                                                }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedBus = newValue;
                                              });
                                            },
                                          );
                                        },
                                      ),

                                      /// الشركة الناقلة
                                      if (selectedBus != null)
                                        InActiveDropdown(
                                          text: selectedBus!.fTransportName,
                                          value: selectedBus!.fTransportNo,
                                          label: 'الشركة الناقلة',
                                        ),
                                      if (selectedBus != null)
                                        Row(
                                          spacing: 12.w,
                                          children: [
                                            /// رقم التشغيل
                                            Expanded(
                                              child: DropdownButtonFormField<
                                                String
                                              >(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                decoration: InputDecoration(
                                                  fillColor:
                                                      kScaffoldBackgroundColor,
                                                  filled: true,
                                                  border: textfieldBorderRadius(
                                                    kMainColorLightColor,
                                                  ),
                                                  focusedBorder:
                                                      textfieldBorderRadius(
                                                        kMainColorLightColor,
                                                      ),
                                                  enabledBorder:
                                                      textfieldBorderRadius(
                                                        kMainColorLightColor,
                                                      ),
                                                  focusedErrorBorder:
                                                      textfieldBorderRadius(
                                                        kErrorColor,
                                                      ),
                                                  label: Text(
                                                    'رقم التشغيل',
                                                    style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: const Color(
                                                        0xFFA2A2A2,
                                                      ),
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                ),
                                                icon: const Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                ),
                                                style: TextStyle(
                                                  color: kMainColor,
                                                  fontSize: 15.sp,
                                                  fontFamily: 'GE SS Two',
                                                  fontWeight: FontWeight.w300,
                                                  height: 1.43.h,
                                                ),
                                                value:
                                                    selectedBus!.fOperatingNo,
                                                items: [
                                                  DropdownMenuItem<String>(
                                                    value:
                                                        selectedBus!
                                                            .fOperatingNo,
                                                    child: Text(
                                                      selectedBus!.fOperatingNo,
                                                    ),
                                                  ),
                                                ],
                                                onChanged: null,
                                              ),
                                            ),

                                            /// عدد الحجاج
                                            Expanded(
                                              child: InActiveDropdown(
                                                text:
                                                    selectedBus!.fPilgrimsAco
                                                        .toString(),
                                                value:
                                                    selectedBus!.fPilgrimsAco,

                                                label: 'عدد الحجاج',
                                              ),
                                            ),
                                          ],
                                        ),

                                      /// المسار
                                      DropdownButtonFormField<TrackModel>(
                                        validator: (value) {
                                          if (value == null) {
                                            return 'الرجاء اختيار المسار';
                                          }
                                          return null;
                                        },
                                        isExpanded: true,
                                        dropdownColor: kScaffoldBackgroundColor,

                                        decoration: InputDecoration(
                                          border: dropdownBorderRadius(
                                            kMainColorLightColor,
                                          ),
                                          focusedBorder: dropdownBorderRadius(
                                            kMainColorLightColor,
                                          ),
                                          enabledBorder: dropdownBorderRadius(
                                            kMainColorLightColor,
                                          ),
                                          focusedErrorBorder:
                                              dropdownBorderRadius(kErrorColor),
                                          label: Text(
                                            'المسار',
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
                                        value: selectedTrack,
                                        items:
                                            trackTrip.map((track) {
                                              return DropdownMenuItem<
                                                TrackModel
                                              >(
                                                value: track,
                                                child: Text(
                                                  track.fTrackName ?? '',
                                                ),
                                              );
                                            }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedTrack = newValue;
                                          });
                                        },
                                      ),

                                      /// اختيار مرشد
                                      if (widget.trip.fStageNo == '1' ||
                                          widget.trip.fStageNo == '2' ||
                                          widget.trip.fStageNo == '6' ||
                                          widget.trip.fStageNo == '7')
                                        //   Row(
                                        //     children: [
                                        //       Text(
                                        //         'اختيار المرشد',
                                        //         style: TextStyle(
                                        //           color: kMainColor,
                                        //           fontSize: 14.sp,
                                        //           fontWeight: FontWeight.w300,
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.spaceBetween,
                                        //   children: [
                                        //     buildRadioOption(
                                        //       title: 'يوجد',
                                        //       value: '1',
                                        //     ),
                                        //     buildRadioOption(
                                        //       title: 'لا يوجد',
                                        //       value: '2',
                                        //     ),
                                        //   ],
                                        // ),
                                        // if (selectedGuide != null)
                                        DropdownButtonFormField<int>(
                                          isExpanded: true,
                                          dropdownColor:
                                              kScaffoldBackgroundColor,

                                          decoration: InputDecoration(
                                            border: dropdownBorderRadius(
                                              kMainColorLightColor,
                                            ),
                                            focusedBorder: dropdownBorderRadius(
                                              kMainColorLightColor,
                                            ),
                                            enabledBorder: dropdownBorderRadius(
                                              kMainColorLightColor,
                                            ),
                                            focusedErrorBorder:
                                                dropdownBorderRadius(
                                                  Colors.red,
                                                ),
                                            label: Text(
                                              'المرشد',
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
                                          value:
                                              guidesList
                                                  .firstWhereOrNull(
                                                    (guide) =>
                                                        guide.fEmpNo ==
                                                        widget.trip.fEmpNo,
                                                  )
                                                  ?.fEmpNo,

                                          items:
                                              guidesList.map((guide) {
                                                return DropdownMenuItem<int>(
                                                  value: guide.fEmpNo,
                                                  child: Text(
                                                    guide.employee!.fEmpName,
                                                  ),
                                                );
                                              }).toList(),

                                          onChanged: (int? newValue) {
                                            setState(() {
                                              selectedGuide = newValue;
                                            });
                                          },
                                        ),

                                      H(h: 120.h),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 0.h,
                                  left: 0,
                                  right: 0,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 20.h),
                                    child:
                                    /// Saved
                                    /// تحميل الداتا
                                    CustomButton(
                                      text: 'حفظ',
                                      onTap: () async {
                                        if (formKey.currentState!.validate()) {
                                          try {
                                            final inputs = AddTripModel(
                                              /// أخر تحديث
                                              fLastUpdate:
                                                  DateTime.now()
                                                      .toIso8601String(),

                                              /// أخر تحديث
                                              fLastUpdateUser: 1,

                                              /// أخر تحديث
                                              fLastUpdateSum: 1,

                                              /// أخر تحديث
                                              fLastUpdateOper: 0,

                                              /// الشركة الناقلة
                                              fCompanyId: companyId,

                                              /// الموسم
                                              fSeasonId: int.parse(
                                                widget.trip.fSeasonId,
                                              ),

                                              /// حالة الرحلة
                                              fTripStstus: 1,

                                              /// المركز
                                              fCenterNo: int.parse(
                                                widget.trip.fCenterNo,
                                              ),

                                              /// المرحلة
                                              fStageNo: int.parse(
                                                widget.trip.fStageNo,
                                              ),

                                              /// رقم الرحلة
                                              fTripNo: int.parse(
                                                widget.trip.fTripNo,
                                              ),

                                              /// تاريخ الرحلة
                                              fTripDate: widget.trip.fTripDate,

                                              /// وقت الرحلة
                                              fTripTime: widget.trip.fTripTime,

                                              /// رقم الحافلة
                                              fBusId: selectedBus!.fBusId,

                                              /// عدد الحجاج
                                              fPilgrimsAco: int.parse(
                                                widget.trip.fPilgrimsAco,
                                              ),

                                              /// تاريخ الإضافة
                                              fAdditionDate:
                                                  widget.trip.fAdditionDate
                                                      .toIso8601String(),

                                              /// المستخدم
                                              fAdditionUser: userId.toString(),

                                              /// خط العرض
                                              fAdditionLatitude:
                                                  widget.trip.fAdditionLatitude,

                                              /// خط الطول
                                              fAdditionLongitude:
                                                  widget
                                                      .trip
                                                      .fAdditionLongitude,

                                              /// تاريخ الوصول
                                              fReceiptDate:
                                                  DateTime.now()
                                                      .toIso8601String(),

                                              /// المستلم
                                              fReceiptUser: null,

                                              /// خط العرض
                                              fReceiptLatitude:
                                                  widget.trip.fReceiptLatitude,

                                              /// خط الطول
                                              fReceiptLongitude:
                                                  widget.trip.fReceiptLongitude,

                                              /// تاريخ الموافقة
                                              fApprovalDate:
                                                  DateTime.now()
                                                      .toIso8601String(),

                                              /// المستخدم الموافق
                                              fApprovalUser: null,

                                              /// خط العرض للموافقة
                                              fApprovalLatitude:
                                                  widget.trip.fApprovalLatitude,

                                              /// خط الطول للموافقة
                                              fApprovalLongitude:
                                                  widget
                                                      .trip
                                                      .fApprovalLongitude,

                                              /// رقم الموظف
                                              fEmpNo: selectedGuide,
                                              fTrackNo:
                                                  selectedTrack!.fTrackNo!,
                                            );

                                            await context
                                                .read<BusTravelCubit>()
                                                .editTripByStage(inputs);
                                            if (context
                                                .read<BusTravelCubit>()
                                                .state
                                                .isEditingTripByStageSuccess) {
                                              await context
                                                  .read<BusTravelCubit>()
                                                  .getTripsByStage(
                                                    widget.trip.fCenterNo,
                                                    widget.trip.fStageNo,
                                                  );
                                              if (context.mounted) {
                                                showSuccessDialog(
                                                  context,
                                                  title:
                                                      'تم تعديل الرحلة بنجاح',
                                                );
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
                                              showErrorDialog(
                                                isBack: true,
                                                context,
                                                message:
                                                    'لم يتم حفظ التعديل لوجود خطأ',
                                                icon:
                                                    Icons.error_outline_rounded,
                                                color: kErrorColor,
                                              );
                                            }
                                          } catch (e) {
                                            showErrorDialog(
                                              isBack: true,
                                              context,
                                              message:
                                                  'ليس لديك صلاحية لتعديل الرحلة',
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
                          ),
                        ),
                      ),
            );
          },
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
            color:
                isGuideSelected == false
                    ? (Colors.red[900] ?? Colors.red)
                    : isSelected
                    ? kMainColor
                    : const Color(0xFFD6D6D6),
          ),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: transType, // ✅ هذا هو المفتاح
              onChanged: (val) {
                setState(() {
                  isGuideSelected = true;
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
