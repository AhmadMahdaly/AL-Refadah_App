import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/features/services_pages/guides/delete/widgets/widgets/delete_guide_method.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/by_criteria/assignment_model.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_centers_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

PopupMenuButton<String> deleteGuidePopupMenuButton(
  BuildContext context,
  AssignmentModel employe,
  GetGuidesCenterModel center,
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
        try {
          if (context.mounted) {
            await deleteGuideMethod(context, employe, center);
          }
        } catch (e) {
          if (context.mounted) {
            showErrorDialog(
              isBack: true,
              context,
              message: 'حدث خطأ',
              icon: Icons.error_outline_rounded,
              color: kErrorColor,
            );
          }
        }
      }
    },
    itemBuilder: (BuildContext context) {
      return [
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
