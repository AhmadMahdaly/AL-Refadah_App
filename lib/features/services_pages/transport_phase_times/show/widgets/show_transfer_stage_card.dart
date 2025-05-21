import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_stage_get_stages_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_stage_get_transport_by_criteria_model.dart';

class ShowTransferStageCard extends StatelessWidget {
  const ShowTransferStageCard({
    required this.stageName,
    required this.stageData,
    super.key,
  });
  final TransferStageGetStageModel stageName;
  final TransferStageGetTransportByCriteriaModel stageData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// اسم المرحلة
              SizedBox(
                width: 100.w,
                child: Text(
                  stageName.fStageName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kDartTextColor,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              /// عدد الحجاج
              SizedBox(
                width: 50.w,
                child: Text(
                  stageData.fStageNo == stageName.fStageNo
                      ? stageData.fPilgrimsAco.toString()
                      : '0',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: kDartTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              /// عدد الحافلات
              SizedBox(
                width: 50.w,
                child: Text(
                  stageData.fStageNo == stageName.fStageNo
                      ? stageData.fBusesAco.toString()
                      : '0',

                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kDartTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              /// عدد الردود
              SizedBox(
                width: 50.w,
                child: Text(
                  stageData.fStageNo == stageName.fStageNo
                      ? stageData.fTripsAco.toString()
                      : '0',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kDartTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
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
