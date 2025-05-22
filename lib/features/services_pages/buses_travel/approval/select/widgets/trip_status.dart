import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/core/utils/components/space.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/select/widgets/get_trip_status_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TripStatus extends StatelessWidget {
  const TripStatus({required this.trip, super.key});
  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5.w,
      children: [
        Text(
          'حالة الرحلة:',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: kAnalysisMediumColor,
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        const W(w: 12),
        SvgPicture.asset(getTripStatusIcon(trip.fTripStstus)),
        Text(
          getTripStatusText(trip.fTripStstus),
          textAlign: TextAlign.center,
          overflow: TextOverflow.fade,
          style: TextStyle(
            color: getTripStatusColor(trip.fTripStstus),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
