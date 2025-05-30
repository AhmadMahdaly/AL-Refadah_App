import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/features/services_pages/buses_travel/store_w_add_trip/widgets/strore_w_add_trip_body.dart';
import 'package:flutter/material.dart';

class StoreWAddTripPage extends StatelessWidget {
  const StoreWAddTripPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const LeadingIcon(),
        title: const TitleAppBar(title: 'إضافة رحلة'),
      ),
      body: const StroreWAddTripBody(),
    );
  }
}
