import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/features/services_pages/buses/edit/widgets/edit_bus_body.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/get_all_buses_model.dart';
import 'package:flutter/material.dart';

class EditBusPage extends StatelessWidget {
  const EditBusPage({required this.oldBus, super.key});
  final GetAllBusesModel oldBus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const LeadingIcon(),
        title: const TitleAppBar(title: 'تعديل بيانات الحافلة'),
      ),
      body: EditBusBody(oldBus: oldBus),
    );
  }
}
