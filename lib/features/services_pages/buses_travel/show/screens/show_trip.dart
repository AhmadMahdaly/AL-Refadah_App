import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/show/widgets/show_trip_body.dart';
import 'package:flutter/material.dart';

class ShowBusTravelTrip extends StatelessWidget {
  const ShowBusTravelTrip({required this.trip, super.key});
  final TripModel trip;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const LeadingIcon(),
        title: TitleAppBar(title: 'رحلة: ${trip.fTripNo}'),
      ),
      body: ShowTripBody(trip: trip),
    );
  }
}
