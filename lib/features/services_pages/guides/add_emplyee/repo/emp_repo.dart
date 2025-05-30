import 'dart:developer';

import 'package:alrefadah/core/services/dio_helper.dart';
import 'package:alrefadah/features/services_pages/guides/add_emplyee/models/add_emplyee_model.dart';
import 'package:alrefadah/features/services_pages/guides/add_emplyee/models/employee_response_model.dart';
import 'package:dio/dio.dart';

class EmployeesRepo {
  Future<bool> addEmpoloyee(AddEmployeeModel model) async {
    try {
      final response = await DioHelper.dio.post<Map<String, dynamic>>(
        '/Employees/AddEmployeeAndGuide',
        data: model.toJson(),
      );
      log(response.data.toString());
      if (response.data!['status'] == 'Success') {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      log(e.toString());
      throw Exception(e.response?.data);
    }
  }

  Future<List<EmpDataModel>> getNationalities() async {
    try {
      final response = await DioHelper.dio.get<Map<String, dynamic>>(
        '/Employees/GetAllNationalities',
      );

      final nationalityResponse = EmpResponseModel.fromJson(response.data!);

      return nationalityResponse.data;
    } catch (e) {
      throw Exception('فشل في جلب قائمة الجنسيات: $e');
    }
  }

  Future<List<EmpDataModel>> getBanks() async {
    try {
      final response = await DioHelper.dio.get<Map<String, dynamic>>(
        '/Employees/GetAllBanks',
      );

      final bankResponse = EmpResponseModel.fromJson(response.data!);

      return bankResponse.data;
    } catch (e) {
      throw Exception('فشل في جلب قائمة البنوك: $e');
    }
  }

  Future<List<EmpDataModel>> getCertificates() async {
    try {
      final response = await DioHelper.dio.get<Map<String, dynamic>>(
        '/Employees/GetAllQualis',
      );

      final certificateResponse = EmpResponseModel.fromJson(response.data!);

      return certificateResponse.data;
    } catch (e) {
      throw Exception('فشل في جلب قائمة الشهادات: $e');
    }
  }

  Future<List<EmpDataModel>> getMajors() async {
    try {
      final response = await DioHelper.dio.get<Map<String, dynamic>>(
        '/Employees/GetAllMajors',
      );

      final certificateResponse = EmpResponseModel.fromJson(response.data!);

      return certificateResponse.data;
    } catch (e) {
      throw Exception('فشل في جلب قائمة التخصصات: $e');
    }
  }

  Future<List<EmpDataModel>> getCities() async {
    try {
      final response = await DioHelper.dio.get<Map<String, dynamic>>(
        '/Employees/GetAllCities',
      );

      final certificateResponse = EmpResponseModel.fromJson(response.data!);

      return certificateResponse.data;
    } catch (e) {
      throw Exception('فشل في جلب قائمة المدن: $e');
    }
  }
}
