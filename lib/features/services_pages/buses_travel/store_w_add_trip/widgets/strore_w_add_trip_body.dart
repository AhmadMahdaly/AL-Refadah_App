import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_number_textfield.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/core/widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/core/widgets/custom_dialog/show_success_dialog.dart';
import 'package:alrefadah/features/home_page/cubit/home_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/add/cubit/add_bus_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/add/cubit/add_bus_state.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_states.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/add_bus/cubit/add_bus_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_state.dart';
import 'package:alrefadah/features/services_pages/buses_travel/store_w_add_trip/models/store_w_add_trip_model.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_cubit.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_states.dart';
import 'package:alrefadah/presentation/app/shared_cubit/get_current_location_cubit/get_current_location_cubit.dart';
import 'package:alrefadah/presentation/app/shared_widgets/loading_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StroreWAddTripBody extends StatefulWidget {
  const StroreWAddTripBody({super.key});

  @override
  State<StroreWAddTripBody> createState() => _StroreWAddTripBodyState();
}

class _StroreWAddTripBodyState extends State<StroreWAddTripBody> {
  @override
  void initState() {
    super.initState();

    init();
  }

  Future init() async {
    await Future.wait([
      context.read<BusesCubit>().getCenters(),
      context.read<BusesCubit>().getStages(),
      context.read<BusTravelCubit>().getTrackTrip(),
      context.read<AddBusTripCubit>().loadTransports(),
    ]);
  }

  @override
  void dispose() {
    oprationNoController.dispose();
    busNoController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final oprationNoController = TextEditingController();
  final busNoController = TextEditingController();
  int? selectedGuide;
  int? selectedTransport;
  String transType = '0';
  bool? isGuideSelected;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusTravelCubit, BusesTravelState>(
      builder: (context, state) {
        final trip = context.read<BusTravelCubit>();
        return BlocBuilder<BusesCubit, BusesState>(
          builder: (context, state) {
            final bus = context.read<BusesCubit>();
            return BlocBuilder<
              GetCurrentLocationCubit,
              GetCurrentLocationState
            >(
              builder: (context, state) {
                return bus.state.centers.isEmpty ||
                        trip.state.isAddingTripByStage ||
                        bus.state.stages.isEmpty ||
                        state is GetCurrentLocationLoading
                    ? const AppIndicator()
                    : state is GetCurrentLocationSuccess
                    ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            spacing: 12.h,

                            children: [
                              12.verticalSpace,

                              /// Centers dropdown
                              DropdownButtonFormField<int>(
                                validator: (value) {
                                  if (value == null) {
                                    return 'الرجاء اختيار المركز';
                                  }
                                  return null;
                                },
                                borderRadius: BorderRadius.circular(10.r),
                                isExpanded: true,
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
                                    'المركز',
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
                                    bus.state.centers.map((center) {
                                      return DropdownMenuItem<int>(
                                        value: center.fCenterNo,
                                        child: Text(center.fCenterName),
                                      );
                                    }).toList(),
                                onChanged: (centerNo) async {
                                  if (centerNo != null) {
                                    setState(() {
                                      trip.state.selectedCenter = centerNo;
                                    });

                                    await context
                                        .read<GuidesCubit>()
                                        .storeWGetGuide(
                                          context
                                              .read<HomeCubit>()
                                              .selectedSeason
                                              .toString(),
                                          centerNo.toString(),
                                        );
                                  }
                                },
                                value: trip.state.selectedCenter,
                              ),

                              /// stages dropdown
                              DropdownButtonFormField<int>(
                                validator: (value) {
                                  if (value == null) {
                                    return 'الرجاء اختيار المرحلة';
                                  }
                                  return null;
                                },
                                borderRadius: BorderRadius.circular(10.r),
                                isExpanded: true,
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
                                    'المرحلة',
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
                                    bus.state.stages.map((stage) {
                                      return DropdownMenuItem<int>(
                                        value: stage.fStageNo,
                                        child: Text(stage.fStageName),
                                      );
                                    }).toList(),
                                onChanged: (stage) {
                                  if (stage != null) {
                                    trip.state.selectedStage = stage;
                                  }
                                },
                                value: trip.state.selectedStage,
                              ),

                              /// المسار
                              DropdownButtonFormField<int>(
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
                                  focusedErrorBorder: dropdownBorderRadius(
                                    kErrorColor,
                                  ),
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
                                value: trip.state.selectedTrack,

                                items:
                                    trip.state.track.map((track) {
                                      final trackName =
                                          track.fTrackName ?? 'لا يوجد مسار';
                                      return DropdownMenuItem<int>(
                                        value: track.fTrackNo,
                                        child: Text(trackName),
                                      );
                                    }).toList(),
                                onChanged: (int? newValue) {
                                  trip.state.selectedTrack = newValue;
                                },
                              ),

                              /// opration No
                              CustomNumberTextformfield(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'الرجاء إدخال الرقم التشغيلي';
                                  }
                                  return null;
                                },
                                maxLength: 14,
                                controller: oprationNoController,

                                labelText: 'الرقم التشغيلي',
                              ),

                              /// Bus No
                              CustomNumberTextformfield(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'الرجاء إدخال رقم الحافلة';
                                  }
                                  return null;
                                },
                                maxLength: 10,
                                controller: busNoController,

                                labelText: 'رقم الحافلة',
                              ),
                              BlocBuilder<AddBusCubit, AddBusState>(
                                builder: (context, state) {
                                  final state =
                                      context.watch<AddBusCubit>().state;
                                  final transports = state.transports;
                                  return DropdownButtonFormField<int>(
                                    borderRadius: BorderRadius.circular(10.r),
                                    isExpanded: true,
                                    dropdownColor: kScaffoldBackgroundColor,
                                    validator: (value) {
                                      if (value == null) {
                                        return 'الرجاء اختر الشركة الناقلة';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      label: Text(
                                        'الشركة الناقلة',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: const Color(0xFFA2A2A2),
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
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
                                        transports.map((trans) {
                                          return DropdownMenuItem<int>(
                                            value: trans.fTransportNo,
                                            child: Text(trans.fTransportName),
                                          );
                                        }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTransport = value;
                                      });
                                    },
                                    value: selectedTransport,
                                  );
                                },
                              ),
                              BlocBuilder<GuidesCubit, GuidesState>(
                                builder: (context, state) {
                                  final guide = context.read<GuidesCubit>();

                                  return Column(
                                    spacing: 12.h,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (trip.state.selectedStage == 1 ||
                                          trip.state.selectedStage == 2 ||
                                          trip.state.selectedStage == 6 ||
                                          trip.state.selectedStage == 7)
                                        Text(
                                          'اختيار المرشد',
                                          style: TextStyle(
                                            color: kMainColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w300,
                                          ),
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
                                        state.isLoadingGetByCriteria
                                            ? SizedBox(
                                              height: 64.h,
                                              child: AppIndicator(size: 16.sp),
                                            )
                                            : DropdownButtonFormField<int>(
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
                                                  guide
                                                          .state
                                                          .guidesByCriteria
                                                          .isEmpty
                                                      ? 'لا يوجد مرشدين في هذا المركز'
                                                      : 'المرشد',
                                                  style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: const Color(
                                                      0xFFA2A2A2,
                                                    ),
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ),
                                              icon: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                color:
                                                    guide
                                                            .state
                                                            .guidesByCriteria
                                                            .isEmpty
                                                        ? const Color(
                                                          0xFFA2A2A2,
                                                        )
                                                        : kMainColor,
                                              ),
                                              style: TextStyle(
                                                color: kMainColor,
                                                fontSize: 15.sp,
                                                fontFamily: 'GE SS Two',
                                                fontWeight: FontWeight.w300,
                                                height: 1.25.h,
                                              ),
                                              value: selectedGuide,
                                              items:
                                                  guide.state.guidesByCriteria
                                                      .map((guide) {
                                                        final name =
                                                            guide
                                                                .employee
                                                                ?.fEmpName ??
                                                            'بدون اسم';
                                                        return DropdownMenuItem<
                                                          int
                                                        >(
                                                          value: guide.fEmpNo,
                                                          child: Text(name),
                                                        );
                                                      })
                                                      .toList(),
                                              onChanged: (int? newValue) {
                                                selectedGuide = newValue;
                                              },
                                            ),
                                    ],
                                  );
                                },
                              ),

                              40.verticalSpace,

                              /// تحميل الداتا
                              CustomButton(
                                text: 'اطلاق',
                                onTap: () async {
                                  if (formKey.currentState!.validate()) {
                                    try {
                                      final inputs = StoreWAddTripModel(
                                        bus: StoreWAddBus(
                                          fTransportNo: selectedTransport ?? 0,
                                          fBusNo: busNoController.text,
                                          fCenterNo: trip.state.selectedCenter!,
                                          fSeasonId:
                                              context
                                                  .read<HomeCubit>()
                                                  .selectedSeason!,
                                          fBusStatus: 1,
                                        ),
                                        operating: StoreWAddOperating(
                                          fOperatingNo:
                                              oprationNoController.text,
                                        ),
                                        trip: StoreWAddTrip(
                                          fBusId: 0,
                                          fSeasonId:
                                              context
                                                  .read<HomeCubit>()
                                                  .selectedSeason!,
                                          fStageNo: trip.state.selectedStage!,
                                          fEmpNo:
                                              transType == '1'
                                                  ? selectedGuide
                                                  : null,
                                          fAdditionLatitude:
                                              state.position.latitude
                                                  .toString(),
                                          fAdditionLongitude:
                                              state.position.longitude
                                                  .toString(),
                                          fAdditionUser: int.parse(
                                            context.read<HomeCubit>().userId ??
                                                '0',
                                          ),
                                          fTrackNo: trip.state.selectedTrack!,
                                        ),
                                      );

                                      await context
                                          .read<BusTravelCubit>()
                                          .storeWAddTrip(inputs);

                                      if (context
                                          .read<BusTravelCubit>()
                                          .state
                                          .isAddingTripByStageSuccess) {
                                        if (context.mounted) {
                                          showSuccessDialog(
                                            context,
                                            seconds: 1,
                                          );
                                          oprationNoController.clear();
                                          busNoController.clear();
                                          selectedGuide = null;
                                          selectedTransport = null;
                                          transType = '0';
                                        }
                                      } else {
                                        if (context.mounted) {
                                          showErrorDialog(
                                            isBack: true,
                                            context,
                                            message: 'هناك خطأ في اطلاق الرحلة',
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
                                          message:
                                              'هناك خطأ عام في اطلاق الرحلة',
                                          icon: Icons.error_outline_rounded,
                                          color: kErrorColor,
                                        );
                                      }
                                    }
                                  }
                                },
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
