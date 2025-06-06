import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/services_pages/buses_travel/approval/select/views/select_approval_trips_page.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_trip_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApprovalTripTripsTab extends StatelessWidget {
  const ApprovalTripTripsTab({
    required this.remainingTripsCount,
    required this.trip,
    super.key,
  });
  final int remainingTripsCount;
  final BusesTravelGetTripModel trip;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.w),
          child: Row(
            children: [
              if (trip.transportStage.fStageStatus == 1)
                const Icon(
                  Icons.check_circle_outline_rounded,
                  color: kGreenColor,
                )
              else
                const Icon(Icons.cancel_outlined, color: kErrorColor),
              const Spacer(),

              /// المرحلة
              SizedBox(
                width: 90.w,
                child: Text(
                  context.read<BusTravelCubit>().getStageName(trip.fStageNo),
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: kDartTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              /// عدد الحجاج المخصص
              SizedBox(
                width: 50.w,
                child: Text(
                  trip.allocatedTripsCount,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: kDartTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              SizedBox(
                width: 50.w,
                child: Text(
                  trip.totalTripsCount,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: kDartTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                width: 50.w,
                child: Text(
                  remainingTripsCount.toString(),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: kDartTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              W(w: 12.w),
              if (trip.transportStage.fStageStatus == 1)
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: ShapeDecoration(
                    color: kMainExtrimeLightColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                  child: PopupMenuButton<String>(
                    iconColor: kMainColor,
                    constraints: BoxConstraints(minWidth: 150.w),
                    color: kScaffoldBackgroundColor,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: kScaffoldBackgroundColor),
                      borderRadius: BorderRadius.circular(12.r),
                    ),

                    onSelected: (value) {
                      if (value == 'select') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    SelectApprovalTripsPage(trip: trip),
                          ),
                        );
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          height: 40.h,
                          value: 'select',
                          child: Row(
                            children: [
                              Icon(
                                Icons.task_alt_rounded,
                                size: 20.sp,
                                color: kGreenColor,
                              ),
                              W(w: 8.w),
                              Text(
                                'اختيار',
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
                      ];
                    },
                  ),
                )
              else
                W(w: 40.w),
            ],
          ),
        ),
        const Divider(color: kAnalysisMediumColor),
      ],
    );
  }
}
