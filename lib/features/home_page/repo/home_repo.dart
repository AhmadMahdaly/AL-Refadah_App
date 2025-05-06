import 'package:alrefadah/data/base_api_url.dart';
import 'package:alrefadah/features/home_page/models/dashboard_model.dart';
import 'package:alrefadah/features/home_page/models/home_season_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_centers_model.dart';
import 'package:alrefadah/features/services_pages/transport_stage/models/stage_model.dart';
import 'package:dio/dio.dart';

class GetHomePageRepo {
  final Dio dio = Dio();

  Future<List<HomeSeasonModel>> fetchSeasons() async {
    try {
      final response = await dio.get<List<dynamic>>(
        '$baseUrl/Buses/GetSeasons',
      );
      final data = response.data!;

      return data
          .map((json) => HomeSeasonModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<BusesTravelGetCenterModel>> getCenters() async {
    try {
      final response = await dio.get<List<dynamic>>(
        '$baseUrl/Guides/GetCenters',
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

  Future<List<StageModel>> getStages() async {
    try {
      final response = await dio.get<List<dynamic>>(
        '$baseUrl/TransportStage/GetTransportStages',
      );
      final data = response.data!;
      return data
          .map((item) => StageModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<DashboardModel> getDashboardData(
    String seasonId,
    String centerNo,
    String stageNo,
  ) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        '$baseUrl/Dashboard/DashboardReport?SeasonId=$seasonId&CenterNo=$centerNo&StageNo=$stageNo',
      );
      return DashboardModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }
}
