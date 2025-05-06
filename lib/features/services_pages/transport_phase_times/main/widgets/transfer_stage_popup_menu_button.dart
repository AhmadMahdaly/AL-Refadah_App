import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/add/screens/add_transfer_stage_page.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/edit/screens/edit_transfer_stage_page.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_get_centers_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/show/screens/show_transfer_stage_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

PopupMenuButton<String> transferStagePopupMenuButton(
  BuildContext context,
  TransferStageSharesGetCenterModel center,
) {
  void updateCubitAndNavigate(String route) {
    Widget page;
    switch (route) {
      case 'show':
        page = ShowTransferStagePage(center: center);
      case 'edit':
        page = EditTransferStagePage(center: center);
      default:
        page = AddTransferStagePage(center: center);
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  PopupMenuEntry<String> buildMenuItem(
    String value,
    String iconPath,
    String text,
  ) {
    return PopupMenuItem<String>(
      height: 40.h,
      value: value,
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            colorFilter: const ColorFilter.mode(kMainColor, BlendMode.srcIn),
          ),
          W(w: 8.w),
          Text(
            text,
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
    onSelected: updateCubitAndNavigate,
    itemBuilder: (context) {
      if (center.isAdded == 0) {
        return [buildMenuItem('add', 'assets/svg/add-square.svg', 'إضافة')];
      }
      return [
        buildMenuItem('show', 'assets/svg/view.svg', 'مشاهدة'),
        buildMenuItem('edit', 'assets/svg/edit-outline.svg', 'تعديل'),
      ];
    },
  );
}
