import 'package:alrefadah/data/base_api_url.dart';
import 'package:alrefadah/features/services_pages/buses/add/models/add_bus_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_cubit.dart';
import 'package:alrefadah/presentation/app/shared_widgets/custom_dialog/show_success_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final Dio dio = Dio();

class AddBusesRepo {
  Future<void> addBusesData(
    List<AddBusModel> model,
    BuildContext context,
  ) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        '$baseUrl/Buses/AddHajTransportBus',
        data: model.map((e) => e.toJson()).toList(),
      );

      if (response.toString().contains(
        '"message":"Data inserted Successfully"',
      )) {
        showSuccessDialog(context);
        Future.delayed(const Duration(seconds: 2), () {
          if (context.mounted) {
            Navigator.pop(context, context.read<BusesCubit>().getAllBuses());
          }
        });
      } else if (response.toString().contains(
        "Violation of PRIMARY KEY constraint 'haj_transport_buses_x'",
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Center(
              child: Text('رقم الحافلة لا يجب أن يكون مسجل مسبقا'),
            ),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: Text('$response')),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text('قيمة الإدخال خاطئة')),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
