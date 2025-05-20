import 'package:alrefadah/core/widgets/leading_icon.dart';
import 'package:alrefadah/core/widgets/title_appbar.dart';
import 'package:alrefadah/features/services_pages/buses/add/cubit/add_bus_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/add/widgets/add_bus_button.dart';
import 'package:alrefadah/features/services_pages/buses/add/widgets/add_bus_page_body.dart';
import 'package:alrefadah/features/services_pages/buses/main/repo/buses_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBusPage extends StatelessWidget {
  const AddBusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return BlocProvider<AddBusCubit>(
      create: (context) => AddBusCubit(BusesRepo()),
      child: Scaffold(
        appBar: AppBar(
          leading: const LeadingIcon(),
          title: const TitleAppBar(title: 'إضافة الحافلات'),
        ),

        /// Body
        body: AddBusPageBody(formKey: formKey),

        /// Add button
        bottomNavigationBar: AddBusButton(formKey: formKey),
      ),
    );
  }
}
