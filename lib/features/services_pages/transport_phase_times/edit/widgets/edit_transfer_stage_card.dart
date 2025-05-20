import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/text_fields/custom_number_textfield.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_stage_get_stages_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_stage_get_transport_by_criteria_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditTransferStageCard extends StatelessWidget {
  const EditTransferStageCard({
    required this.stageName,
    required this.stageData,
    required this.index,
    required this.tripsControllers,
    required this.pilgrimsControllers,
    required this.busesControllers,
    super.key,
  });
  final TransferStageGetStageModel stageName;
  final TransferStageGetTransportByCriteriaModel stageData;
  final int index;
  final List<TextEditingController> tripsControllers;
  final List<TextEditingController> pilgrimsControllers;
  final List<TextEditingController> busesControllers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// اسم المرحلة
              SizedBox(
                width: 100.w,
                child: Text(
                  stageName.fStageName,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: kMainColor,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.43.h,
                  ),
                ),
              ),

              /// خانة عدد الحجاج
              SizedBox(
                width: 80.w,
                height: 42.h,
                child: CustomNumberTextformfield(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    pilgrimsControllers[index].text = value;
                  },
                  controller: pilgrimsControllers[index],
                  fontSize: 14,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 0,
                  ),
                  text: 'العدد',
                ),
              ),

              /// خانة عدد الحافلات
              SizedBox(
                width: 80.w,
                height: 42.h,
                child: CustomNumberTextformfield(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    busesControllers[index].text = value;
                  },
                  controller: busesControllers[index],
                  fontSize: 14,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 0,
                  ),
                  text: 'العدد',
                ),
              ),

              /// خانة عدد الردود
              SizedBox(
                width: 80.w,
                height: 42.h,
                child: CustomNumberTextformfield(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    tripsControllers[index].text = value;
                  },
                  controller: tripsControllers[index],
                  fontSize: 14,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 0,
                  ),
                  text: 'العدد',
                ),
              ),
            ],
          ),
        ),
        const Divider(color: kMainColorLightColor),
      ],
    );
  }
}
