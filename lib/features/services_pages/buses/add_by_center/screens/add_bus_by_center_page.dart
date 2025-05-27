import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/features/services_pages/buses/add/widgets/add_bus_button.dart';
import 'package:alrefadah/features/services_pages/buses/add_by_center/widgets/add_bus_by_center_body.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/get_all_buses_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddBusPageByCenter extends StatelessWidget {
  const AddBusPageByCenter({required this.bus, super.key});
  final GetAllBusesModel bus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.h,
        leading: const LeadingIcon(),
        title: const TitleAppBar(title: 'إضافة الحافلات'),
      ),
      body: AddBusPageByCenterBody(bus: bus),
      bottomNavigationBar: const AddBusButton(),
    );
  }
}
