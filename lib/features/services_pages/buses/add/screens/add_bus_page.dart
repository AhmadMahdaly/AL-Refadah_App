import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/features/services_pages/buses/add/cubit/add_bus_cubit.dart';
import 'package:alrefadah/features/services_pages/buses/add/widgets/add_bus_button.dart';
import 'package:alrefadah/features/services_pages/buses/add/widgets/add_bus_page_body.dart';
import 'package:alrefadah/features/services_pages/buses/main/repo/buses_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddBusPage extends StatelessWidget {
  const AddBusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddBusCubit>(
      create: (context) => AddBusCubit(BusesRepo()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'إضافة الحافلات',
            style: TextStyle(
              color: kMainColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              height: 1.43.h,
            ),
          ),
        ),
        body: const AddBusPageBody(),
        bottomNavigationBar: const AddBusButton(),
      ),
    );
  }
}
