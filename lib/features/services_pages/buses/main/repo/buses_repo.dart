import 'package:dio/dio.dart';
import 'package:alrefadah/core/services/dio_helper.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/buses/add/models/add_bus_model.dart';
import 'package:alrefadah/features/services_pages/buses/edit/models/edit_bus_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_all_transports_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_center_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_operating_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_season_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_stage_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/get_all_buses_model.dart';

class BusesRepo {
  Future<List<BusesGetSeasonModel>> getSeasons() async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/Buses/GetSeasons',
      );
      final data = response.data!;

      return data
          .map(
            (json) =>
                BusesGetSeasonModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<BusesGetCenterModel>> getCenters() async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/Buses/GetCenters',
      );
      final data = response.data!;
      return data
          .map(
            (item) =>
                BusesGetCenterModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<BusesGetStageModel>> getStages() async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/Buses/GetTransportStages',
      );
      final data = response.data!;
      return data
          .map(
            (item) => BusesGetStageModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<BusesGetOperatingModel>> getTransportOperting(
    int seasonId,
    String centerNo,
  ) async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/Buses/GetHajTransportOperating?SeasonId=$seasonId&CenterNo=$centerNo',
      );
      final data = response.data!;
      return data
          .map(
            (item) =>
                BusesGetOperatingModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<BusesGetAllTransportsModel>> getAllTransports() async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/Buses/GetAllTransports',
      );
      final data = response.data!;
      return data
          .map(
            (item) => BusesGetAllTransportsModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<void> addTransportBus(List<AddBusModel> inputs) async {
    try {
      await DioHelper.dio.post<Map<String, dynamic>>(
        '/Buses/AddHajTransportBus',
        data: inputs.map((e) => e.toJson()).toList(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
    } catch (e) {
      throw Exception('خطأ: $e');
    }
  }

  Future<void> editTransportBus(List<EditBusModel> inputs) async {
    try {
      await DioHelper.dio.put<Map<String, dynamic>>(
        '/Buses/UpdateHajTransportBus',
        data: inputs.map((e) => e.toJson()).toList(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
    } catch (e) {
      throw Exception('خطأ: $e');
    }
  }

  Future<List<GetAllBusesModel>> getAllBuses(int selectedSeason) async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/Buses/GetAllHajTransportBuses?SeasonId=$selectedSeason',
      );

      final data = response.data!;
      return data
          .map(
            (item) => GetAllBusesModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<Response<String>> deleteBus(
    int selectedSeason,
    int centerNo,
    int stageNo,
    String busNo,
    int busId,
  ) async {
    try {
      final response = await DioHelper.dio.delete<String>(
        '/Buses/DeleteHajTransportBus?busId=$busId&busNo=$busNo&stageNo=$stageNo&centerNo=$centerNo&companyId=$companyId&SeasonId=$selectedSeason',
      );
      return response;
    } on DioException catch (e) {
      throw Exception('خطأ: $e');
    }
  }

  Future<List<GetAllBusesModel>> getAllBusesByCriatia(
    int selectedSeason,
    String selectCenter,
  ) async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/Buses/GetHajTransportBusByCriteria/by-criteria?seasonId=$selectedSeason&centerNo=$selectCenter',
      );

      final data = response.data!;
      return data
          .map(
            (item) => GetAllBusesModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }
}
