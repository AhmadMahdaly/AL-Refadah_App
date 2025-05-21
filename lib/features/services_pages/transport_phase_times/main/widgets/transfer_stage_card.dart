import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_stage_get_centers_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/widgets/transfer_stage_popup_menu_button.dart';

class TransferStageCard extends StatelessWidget {
  const TransferStageCard({required this.center, super.key});
  final TransferStageGetCenterModel center;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              centerName(),
              centerNumber(),
              const Spacer(),
              popupMenuButton(context),
            ],
          ),
        ),
        const Divider(color: kMainColorLightColor),
      ],
    );
  }

  /// اسم المركز
  Widget centerName() {
    return SizedBox(
      width: 150.w,
      child: Text(
        center.fCenterName,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: kDartTextColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// رقم المركز
  Widget centerNumber() {
    return Text(
      '${center.fCenterNo}',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: kDartTextColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  /// اجراءات حصص النقل
  Widget popupMenuButton(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: ShapeDecoration(
        color: kMainExtrimeLightColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
      ),
      child: transferStagePopupMenuButton(context, center),
    );
  }
}
