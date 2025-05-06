// import 'package:easy_localization/easy_localization.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_text_field_with_label.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/bus_travel_trip_model_by_stage_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ShowBusTravelTrip extends StatefulWidget {
  const ShowBusTravelTrip({required this.trip, super.key});

  final TripModel trip;

  @override
  State<ShowBusTravelTrip> createState() => _ShowBusTravelTripState();
}

class _ShowBusTravelTripState extends State<ShowBusTravelTrip> {
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
    tripStatusController.text = 'لدى الإنطلاق';
    pilgrimsAcoController.text = widget.trip.fPilgrimsAco;
    tripNoController.text = widget.trip.fTripNo;
    tripTimeController.text = DateFormat(
      'hh:mm a', // صيغة 12 ساعة مع AM/PM
    ).format(DateTime.parse(widget.trip.fTripTime));

    dateController.text = widget.trip.fTripDate.padLeft(8, '0');
    busNoController.text = widget.trip.fBusId;
    companyNoController.text = widget.trip.company.fCompanyName;
  }

  final pilgrimsAcoController = TextEditingController();
  final tripNoController = TextEditingController();
  final centerNoController = TextEditingController();
  final seasonIdController = TextEditingController();
  final tripTimeController = TextEditingController();
  final tripStatusController = TextEditingController();
  final stageNameController = TextEditingController();
  final dateController = TextEditingController();
  final busNoController = TextEditingController();
  final companyNoController = TextEditingController();
  @override
  void dispose() {
    tripNoController.dispose();
    pilgrimsAcoController.dispose();
    dateController.dispose();
    centerNoController.dispose();
    seasonIdController.dispose();
    tripTimeController.dispose();
    tripStatusController.dispose();
    stageNameController.dispose();
    busNoController.dispose();
    companyNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'رحلة: ${widget.trip.fTripNo}',
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
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
            CustomTextFieldWithLabel(
              readOnly: true,
              controller: companyNoController,

              text: 'الشركة الناقلة',
              enabled: false,
            ),

            Row(
              spacing: 12.w,
              children: [
                Expanded(
                  child: CustomTextFieldWithLabel(
                    readOnly: true,
                    controller: tripNoController,
                    text: 'رقم الرحلة',
                    enabled: false,
                  ),
                ),
                Expanded(
                  child: CustomTextFieldWithLabel(
                    readOnly: true,
                    text: 'رقم الحافلة',
                    controller: busNoController,
                    enabled: false,
                  ),
                ),
              ],
            ),

            Row(
              spacing: 12.w,
              children: [
                Expanded(
                  child: CustomTextFieldWithLabel(
                    enabled: false,
                    readOnly: true,
                    controller: dateController,
                    text: 'تاريخ الرحلة',
                    passwordIcon: const Icon(Icons.calendar_today),
                  ),
                ),
                Expanded(
                  child: CustomTextFieldWithLabel(
                    enabled: false,
                    readOnly: true,
                    controller: tripTimeController,
                    text: 'وقت الرحلة',
                    passwordIcon: const Icon(Icons.access_time),
                  ),
                ),
              ],
            ),
            CustomTextFieldWithLabel(
              enabled: false,
              readOnly: true,
              text: 'عدد الحجاج',
              controller: pilgrimsAcoController,
            ),

            CustomTextFieldWithLabel(
              enabled: false,
              text: 'حالة الرحلة',
              controller: tripStatusController,
            ),
            const H(h: 40),
          ],
        ),
      ),
    );
  }
}
