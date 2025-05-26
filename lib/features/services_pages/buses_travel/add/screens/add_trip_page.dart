import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/widgets/add_trip_body.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_trip_model.dart';
import 'package:flutter/material.dart';

class AddTripPage extends StatelessWidget {
  const AddTripPage({
        required this.tripsByStage,
    required this.trip,
    super.key,
  });
  final BusesTravelGetTripModel trip;
  final List<TripModel> tripsByStage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const LeadingIcon(),
        title: const TitleAppBar(title: 'إضافة رحلة'),
      ),
      body: AddTripBody(tripsByStage: tripsByStage, trip: trip),
    );
  }
}
