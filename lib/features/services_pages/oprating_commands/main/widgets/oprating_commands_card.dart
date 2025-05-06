import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/models/get_all_operatings_model.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/widgets/oprating_command_popup_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpratingCommandsCard extends StatelessWidget {
  const OpratingCommandsCard({required this.item, super.key});
  final GetAllOperatingsModel item;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              SizedBox(
                width: 100.w,
                child: Text(
                  item.center?.fCenterName ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: kDartTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                width: 45.w,
                child: Text(
                  item.fOperatingNo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kDartTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                width: 70.w,
                child: Text(
                  item.fBusAco.toString(),

                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kDartTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                width: 60.w,
                child: Text(
                  item.busReceiptCount.toString(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: kDartTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: 40.w,
                height: 40.h,
                decoration: ShapeDecoration(
                  color: kMainExtrimeLightColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),
                child: showOprationOpratingPopupMenuButton(context, item),
              ),
            ],
          ),
        ),
        const Divider(color: kMainColorLightColor),
      ],
    );
  }
}
