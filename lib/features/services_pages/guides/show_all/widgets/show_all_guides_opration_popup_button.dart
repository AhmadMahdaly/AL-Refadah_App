import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/guides/add/models/add_guide_model.dart';
import 'package:alrefadah/features/services_pages/guides/main/cubit/guides_cubit.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_centers_model.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_guide_model.dart';
import 'package:alrefadah/features/services_pages/guides/show_single/screens/show_guide_page.dart';
import 'package:alrefadah/features/services_pages/guides/update/screens/update_guide_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

PopupMenuButton<String> showOprationAllGuidesPopupMenuButton(
  BuildContext context,
  GetGuidesModel employe,
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
      if (value == 'show') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => ShowGuidePage(center: center, employe: employe),
          ),
        );
      } else if (value == 'edit') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => UpdateGuidePage(center: center, employe: employe),
          ),
        );
      } else if (value == 'delete') {
        // final model = UpateHajTransportGuideModel(
        //   fLastUpdate: DateTime.now(),
        //   fLastUpdateUser: 1,
        //   fLastUpdateSum: 0,
        //   fLastUpdateOper: 0,
        //   fCompanyId: 1,
        //   fSeasonId: center.fSeasonId,
        //   fCenterNo: center.fCenterNo,
        //   fEmpNo: 0,
        // );
        // log(model.toJson().toString());
        // // Map<String, dynamic> modelJson =
        // context.read<GuidesCubit>().updateEmployeeAssignment(model);
      } else {
        // employe.empNo

        final model = [
          AddGuideModel(
            fLastUpdate: DateTime.now(),
            fLastUpdateUser: 1,
            fLastUpdateSum: 0,
            fLastUpdateOper: 0,
            fCompanyId: companyId,
            fSeasonId: center.fSeasonId,
            fCenterNo: center.fCenterNo,
            fEmpNo: 1,
          ),
        ];
        context.read<GuidesCubit>().addHajTransGuide(model);
        BlocProvider.of<GuidesCubit>(context).fetchCenters();
        BlocProvider.of<GuidesCubit>(context).fetchSeasons();
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
        PopupMenuItem(
          height: 40.h,
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.red[700], size: 18.w),
              W(w: 8.w),
              Text(
                'حذف',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red[700],
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
