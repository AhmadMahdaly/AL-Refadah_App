import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/custom_button.dart';
import 'package:alrefadah/core/utils/components/custom_loading_indicator.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_number_textfield.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_text_field_with_label.dart';
import 'package:alrefadah/core/utils/components/text_fields/textfield_border_radius.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/add_buses_travel_trip_by_stage_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/bus_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/bus_travel_trip_model_by_stage_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_state.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_dialog/show_success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class EditTripByStage extends StatefulWidget {
  const EditTripByStage({
    required this.trip,
    required this.tripsByStage,
    super.key,
  });
  final TripModel trip;
  final List<TripModel> tripsByStage;
  @override
  State<EditTripByStage> createState() => _EditTripByStageState();
}

class _EditTripByStageState extends State<EditTripByStage> {
  @override
  void initState() {
    super.initState();
    initData();
    initControllers();
  }

  List<TripModel> trips = [];
  Future<void> initData() async {
    await context.read<BusTravelCubit>().getTripsByStage(
      widget.trip.fCenterNo,
      widget.trip.fStageNo,
    );

    trips = context.read<BusTravelCubit>().state.tripsByStage;

    allBuses =
        trips.map((trip) {
          return BusModel(
            fBusId: int.tryParse(widget.trip.fBusId) ?? 0,
            fCompanyName: widget.trip.company.fCompanyName,
            fCompanyId: int.tryParse(widget.trip.company.fCompanyId) ?? 0,
          );
        }).toList();

    companyNames = allBuses.map((bus) => bus.fCompanyName).toSet().toList();
    time = DateFormat(
      "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
    ).format(DateTime.parse(widget.trip.fTripTime));
  }

  List<BusModel> allBuses = [];
  List<String> companyNames = [];
  List<BusModel> filteredBuses = [];
  String? selectedCompany;
  int? selectedBusId;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final pilgrimsAcoController = TextEditingController();
  final tripNoController = TextEditingController();
  final centerNoController = TextEditingController();
  final seasonIdController = TextEditingController();
  final tripStatusController = TextEditingController();
  final stageNameController = TextEditingController();
  final timeController = TextEditingController();
  final dateController = TextEditingController();
  final companyIdController = TextEditingController();
  final stageNoController = TextEditingController();
  final busNoController = TextEditingController();

  void initControllers() {
    busNoController.text = widget.trip.fBusId;
    selectedCompany = widget.trip.company.fCompanyName;
    companyIdController.text = widget.trip.company.fCompanyId;
    stageNoController.text = widget.trip.fStageNo;
    stageNameController.text = context.read<BusTravelCubit>().getStageName(
      widget.trip.fStageNo,
    );
    centerNoController.text = widget.trip.fCenterNo;
    seasonIdController.text = widget.trip.fSeasonId;
    tripNoController.text = widget.trip.fTripNo;

    dateController.text = widget.trip.fTripDate;
    pilgrimsAcoController.text = widget.trip.fPilgrimsAco;
    timeController.text = widget.trip.fTripTime;
    tripStatusController.text = 'انطلاق';
    // عرض للمستخدم
    final displayFormat = DateFormat('hh:mm a'); // 08:30 AM
    timeController.text = displayFormat.format(
      DateTime.parse(widget.trip.fTripTime),
    );
  }

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
      time =
          DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            picked.hour,
            picked.minute,
          ).toIso8601String();
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
  String? time;

  @override
  void dispose() {
    pilgrimsAcoController.dispose();
    tripNoController.dispose();
    centerNoController.dispose();
    seasonIdController.dispose();
    tripStatusController.dispose();
    stageNameController.dispose();
    timeController.dispose();
    dateController.dispose();
    companyIdController.dispose();
    stageNoController.dispose();
    busNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusTravelCubit, BusesTravelState>(
      builder: (context, state) {
        final seenCompanies = <String>{};

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

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'تعديل',
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
          body:
              state.isEditingTripByStage
                  ? const AppIndicator()
                  : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: AutofillGroup(
                      onDisposeAction: AutofillContextAction.cancel,
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            spacing: 16.h,
                            children: [
                              const H(h: 0),
                              Row(
                                spacing: 12.w,
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
                                    companyIdController.text = value!;
                                  });
                                },
                              ),

                              Row(
                                spacing: 12.w,
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
                                    child: CustomNumberTextformfield(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'الرجاء إدخال رقم الحافلة';
                                        }
                                        return null;
                                      },
                                      labelText: 'رقم الحافلة',
                                      controller: busNoController,
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                spacing: 8.w,
                                children: [
                                  Expanded(
                                    child: CustomTextFieldWithLabel(
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
                                labelText: 'عدد الحجاج',
                                controller: pilgrimsAcoController,
                              ),

                              CustomTextFieldWithLabel(
                                enabled: false,
                                text: 'حالة الرحلة',
                                controller: tripStatusController,
                              ),
                              const H(h: 40),
                              if (state.isLoadingTripsByStage)
                                const AppIndicator()
                              else
                                Padding(
                                  padding: EdgeInsets.all(16.sp),
                                  child: CustomButton(
                                    text: 'حفظ',
                                    onTap: () async {
                                      try {
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
                                          fCompanyId: int.parse(
                                            companyIdController.text,
                                          ),

                                          /// الموسم
                                          fSeasonId: int.parse(
                                            seasonIdController.text,
                                          ),

                                          /// حالة الرحلة
                                          fTripStstus: 1, // دروب داون بالحالات
                                          /// المركز
                                          fCenterNo: int.parse(
                                            centerNoController.text,
                                          ),

                                          /// المرحلة
                                          fStageNo: int.parse(
                                            stageNoController.text,
                                          ),

                                          /// رقم الرحلة
                                          fTripNo: int.parse(
                                            tripNoController.text,
                                          ),

                                          /// تاريخ الرحلة
                                          fTripDate: dateController.text,

                                          /// وقت الرحلة
                                          fTripTime: time!,

                                          /// رقم الحافلة
                                          fBusId: int.parse(
                                            busNoController.text,
                                          ),

                                          /// عدد الحجاج
                                          fPilgrimsAco: int.parse(
                                            pilgrimsAcoController.text,
                                          ),

                                          /// تاريخ الإضافة
                                          fAdditionDate:
                                              widget.trip.fAdditionDate,

                                          /// المستخدم
                                          fAdditionUser: 1,

                                          /// خط العرض
                                          fAdditionLatitude:
                                              widget.trip.fAdditionLatitude,

                                          /// خط الطول
                                          fAdditionLongitude:
                                              widget.trip.fAdditionLongitude,

                                          /// تاريخ الوصول
                                          fReceiptDate: DateTime.now(),

                                          /// المستلم
                                          fReceiptUser: 0,

                                          /// خط العرض
                                          fReceiptLatitude:
                                              widget.trip.fReceiptLatitude,

                                          /// خط الطول
                                          fReceiptLongitude:
                                              widget.trip.fReceiptLongitude,
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
                                                centerNoController.text,
                                                widget.trip.fStageNo,
                                              );
                                          if (context.mounted) {
                                            showSuccessDialog(
                                              context,
                                              title: 'تم تعديل الرحلة بنجاح',
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
                                            icon: Icons.error_outline_rounded,
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
                                    },
                                  ),
                                ),
                              const H(h: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
        );
      },
    );
  }
}
