import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/cubit/bus_travel_cubit.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/widgets/buses_moves_popup_button.dart';

class PilgrimsCard extends StatelessWidget {
  const PilgrimsCard({required this.trip, super.key});
  final BusesTravelGetTripModel trip;

  @override
  Widget build(BuildContext context) {
    final allocatedPilgrimsCount = int.tryParse(trip.allocatedPilgrimsCount);
    final totalPilgrimsCount = int.tryParse(trip.totalPilgrimsCount);
    final remainingPilgrimsCount =
        allocatedPilgrimsCount! - totalPilgrimsCount!;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
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
                  trip.allocatedPilgrimsCount,
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
                  trip.totalPilgrimsCount,
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
                  remainingPilgrimsCount.toString(),
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
                  child: busesMovesPopupMenuButton(context, trip),
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
