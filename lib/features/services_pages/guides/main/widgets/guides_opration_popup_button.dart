import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/services_pages/guides/add/widgets/add_guide_body.dart';
import 'package:alrefadah/features/services_pages/guides/delete/screens/delete_guide_page.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_cubit.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_centers_model.dart';
import 'package:alrefadah/features/services_pages/guides/show_all/screens/show_all_guides_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

PopupMenuButton<String> guidesPopupMenuButton(
  BuildContext context,
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
    onSelected: (value) {
      context.read<GuidesCubit>().selectedSeason = center.fSeasonId.toString();
      context.read<GuidesCubit>().selectedCenter = center.fCenterNo.toString();
      BlocProvider.of<GuidesCubit>(context).selectedCenter =
          center.fCenterNo.toString();
      BlocProvider.of<GuidesCubit>(context).fetchGuides();
      if (value == 'show') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowAllGuidesPages(center: center),
          ),
        );
      } else if (value == 'delete') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeleteGuidePage(center: center),
          ),
        );
      } else if (value == 'add') {
        context.read<GuidesCubit>().fetchCenters();
        context.read<GuidesCubit>().selectedSeason =
            center.fSeasonId.toString();
        context.read<GuidesCubit>().selectedCenter =
            center.fCenterNo.toString();
        BlocProvider.of<GuidesCubit>(context).fetchGuides();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GuideSelectorBody(center: center),
          ),
          // AddGuidePage(center: center)),
        );
      }
    },
    itemBuilder:
    // center.isAdded == 0
    //     ?
    (BuildContext context) {
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
        // PopupMenuItem(
        //   height: 40.h,
        //   value: 'edit',
        //   child: Row(
        //     children: [
        //       SvgPicture.asset(
        //         'assets/svg/edit-outline.svg',
        //         colorFilter: const ColorFilter.mode(
        //           kMainColor,
        //           BlendMode.srcIn,
        //         ),
        //       ),
        //       W(w: 8.w),
        //       Text(
        //         'تعديل',
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
        if (center.fCountEmp != 0)
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
                  'حذف مرشد',
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
