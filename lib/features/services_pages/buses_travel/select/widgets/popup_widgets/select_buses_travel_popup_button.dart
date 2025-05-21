import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/core/widgets/custom_dialog/error_dialog.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/edit/screens/edit_trip_by_stage.dart';
import 'package:alrefadah/features/services_pages/buses_travel/select/widgets/popup_widgets/approval_trip_method.dart';
import 'package:alrefadah/features/services_pages/buses_travel/select/widgets/popup_widgets/confirm_receive_trip_method.dart';
import 'package:alrefadah/features/services_pages/buses_travel/select/widgets/popup_widgets/delete_trip_method.dart';
import 'package:alrefadah/features/services_pages/buses_travel/show/screens/show_trip.dart';
import 'package:alrefadah/features/services_pages/complaint/views/add_complaint_page.dart';

PopupMenuButton<String> selectBusesPopupMenuButton(
  BuildContext context,
  TripModel trip,
  List<TripModel> tripsByStage,
  int userId,
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
            builder: (context) => ShowBusTravelTrip(trip: trip),
          ),
        );
      } else if (value == 'notice') {
        if (context.mounted) {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddComplaintPage(trip: trip),
            ),
          );
        }
      } else if (value == 'done') {
        if (context.mounted) {
          await confirmReceiveTripMethod(context, trip, userId);
        }
      } else if (value == 'edit') {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    EditTripByStage(trip: trip, tripsByStage: tripsByStage),
          ),
        );
      } else if (value == 'approval') {
        if (context.mounted) {
          await approvalTripMethod(context, trip, userId);
        }
      } else if (value == 'delete') {
        try {
          if (context.mounted) {
            await deleteTripMethod(context, trip);
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
        if (trip.fTripStstus == '1')
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
        if (trip.fTripStstus == '1')
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
        if (trip.fTripStstus == '1')
          PopupMenuItem(
            height: 40.h,
            value: 'done',
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/svg/add-square.svg',
                  colorFilter: const ColorFilter.mode(
                    kGreenColor,
                    BlendMode.srcIn,
                  ),
                ),
                W(w: 8.w),
                Text(
                  'تأكيد الوصول',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kGreenColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                    height: 1.67.h,
                  ),
                ),
              ],
            ),
          ),
        if (trip.fTripStstus == '2')
          PopupMenuItem(
            height: 40.h,
            value: 'approval',
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/svg/add-square.svg',
                  colorFilter: const ColorFilter.mode(
                    kGreenColor,
                    BlendMode.srcIn,
                  ),
                ),
                W(w: 8.w),
                Text(
                  'اعتماد الرحلة',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kGreenColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                    height: 1.67.h,
                  ),
                ),
              ],
            ),
          ),
        if (trip.fTripStstus == '3')
          PopupMenuItem(
            height: 40.h,
            value: 'notice',
            child: Row(
              children: [
                Icon(
                  Icons.notification_important_outlined,
                  color: kErrorColor,
                  size: 16.sp,
                ),

                W(w: 8.w),
                Text(
                  'إضافة بلاغ',
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
