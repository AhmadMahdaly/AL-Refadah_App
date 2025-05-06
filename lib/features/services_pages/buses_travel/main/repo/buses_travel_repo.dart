import 'package:alrefadah/data/base_api_url.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/add_buses_travel_trip_by_stage_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/bus_travel_trip_model_by_stage_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_centers_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_seasons_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_trip_model.dart';
import 'package:dio/dio.dart';

class BusesTravelRepo {
  final Dio dio = Dio();

  Future<List<BusesTravelGetSeasonModel>> getSeasons() async {
    try {
      final response = await dio.get<List<dynamic>>(
        '$baseUrl/BusesTravel/GetSeasons',
      );
      final data = response.data!;

      return data
          .map(
            (json) => BusesTravelGetSeasonModel.fromJson(
              json as Map<String, dynamic>,
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<BusesTravelGetCenterModel>> getCenters() async {
    try {
      final response = await dio.get<List<dynamic>>(
        '$baseUrl/BusesTravel/GetCenters',
      );
      final data = response.data!;
      return data
          .map(
            (item) => BusesTravelGetCenterModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<BusesTravelGetTripModel>> getTrips(
    String seasonId,
    String centerNo,
  ) async {
    try {
      final response = await dio.get<List<dynamic>>(
        '$baseUrl/BusesTravel/GetHajTransportTrip/Trip?SeasonId=$seasonId&CenterNo=$centerNo&CompanyId=$companyId',
      );
      final data = response.data!;
      return data
          .map(
            (item) =>
                BusesTravelGetTripModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<TripModel>> getTripsByStage(
    String seasonId,
    String centerNo,
    String stageNo,
  ) async {
    try {
      final response = await dio.get<List<dynamic>>(
        '$baseUrl/BusesTravel/GetHajTransportTripsByStage/TripsByStage?SeasonId=$seasonId&CenterNo=$centerNo&StageNo=$stageNo&CompanyId=$companyId',
      );
      final data = response.data!;
      return data
          .map((item) => TripModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<void> addTripByStage(AddTripModel inputs) async {
    try {
      await dio.post<Map<String, dynamic>>(
        '$baseUrl/BusesTravel/AddHajTransportTrip/Trip',
        data: inputs.toJson(),
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data);
    }
  }

  Future<void> editTripByStage(AddTripModel inputs) async {
    try {
      await dio.put<Map<String, dynamic>>(
        '$baseUrl/BusesTravel/UpdateHajTransportTrip/Trip',
        data: inputs.toJson(),
      );
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<void> deleteTripByStage(
    String tripNo,
    String seasonId,
    String centerNo,
    String stageNo,
  ) async {
    try {
      await dio.delete<Map<String, dynamic>>(
        '$baseUrl/BusesTravel/DeleteHajTransportTrip/Trip?tripNo=$tripNo&companyId=$companyId&seasonId=$seasonId&centerNo=$centerNo&stageNo=$stageNo',
      );
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }
}
