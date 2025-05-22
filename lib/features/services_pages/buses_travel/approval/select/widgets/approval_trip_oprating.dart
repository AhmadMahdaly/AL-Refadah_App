import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/approval/main/widgets/approval_arrivel_dialog.dart';
import 'package:alrefadah/features/services_pages/buses_travel/approval/main/widgets/confirm_arrivel_dialog.dart';
import 'package:alrefadah/features/services_pages/buses_travel/show/screens/show_trip.dart';
import 'package:alrefadah/features/services_pages/complaint/add/views/add_complaint_page.dart';

class ApprovalTripOprating extends StatelessWidget {
  const ApprovalTripOprating({required this.trip, super.key});

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: ShapeDecoration(
        color: kMainExtrimeLightColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
      ),
      child: PopupMenuButton<String>(
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
              await confirmArrTripMethod(context, trip);
            }
          } else if (value == 'approval') {
            if (context.mounted) {
              await approvalTMethod(context, trip);
            }
          }
        },
        itemBuilder: (BuildContext context) {
          return [
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
            PopupMenuItem(
              height: 40.h,
              value: 'notice',
              child: Row(
                children: [
                  const Icon(
                    Icons.notification_important_outlined,
                    color: kErrorColor,
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
      ),
    );
  }
}
