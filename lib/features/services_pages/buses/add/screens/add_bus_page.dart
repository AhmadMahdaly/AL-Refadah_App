import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/features/services_pages/buses/add/widgets/add_bus_button.dart';
import 'package:alrefadah/features/services_pages/buses/add/widgets/add_bus_page_body.dart';
import 'package:flutter/material.dart';

class AddBusPage extends StatelessWidget {
  const AddBusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const LeadingIcon(),
          title: const TitleAppBar(title: 'إضافة الحافلات'),
        ),

        /// Body
        body: const AddBusPageBody(),

        /// Add button
        bottomNavigationBar: const AddBusButton(),
     
    );
  }
}
