import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/add/screens/add_transfer_stage_page.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/delete/screens/delete_transport_stage_page.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/edit/screens/edit_transfer_stage_page.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_stage_get_centers_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/show/screens/show_transfer_stage_page.dart';

/// اجراءات حصص النقل
PopupMenuButton<String> transferStagePopupMenuButton(
  BuildContext context,
  TransferStageGetCenterModel center,
) {
  void navigate(String route) {
    Widget page;
    switch (route) {
      case 'show':
        page = ShowTransferStagePage(center: center);
      case 'edit':
        page = EditTransferStagePage(center: center);
      case 'delete':
        page = DeleteTransferStagePage(center: center);
      default:
        page = AddTransferStagePage(center: center);
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  PopupMenuEntry<String> menuItem(
    String value,
    String iconPath,
    String text, {
    Color color = kMainColor,
  }) {
    return PopupMenuItem<String>(
      height: 40.h,
      value: value,
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          W(w: 8.w),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
              height: 1.67.h,
            ),
          ),
        ],
      ),
    );
  }

  return PopupMenuButton<String>(
    iconColor: kMainColor,
    constraints: BoxConstraints(minWidth: 150.w),
    color: kScaffoldBackgroundColor,
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: kScaffoldBackgroundColor),
      borderRadius: BorderRadius.circular(12.r),
    ),
    onSelected: navigate,
    itemBuilder: (context) {
      if (center.isAdded == 0) {
        return [menuItem('add', 'assets/svg/add-square.svg', 'إضافة')];
      }
      return [
        menuItem('show', 'assets/svg/view.svg', 'مشاهدة'),
        menuItem('edit', 'assets/svg/edit-outline.svg', 'تعديل'),
        menuItem(
          'delete',
          'assets/svg/trash_full.svg',
          'حذف',
          color: kErrorColor,
        ),
      ];
    },
  );
}
