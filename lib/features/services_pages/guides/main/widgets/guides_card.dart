import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_centers_model.dart';
import 'package:alrefadah/features/services_pages/guides/main/widgets/guides_opration_popup_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuidesCard extends StatelessWidget {
  const GuidesCard({required this.center, super.key});
  final GetGuidesCenterModel center;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 95.w,
                child: Text(
                  center.fCenterName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: kDartTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                width: 80.w,
                child: Text(
                  '${center.fCenterNo}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kDartTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              SizedBox(
                width: 80.w,
                child: Text(
                  '${center.fCountEmp}',
                  textAlign: TextAlign.center,
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
                child: guidesPopupMenuButton(context, center),
              ),
            ],
          ),
        ),
        const Divider(color: kMainColorLightColor),
      ],
    );
  }
}
