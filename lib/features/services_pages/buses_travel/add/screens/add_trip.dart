import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_number_textfield.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_text_field_with_label.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/add_buses_travel_trip_by_stage_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/bus_travel_trip_model_by_stage_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_trip_model.dart';
import 'package:alrefadah/presentation/app/shared_cubit/get_current_location_cubit/get_current_location_cubit.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_dialog/show_success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTrip extends StatefulWidget {
  const AddTrip({required this.tripsByStage, required this.trip, super.key});
  final BusesTravelGetTripModel trip;
  final List<TripModel> tripsByStage;
  @override
  State<AddTrip> createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  @override
  void initState() {
    super.initState();
    initControllers();
  }

  void initControllers() {
    stageNameController.text = context.read<BusTravelCubit>().getStageName(
      widget.trip.fStageNo,
    );
    centerNoController.text = widget.trip.fCenterNo;
    seasonIdController.text = widget.trip.fSeasonId;
    tripStatusController.text = 'الإنطلاق';
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final pilgrimsAcoController = TextEditingController();
  final tripNoController = TextEditingController();
  final centerNoController = TextEditingController();
  final seasonIdController = TextEditingController();
  final tripStatusController = TextEditingController();
  final stageNameController = TextEditingController();
  final timeController = TextEditingController();
  final dateController = TextEditingController();
  final busNoController = TextEditingController();

  Future<void> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final formattedTime = TimeOfDay(
        hour: picked.hour,
        minute: picked.minute,
      ).format(context);
      time = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        picked.hour,
        picked.minute,
      );
      timeController.text = formattedTime;
    }
  }

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
        dateController.text = '$year$month$day';
      });
    }
  }

  String? year;
  String? month;
  String? day;
  DateTime? time;
  @override
  void dispose() {
    tripNoController.dispose();
    pilgrimsAcoController.dispose();
    dateController.dispose();
    centerNoController.dispose();
    seasonIdController.dispose();
    tripStatusController.dispose();
    stageNameController.dispose();
    timeController.dispose();
    busNoController.dispose();

    super.dispose();
  }

  String? selectedUser;
  String? selectedCompany;
  String? selectedBus;
  String? selectedCenter;
  String? selectedStage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'إضافة رحلة',
          style: TextStyle(
            color: kMainColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            height: 1.20.h,
          ),
        ),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<GetCurrentLocationCubit, GetCurrentLocationState>(
        builder: (context, state) {
          final seenBuses = <String>{};
          final seenCompanies = <String>{};

          final busItems =
              widget.tripsByStage
                  .where((bus) {
                    return seenBuses.add(bus.fBusId);
                  })
                  .map((bus) {
                    return DropdownMenuItem<String>(
                      value: bus.fBusId,
                      child: Text(bus.fBusId),
                    );
                  })
                  .toList();

          final companyItems =
              widget.tripsByStage
                  .where((company) {
                    return seenCompanies.add(company.company.fCompanyName);
                  })
                  .map((company) {
                    return DropdownMenuItem<String>(
                      value: company.company.fCompanyName,
                      child: Text(company.company.fCompanyName),
                    );
                  })
                  .toList();

          return state is GetCurrentLocationLoading
              ? const AppIndicator()
              : state is GetCurrentLocationSuccess
              ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: AutofillGroup(
                  onDisposeAction: AutofillContextAction.cancel,
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        spacing: 16.h,
                        children: [
                          Row(
                            spacing: 8.w,
                            children: [
                              Expanded(
                                child: CustomTextFieldWithLabel(
                                  controller: seasonIdController,
                                  text: 'موسم',
                                  readOnly: true,
                                  enabled: false,
                                ),
                              ),
                              Expanded(
                                child: CustomTextFieldWithLabel(
                                  controller: centerNoController,
                                  text: 'مركز',
                                  readOnly: true,
                                  enabled: false,
                                ),
                              ),
                            ],
                          ),

                          CustomTextFieldWithLabel(
                            readOnly: true,
                            controller: stageNameController,
                            text: 'المرحلة',
                            enabled: false,
                          ),
                          DropdownButtonFormField<String>(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء اختيار الشركة الناقلة';
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
                                'الشركة الناقلة',
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
                            value: selectedCompany,

                            items: companyItems,
                            onChanged: (value) {
                              setState(() {
                                selectedCompany = value;
                              });
                            },
                          ),

                          Row(
                            spacing: 8.w,
                            children: [
                              Expanded(
                                child: CustomNumberTextformfield(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'الرجاء إدخال رقم الرحلة';
                                    }
                                    return null;
                                  },
                                  labelText: 'رقم الرحلة',
                                  controller: tripNoController,
                                ),
                              ),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'الرجاء إدخال رقم الحافلة';
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
                                      'رقم الحافلة',
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
                                  value: selectedBus,

                                  items: busItems,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedBus = value;
                                      busNoController.text = selectedBus!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),

                          Row(
                            spacing: 8.w,
                            children: [
                              Expanded(
                                child: CustomTextFieldWithLabel(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'الرجاء إدخال تاريخ الرحلة';
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  controller: dateController,
                                  text: 'تاريخ الرحلة',
                                  passwordIcon: const Icon(
                                    Icons.calendar_today,
                                    color: kMainColor,
                                  ),
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                ),
                              ),
                              Expanded(
                                child: CustomTextFieldWithLabel(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'الرجاء إدخال وقت الرحلة';
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  controller: timeController,
                                  text: 'وقت الرحلة',
                                  passwordIcon: const Icon(
                                    Icons.access_time,
                                    color: kMainColor,
                                  ),
                                  onTap: () {
                                    _selectTime(context);
                                  },
                                ),
                              ),
                            ],
                          ),

                          CustomNumberTextformfield(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء إدخال عدد الحجاج';
                              }
                              return null;
                            },
                            labelText: 'عدد الحجاج',
                            controller: pilgrimsAcoController,
                          ),

                          CustomTextFieldWithLabel(
                            enabled: false,
                            text: 'حالة الرحلة',
                            controller: tripStatusController,
                          ),
                          const H(h: 40),
                          if (context
                              .read<BusTravelCubit>()
                              .state
                              .isLoadingTripsByStage)
                            const AppIndicator()
                          else
                            CustomButton(
                              text: 'حفظ',
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  try {
                                    await context
                                        .read<GetCurrentLocationCubit>()
                                        .getCurrentLocation();

                                    final inputs = AddTripModel(
                                      /// أخر تحديث
                                      fLastUpdate: DateTime.now(),

                                      /// أخر تحديث
                                      fLastUpdateUser: 1,

                                      /// أخر تحديث
                                      fLastUpdateSum: 0,

                                      /// أخر تحديث
                                      fLastUpdateOper: 0,

                                      /// الشركة الناقلة
                                      fCompanyId: companyId, //
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
                                      fStageNo: int.parse(widget.trip.fStageNo),

                                      /// رقم الرحلة
                                      fTripNo: int.parse(
                                        tripNoController.text,
                                      ), //
                                      /// تاريخ الرحلة
                                      fTripDate: dateController.text,

                                      /// وقت الرحلة
                                      fTripTime: time!.toIso8601String(),

                                      /// رقم الحافلة
                                      fBusId: int.parse(
                                        busNoController.text,
                                      ), // ثابت
                                      /// عدد الحجاج
                                      fPilgrimsAco: int.parse(
                                        pilgrimsAcoController.text,
                                      ),

                                      /// تاريخ الإضافة
                                      fAdditionDate: DateTime.now(),

                                      /// المستخدم
                                      fAdditionUser: 1, // الشخص المسجل
                                      /// خط العرض
                                      fAdditionLatitude:
                                          state.position.latitude.toString(),

                                      /// خط الطول
                                      fAdditionLongitude:
                                          state.position.longitude.toString(),

                                      /// تاريخ الوصول
                                      fReceiptDate: DateTime.parse(
                                        dateController.text,
                                      ),

                                      ///

                                      /// المستلم
                                      fReceiptUser: 0,

                                      ///

                                      /// خط العرض
                                      fReceiptLatitude: '0',

                                      /// خط الطول
                                      fReceiptLongitude: '0',
                                    );
                                    await context
                                        .read<BusTravelCubit>()
                                        .addTripByStage(inputs);

                                    if (context
                                        .read<BusTravelCubit>()
                                        .state
                                        .isAddingTripByStageSuccess) {
                                      await context
                                          .read<BusTravelCubit>()
                                          .getTripsByStage(
                                            centerNoController.text,
                                            widget.trip.fStageNo,
                                          );
                                      if (context.mounted) {
                                        showSuccessDialog(context);
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
                                          message: 'رقم الرحلة مستخدم من قبل',
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
                                        message: 'هناك خطأ في إضافة الرحلة',
                                        icon: Icons.error_outline_rounded,
                                        color: kErrorColor,
                                      );
                                    }
                                  }
                                }
                              },
                            ),
                          H(h: 20.h),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              : Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_off_rounded,
                      size: 80.sp,
                      color: kMainColor,
                    ),
                    const H(h: 20),
                    Text(
                      'يجب عليك تحميل الموقع لإضافة الرحلة',
                      style: TextStyle(fontSize: 16.sp, color: kMainColor),
                    ),
                    const H(h: 40),
                    CustomButton(
                      text: 'تحميل الموقع',
                      onTap: () {
                        context
                            .read<GetCurrentLocationCubit>()
                            .getCurrentLocation();
                      },
                    ),
                  ],
                ),
              );
        },
      ),
    );
  }
}
