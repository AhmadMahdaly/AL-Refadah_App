import 'package:flutter/material.dart';
import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/trip_model.dart';
import 'package:alrefadah/features/services_pages/complaint/add/widgets/add_complaint_body.dart';

class AddComplaintPage extends StatelessWidget {
  const AddComplaintPage({required this.trip, super.key});
  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const LeadingIcon(),
        title: TitleAppBar(title: 'إضافة بلاغ لرحلة: ${trip.fTripNo}'),
      ),
      body: AddComplaintBody(trip: trip),
    );
  }
}
