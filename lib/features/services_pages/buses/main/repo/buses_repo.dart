import 'package:alrefadah/data/base_api_url.dart';
import 'package:alrefadah/features/services_pages/buses/add/models/add_bus_model.dart';
import 'package:alrefadah/features/services_pages/buses/edit/models/edit_bus_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_all_transports_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_center_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_operating_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_season_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_stage_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/get_all_buses_model.dart';
import 'package:dio/dio.dart';

class BusesRepo {
  final Dio dio = Dio();

  Future<List<BusesGetSeasonModel>> getSeasons() async {
    try {
      final response = await dio.get<List<dynamic>>(
        '$baseUrl/Buses/GetSeasons',
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
      final response = await dio.get<List<dynamic>>(
        '$baseUrl/Buses/GetCenters',
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
      final response = await dio.get<List<dynamic>>(
        '$baseUrl/Buses/GetTransportStages',
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
    String seasonId,
    String centerNo,
  ) async {
    try {
      final response = await dio.get<List<dynamic>>(
        '$baseUrl/Buses/GetHajTransportOperating?SeasonId=$seasonId&CenterNo=$centerNo',
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
      final response = await dio.get<List<dynamic>>(
        '$baseUrl/Buses/GetAllTransports',
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
      await dio.post<Map<String, dynamic>>(
        '$baseUrl/Buses/AddHajTransportBus',
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
      await dio.put<Map<String, dynamic>>(
        '$baseUrl/Buses/UpdateHajTransportBus',
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

  Future<List<GetAllBusesModel>> getAllBuses(String selectedSeason) async {
    try {
      final response = await dio.get<List<dynamic>>(
        '$baseUrl/Buses/GetAllHajTransportBuses?SeasonId=$selectedSeason',
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
