import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/features/services_pages/buses/add_by_center/screens/add_bus_by_center_page.dart';
import 'package:alrefadah/features/services_pages/buses/edit/screens/edit_bus_page.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/get_all_buses_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/widgets/delete_bus_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

PopupMenuButton<String> showBusPopupMenuButton(
  BuildContext context,
  GetAllBusesModel bus,
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
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder:
        //         (context) => ShowGuidePage(),
        //   ),
        // );
      } else if (value == 'edit') {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditBusPage(oldBus: bus)),
        );
      } else if (value == 'add') {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddBusPageByCenter(bus: bus)),
        );
      } else if (value == 'delete') {
        try {
          if (context.mounted) {
            await deleteBusMethod(context, bus);
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
          value: 'add',
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/svg/add-square.svg',
                colorFilter: const ColorFilter.mode(
                  kMainColor,
                  BlendMode.srcIn,
                ),
              ),
              W(w: 8.w),
              Text(
                'إضافة',
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
        // ];
        // },
        // :
        //  (BuildContext context) {
        //   return [
        // PopupMenuItem(
        //   height: 40.h,
        //   value: 'show',
        //   child: Row(
        //     children: [
        //       SvgPicture.asset(
        //         'assets/svg/view.svg',
        //         colorFilter: const ColorFilter.mode(
        //           kMainColor,
        //           BlendMode.srcIn,
        //         ),
        //       ),
        //       W(w: 8.w),
        //       Text(
        //         'مشاهدة',
        //         textAlign: TextAlign.center,
        //         style: TextStyle(
        //           color: kMainColor,
        //           fontSize: 14.sp,
        //           fontWeight: FontWeight.w300,
        //           height: 1.67.h,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
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
