import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_text_field_with_label.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/core/widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/core/widgets/custom_dialog/show_success_dialog.dart';
import 'package:alrefadah/core/widgets/custom_dropdown/inactive_dropdown.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/home_page/cubit/home_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_states.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/get_all_buses_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/add_bus/widgets/add_bus_page_body.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/add_trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/track_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_state.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_trip_model.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_cubit.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_states.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/by_criteria/assignment_model.dart';
import 'package:alrefadah/presentation/app/shared_cubit/get_current_location_cubit/get_current_location_cubit.dart';
import 'package:alrefadah/presentation/app/shared_widgets/loading_location.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AddTripBody extends StatefulWidget {
  const AddTripBody({
    required this.tripsByStage,
    required this.trip,
    super.key,
  });
  final BusesTravelGetTripModel trip;
  final List<TripModel> tripsByStage;
  @override
  State<AddTripBody> createState() => _AddTripBodyState();
}

class _AddTripBodyState extends State<AddTripBody> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    stageNameController.text = context.read<BusTravelCubit>().getStageName(
      widget.trip.fStageNo,
    );
    centerNoController.text = widget.trip.fCenterNo;
    seasonIdController.text = widget.trip.fSeasonId;

    await Future.wait([
      context.read<BusTravelCubit>().getTripsByStage(
        widget.trip.fCenterNo,
        widget.trip.fStageNo,
      ),
      context.read<BusTravelCubit>().getTrackTrip(),
      context.read<GuidesCubit>().getGuideByCriteria(widget.trip.fCenterNo),
      context.read<BusesCubit>().getAllBusesByCrietia(widget.trip.fCenterNo),
    ]);
  }

  /// controllers
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final centerNoController = TextEditingController();
  final seasonIdController = TextEditingController();
  final stageNameController = TextEditingController();

  @override
  void dispose() {
    centerNoController.dispose();
    seasonIdController.dispose();
    stageNameController.dispose();
    super.dispose();
  }

  TrackModel? selectedTrack;
  GetAllBusesModel? selectedBus;
  AssignmentModel? selectedGuide;
  String transType = '0';
  bool? isGuideSelected;
  final formattedDate = DateFormat('yyyyMMdd').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusTravelCubit, BusesTravelState>(
      builder: (context, state) {
        final trackTrip = state.track.where((track) {
          final trackName = track.fTrackName;
          return trackName != null && trackName.isNotEmpty;
        }).toList();
        final busTravelState = context.read<BusTravelCubit>().state;

        /// Build: BusesCubit
        return BlocBuilder<BusesCubit, BusesState>(
          builder: (context, state) {
            final busesState = context.read<BusesCubit>().state;
            final busItems = busesState.allBusesByCrietia.where((bus) {
              final fBusId = bus.fBusId;
              return fBusId != null && fBusId.isNotEmpty;
            }).toList();

            /// Build: GuidesCubit
            return BlocBuilder<GuidesCubit, GuidesState>(
              builder: (context, state) {
                final centerGuides = state.guidesByCriteria.where((emp) {
                  final name = emp.employee?.fEmpName;
                  return name != null && name.isNotEmpty;
                }).toList();

                /// Build: GetCurrentLocationCubit
                return BlocBuilder<
                  GetCurrentLocationCubit,
                  GetCurrentLocationState
                >(
                  builder: (context, state) {
                    return state is GetCurrentLocationLoading ||
                            busTravelState.isAddingTripByStage ||
                            busTravelState.isLoadingTripsByStage ||
                            busesState.isLoadingAllBusesByCrietia
                        ? const AppIndicator()
                        : state is GetCurrentLocationSuccess
                        ? Padding(
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
                                          Row(
                                            spacing: 8.w,
                                            children: [
                                              /// الموسم
                                              Expanded(
                                                child: CustomTextFieldWithLabel(
                                                  controller:
                                                      seasonIdController,
                                                  text: 'الموسم',
                                                  readOnly: true,
                                                  enabled: false,
                                                ),
                                              ),

                                              /// المركز
                                              Expanded(
                                                child: CustomTextFieldWithLabel(
                                                  controller:
                                                      centerNoController,
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
                                            controller: stageNameController,
                                            text: 'المرحلة',
                                            enabled: false,
                                          ),
                                          Row(
                                            spacing: 8.w,
                                            children: [
                                              Expanded(
                                                child:
                                                    /// رقم الحافلة
                                                    DropdownSearch<
                                                      GetAllBusesModel
                                                    >(
                                                      items: busItems,
                                                      selectedItem: selectedBus,
                                                      itemAsString:
                                                          (
                                                            GetAllBusesModel
                                                            bus,
                                                          ) =>
                                                              convertArabicToLatin(
                                                                bus.fBusNo,
                                                              ),
                                                      dropdownDecoratorProps: DropDownDecoratorProps(
                                                        dropdownSearchDecoration: InputDecoration(
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
                                                              color:
                                                                  const Color(
                                                                    0xFFA2A2A2,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      popupProps: PopupProps.menu(
                                                        menuProps: MenuProps(
                                                          shape: BeveledRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  12.r,
                                                                ),
                                                          ),
                                                        ),
                                                        showSearchBox: true,
                                                        searchFieldProps: TextFieldProps(
                                                          inputFormatters: [
                                                            ArabicToLatinDigitsFormatter(), // ✅ هنا نستخدم الفلتر
                                                          ],
                                                          decoration: InputDecoration(
                                                            label: Text(
                                                              'ابحث برقم الحافلة',
                                                              style: TextStyle(
                                                                fontSize: 13.sp,
                                                                color:
                                                                    const Color(
                                                                      0xFFA2A2A2,
                                                                    ),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                            ),

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
                                                          ),
                                                        ),
                                                        itemBuilder:
                                                            (
                                                              context,
                                                              GetAllBusesModel
                                                              bus,
                                                              isSelected,
                                                            ) => ListTile(
                                                              title: Text(
                                                                bus.fBusNo,
                                                                style: TextStyle(
                                                                  color:
                                                                      isSelected
                                                                      ? kMainColor
                                                                      : Colors
                                                                            .black,
                                                                  fontSize:
                                                                      14.sp,
                                                                ),
                                                              ),
                                                            ),
                                                      ),
                                                      validator: (value) {
                                                        if (value == null) {
                                                          return 'الرجاء اختيار رقم الحافلة';
                                                        }
                                                        return null;
                                                      },
                                                      onChanged:
                                                          (
                                                            GetAllBusesModel?
                                                            newValue,
                                                          ) {
                                                            setState(() {
                                                              selectedBus =
                                                                  newValue;
                                                            });
                                                          },
                                                    ),

                                                // DropdownButtonFormField<
                                                //   GetAllBusesModel
                                                // >(
                                                //   validator: (value) {
                                                //     if (value == null) {
                                                //       return 'الرجاء إدخال رقم الحافلة';
                                                //     }
                                                //     return null;
                                                //   },
                                                //   isExpanded: true,
                                                //   dropdownColor:
                                                //       kScaffoldBackgroundColor,

                                                //   decoration: InputDecoration(
                                                //     border: dropdownBorderRadius(
                                                //       kMainColorLightColor,
                                                //     ),
                                                //     focusedBorder:
                                                //         dropdownBorderRadius(
                                                //           kMainColorLightColor,
                                                //         ),
                                                //     enabledBorder:
                                                //         dropdownBorderRadius(
                                                //           kMainColorLightColor,
                                                //         ),
                                                //     focusedErrorBorder:
                                                //         dropdownBorderRadius(
                                                //           kErrorColor,
                                                //         ),
                                                //     label: Text(
                                                //       'رقم الحافلة',
                                                //       style: TextStyle(
                                                //         fontSize: 13.sp,
                                                //         color: const Color(
                                                //           0xFFA2A2A2,
                                                //         ),
                                                //         fontWeight:
                                                //             FontWeight.w300,
                                                //       ),
                                                //     ),
                                                //   ),
                                                //   icon: const Icon(
                                                //     Icons
                                                //         .keyboard_arrow_down_rounded,
                                                //     color: kMainColor,
                                                //   ),
                                                //   style: TextStyle(
                                                //     color: kMainColor,
                                                //     fontSize: 15.sp,
                                                //     fontFamily: 'GE SS Two',
                                                //     fontWeight: FontWeight.w300,
                                                //     height: 1.25.h,
                                                //   ),
                                                //   value: selectedBus,
                                                //   items:
                                                //       busItems.map((bus) {
                                                //         final busNo = bus.fBusNo;
                                                //         return DropdownMenuItem<
                                                //           GetAllBusesModel
                                                //         >(
                                                //           value: bus,
                                                //           child: Text(busNo),
                                                //         );
                                                //       }).toList(),
                                                //   onChanged: (
                                                //     GetAllBusesModel? newValue,
                                                //   ) {
                                                //     setState(() {
                                                //       selectedBus = newValue;
                                                //     });
                                                //   },
                                                // ),
                                              ),
                                              SizedBox(
                                                width: 50.w,
                                                child: InkWell(
                                                  onTap: () {
                                                    final rootContext =
                                                        Navigator.of(
                                                          context,
                                                          rootNavigator: true,
                                                        ).context;
                                                    showModalBottomSheet<void>(
                                                      backgroundColor:
                                                          kScaffoldBackgroundColor,
                                                      useSafeArea: true,
                                                      isDismissible: true,
                                                      enableDrag: true,
                                                      useRootNavigator: true,
                                                      showDragHandle: true,
                                                      isScrollControlled: true,
                                                      shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.vertical(
                                                              top:
                                                                  Radius.circular(
                                                                    16,
                                                                  ),
                                                            ),
                                                      ),
                                                      context: context,
                                                      builder: (context) => Padding(
                                                        padding: EdgeInsets.only(
                                                          bottom: MediaQuery.of(
                                                            context,
                                                          ).viewInsets.bottom,
                                                        ),
                                                        child: SizedBox(
                                                          height:
                                                              MediaQuery.of(
                                                                context,
                                                              ).size.height *
                                                              0.95, //  تقريـبًا fullscreen
                                                          child: SingleChildScrollView(
                                                            child: AddBusPageBody(
                                                              trip: widget.trip,
                                                              rootContext:
                                                                  rootContext,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.add_circle_rounded,
                                                    size: 40.sp,
                                                    color: kMainColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          /// الشركة الناقلة
                                          if (selectedBus != null)
                                            InActiveDropdown(
                                              text: selectedBus!.fTransportName,
                                              value: selectedBus!.fTransportNo,
                                              label: 'الشركة الناقلة',
                                            ),
                                          if (selectedBus != null)
                                            // Row(
                                            //   spacing: 12.w,
                                            //   children: [
                                            //     /// رقم التشغيل
                                            //     Expanded(
                                            //       child: DropdownButtonFormField<
                                            //         String
                                            //       >(
                                            //         borderRadius:
                                            //             BorderRadius.circular(
                                            //               10.r,
                                            //             ),
                                            //         decoration: InputDecoration(
                                            //           fillColor:
                                            //               kScaffoldBackgroundColor,
                                            //           filled: true,
                                            //           border:
                                            //               textfieldBorderRadius(
                                            //                 kMainColorLightColor,
                                            //               ),
                                            //           focusedBorder:
                                            //               textfieldBorderRadius(
                                            //                 kMainColorLightColor,
                                            //               ),
                                            //           enabledBorder:
                                            //               textfieldBorderRadius(
                                            //                 kMainColorLightColor,
                                            //               ),
                                            //           focusedErrorBorder:
                                            //               textfieldBorderRadius(
                                            //                 kErrorColor,
                                            //               ),
                                            //           label: Text(
                                            //             'رقم التشغيل',
                                            //             style: TextStyle(
                                            //               fontSize: 13.sp,
                                            //               color: const Color(
                                            //                 0xFFA2A2A2,
                                            //               ),
                                            //               fontWeight:
                                            //                   FontWeight.w300,
                                            //             ),
                                            //           ),
                                            //         ),
                                            //         icon: const Icon(
                                            //           Icons
                                            //               .keyboard_arrow_down_rounded,
                                            //         ),
                                            //         style: TextStyle(
                                            //           color: kMainColor,
                                            //           fontSize: 15.sp,
                                            //           fontFamily: 'GE SS Two',
                                            //           fontWeight: FontWeight.w300,
                                            //           height: 1.43.h,
                                            //         ),
                                            //         value:
                                            //             selectedBus!.fOperatingNo,
                                            //         items: [
                                            //           DropdownMenuItem<String>(
                                            //             value:
                                            //                 selectedBus!
                                            //                     .fOperatingNo,
                                            //             child: Text(
                                            //               selectedBus!
                                            //                   .fOperatingNo,
                                            //             ),
                                            //           ),
                                            //         ],
                                            //         onChanged: null,
                                            //       ),
                                            //     ),
                                            //     /// عدد الحجاج
                                            //     Expanded(
                                            // child:
                                            InActiveDropdown(
                                              text: selectedBus!.fPilgrimsAco
                                                  .toString(),
                                              value: selectedBus!.fPilgrimsAco,

                                              label: 'عدد الحجاج',
                                            ),
                                          //     ),
                                          //   ],
                                          // ),

                                          /// المسار
                                          DropdownButtonFormField<TrackModel>(
                                            validator: (value) {
                                              if (value == null) {
                                                return 'الرجاء اختيار المسار';
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
                                                'المسار',
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
                                            value: selectedTrack,

                                            items: trackTrip.map((track) {
                                              final trackName =
                                                  track.fTrackName ??
                                                  'لا يوجد مسار';
                                              return DropdownMenuItem<
                                                TrackModel
                                              >(
                                                value: track,
                                                child: Text(trackName),
                                              );
                                            }).toList(),
                                            onChanged: (TrackModel? newValue) {
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
                                            Row(
                                              children: [
                                                Text(
                                                  'اختيار المرشد',
                                                  style: TextStyle(
                                                    color: kMainColor,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              buildRadioOption(
                                                title: 'يوجد',
                                                value: '1',
                                              ),

                                              buildRadioOption(
                                                title: 'لا يوجد',
                                                value: 'null',
                                              ),
                                            ],
                                          ),
                                          if (isGuideSelected == false)
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                'يرجى اختيار حالة المرشد',
                                                style: TextStyle(
                                                  color: Colors.red[900],
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                            ),
                                          if (transType == '1')
                                            DropdownButtonFormField<
                                              AssignmentModel
                                            >(
                                              validator: (value) {
                                                if (value == null) {
                                                  return 'الرجاء اختيار المرشد';
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
                                                      Colors.red,
                                                    ),
                                                label: Text(
                                                  'المرشد',
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
                                                Icons
                                                    .keyboard_arrow_down_rounded,
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
                                                  selectedGuide != null &&
                                                      centerGuides.contains(
                                                        selectedGuide,
                                                      )
                                                  ? selectedGuide
                                                  : null,

                                              items: centerGuides.map((guide) {
                                                final name =
                                                    guide.employee?.fEmpName ??
                                                    'بدون اسم';
                                                return DropdownMenuItem<
                                                  AssignmentModel
                                                >(
                                                  value: guide,
                                                  child: Text(name),
                                                );
                                              }).toList(),
                                              onChanged:
                                                  (AssignmentModel? newValue) {
                                                    setState(() {
                                                      selectedGuide = newValue;
                                                    });
                                                  },
                                            ),

                                          H(h: 120.h),
                                        ],
                                      ),
                                    ),

                                    /// Saved Button
                                    Positioned(
                                      bottom: 0.h,
                                      left: 0,
                                      right: 0,
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 20.h),
                                        child:
                                            /// تحميل الداتا
                                            CustomButton(
                                              text: 'اطلاق',
                                              onTap: () async {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  try {
                                                    await context
                                                        .read<
                                                          GetCurrentLocationCubit
                                                        >()
                                                        .getCurrentLocation();

                                                    final inputs = AddTripModel(
                                                      /// أخر تحديث
                                                      fLastUpdate: DateTime.now()
                                                          .toIso8601String(),

                                                      /// أخر تحديث
                                                      fLastUpdateUser:
                                                          int.parse(
                                                            context
                                                                    .read<
                                                                      HomeCubit
                                                                    >()
                                                                    .userId ??
                                                                '0',
                                                          ),

                                                      /// أخر تحديث
                                                      fLastUpdateSum: 1,

                                                      /// أخر تحديث
                                                      fLastUpdateOper: 1,

                                                      /// الشركة الناقلة
                                                      fCompanyId: companyId,

                                                      /// الموسم
                                                      fSeasonId: int.parse(
                                                        seasonIdController.text,
                                                      ),

                                                      /// حالة الرحلة
                                                      fTripStstus: 1,

                                                      /// المركز
                                                      fCenterNo: int.parse(
                                                        centerNoController.text,
                                                      ),

                                                      /// المرحلة
                                                      fStageNo: int.parse(
                                                        widget.trip.fStageNo,
                                                      ),

                                                      /// رقم الرحلة
                                                      fTripNo: 1, //
                                                      /// تاريخ الرحلة
                                                      fTripDate: formattedDate,

                                                      /// وقت الرحلة
                                                      fTripTime: DateTime.now()
                                                          .toIso8601String(),

                                                      /// رقم الحافلة
                                                      fBusId:
                                                          selectedBus!.fBusId,

                                                      /// عدد الحجاج
                                                      fPilgrimsAco: selectedBus!
                                                          .fPilgrimsAco,

                                                      /// تاريخ الإضافة
                                                      fAdditionDate:
                                                          DateTime.now()
                                                              .toIso8601String(),

                                                      /// المستخدم
                                                      fAdditionUser:
                                                          context
                                                              .read<HomeCubit>()
                                                              .userId ??
                                                          '0',

                                                      /// خط العرض
                                                      fAdditionLatitude: state
                                                          .position
                                                          .latitude
                                                          .toString(),

                                                      /// خط الطول
                                                      fAdditionLongitude: state
                                                          .position
                                                          .longitude
                                                          .toString(),

                                                      /// تاريخ الوصول
                                                      fReceiptDate:
                                                          DateTime.now()
                                                              .toIso8601String(),

                                                      /// المستلم
                                                      fReceiptUser: null,

                                                      /// خط العرض
                                                      fReceiptLatitude: 'null',

                                                      /// خط الطول
                                                      fReceiptLongitude: 'null',
                                                      fApprovalUser: null,
                                                      fApprovalLatitude: 'null',
                                                      fApprovalLongitude:
                                                          'null',
                                                      fEmpNo:
                                                          transType == 'null'
                                                          ? null
                                                          : selectedGuide
                                                                ?.fEmpNo,
                                                      fApprovalDate:
                                                          DateTime.now()
                                                              .toIso8601String(),
                                                      fTrackNo:
                                                          selectedTrack
                                                              ?.fTrackNo ??
                                                          0,
                                                    );
                                                    await context
                                                        .read<BusTravelCubit>()
                                                        .addTripByStage(inputs);

                                                    if (context
                                                        .read<BusTravelCubit>()
                                                        .state
                                                        .isAddingTripByStageSuccess) {
                                                      await context
                                                          .read<
                                                            BusTravelCubit
                                                          >()
                                                          .getTripsByStage(
                                                            centerNoController
                                                                .text,
                                                            widget
                                                                .trip
                                                                .fStageNo,
                                                          );
                                                      if (context.mounted) {
                                                        showSuccessDialog(
                                                          context,
                                                        );
                                                        Future.delayed(
                                                          const Duration(
                                                            seconds: 2,
                                                          ),
                                                          () {
                                                            if (context
                                                                .mounted) {
                                                              Navigator.pop(
                                                                context,
                                                              );
                                                            }
                                                          },
                                                        );
                                                      }
                                                    } else {
                                                      if (context.mounted) {
                                                        showErrorDialog(
                                                          isBack: true,
                                                          context,
                                                          message:
                                                              'هناك خطأ في اطلاق الرحلة',
                                                          icon: Icons
                                                              .error_outline_rounded,
                                                          color: kErrorColor,
                                                        );
                                                      }
                                                    }
                                                  } catch (e) {
                                                    if (context.mounted) {
                                                      showErrorDialog(
                                                        isBack: true,
                                                        context,
                                                        message:
                                                            'هناك خطأ في اطلاق الرحلة',
                                                        icon: Icons
                                                            .error_outline_rounded,
                                                        color: kErrorColor,
                                                      );
                                                    }
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
                          )
                        : const LoadingLocation();
                  },
                );
              },
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
            color: isGuideSelected == false
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
              groupValue: transType, // المفتاح
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

class ArabicToLatinDigitsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final converted = convertArabicToLatin(newValue.text);
    return newValue.copyWith(
      text: converted,
      selection: updateCursorPosition(converted, newValue),
    );
  }

  // تحديث مؤشر الكتابة بعد التحويل
  TextSelection updateCursorPosition(String text, TextEditingValue newValue) {
    return TextSelection.collapsed(offset: text.length);
  }

  static String convertArabicToLatin(String input) {
    const arabicToLatinNumberMap = {
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9',
      '٠': '0',
    };
    var result = input;
    arabicToLatinNumberMap.forEach((arabic, latin) {
      result = result.replaceAll(arabic, latin);
    });
    return result;
  }
}
