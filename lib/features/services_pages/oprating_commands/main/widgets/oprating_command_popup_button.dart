import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/add/screens/add_oprating_commands_page.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/edit/screens/edit_oprating_commands.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/models/get_all_operatings_model.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/widgets/delete_oprating_command_method.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/show/screens/show_oprating_commands_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

PopupMenuButton<String> showOprationOpratingPopupMenuButton(
  BuildContext context,
  GetAllOperatingsModel item,
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
      if (value == 'show') {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowOpratingCommandsPage(data: item),
          ),
        );
      } else if (value == 'edit') {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditOpratingCommands(data: item),
          ),
        );
      } else if (value == 'delete') {
        await deleteOpertionCommandsMethod(context, item);
      } else {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddOpratingCommandsPage(),
          ),
        );
      }
    },
    itemBuilder: (BuildContext context) {
      return [
        PopupMenuItem(
          height: 40.h,
          value: 'show',
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/svg/view.svg',
                colorFilter: const ColorFilter.mode(
                  kMainColor,
                  BlendMode.srcIn,
                ),
              ),

              W(w: 8.w),
              Text(
                'مشاهدة',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kMainColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  height: 1.67.h,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          height: 40.h,
          value: 'edit',
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/svg/edit-outline.svg',
                colorFilter: const ColorFilter.mode(
                  kMainColor,
                  BlendMode.srcIn,
                ),
              ),
              W(w: 8.w),
              Text(
                'تعديل',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kMainColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  height: 1.67.h,
                ),
              ),
            ],
          ),
        ),
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
