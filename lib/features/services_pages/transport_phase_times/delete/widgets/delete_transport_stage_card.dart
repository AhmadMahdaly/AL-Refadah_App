import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/delete/widgets/delete_transport_stage_popup.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_stage_get_transport_by_criteria_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteTransferStageCard extends StatelessWidget {
  const DeleteTransferStageCard({required this.stageData, super.key});
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
              /// المرحلة
              SizedBox(
                width: 100.w,
                child: Text(
                  context.read<BusTravelCubit>().getStageName(
                    stageData.fStageNo.toString(),
                  ),
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
                width: 60.w,
                child: Text(
                  stageData.fPilgrimsAco.toString(),
                  textAlign: TextAlign.center,
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
                  stageData.fBusesAco.toString(),
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
                  stageData.fTripsAco.toString(),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: kDartTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              /// Delete Opration
              deleteTransferStagePopupMenuButton(context, stageData),
            ],
          ),
        ),
        const Divider(color: kMainColorLightColor),
      ],
    );
  }
}
