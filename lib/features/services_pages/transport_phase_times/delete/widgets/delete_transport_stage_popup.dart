import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/delete/widgets/delete_transport_stage_method.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_stage_get_transport_by_criteria_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

PopupMenuButton<String> deleteTransferStagePopupMenuButton(
  BuildContext context,
  TransferStageGetTransportByCriteriaModel stageData,
) {
  return PopupMenuButton<String>(
    iconColor: kMainColor,
    constraints: BoxConstraints(minWidth: 150.w),
    color: kScaffoldBackgroundColor,
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: kScaffoldBackgroundColor),
      borderRadius: BorderRadius.circular(12.r),
    ),
    onSelected: (value) async {
      if (value == 'delete') {
        await deleteStageMethod(context, stageData);
      }
    },
    itemBuilder: (BuildContext context) {
      return [
        /// Delete
        PopupMenuItem(
          height: 40.h,
          value: 'delete',
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/svg/trash_full.svg',
                colorFilter: const ColorFilter.mode(
                  kErrorColor,
                  BlendMode.srcIn,
                ),
              ),
              W(w: 8.w),
              Text(
                'حذف',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kErrorColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  height: 1.67.h,
                ),
              ),
            ],
          ),
        ),
      ];
    },
  );
}
