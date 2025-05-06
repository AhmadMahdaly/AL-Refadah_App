import 'package:alrefadah/core/themes/colors_constants.dart';
import 'package:alrefadah/features/services_pages/buses/edit/widgets/edit_bus_body.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/get_all_buses_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditBusPage extends StatelessWidget {
  const EditBusPage({required this.oldBus, super.key});
  final GetAllBusesModel oldBus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),

        title: Text(
          'تعديل بيانات الحافلة',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kMainColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            height: 1.43.h,
          ),
        ),
      ),
      body: EditBusBody(oldBus: oldBus),
    );
  }
}
