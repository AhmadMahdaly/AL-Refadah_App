import 'dart:developer';

import 'package:alrefadah/core/services/dio_helper.dart';
import 'package:alrefadah/features/home_page/models/dashboard_model.dart';
import 'package:alrefadah/features/home_page/models/home_season_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/track_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_centers_model.dart';
import 'package:alrefadah/features/services_pages/transport_stage/models/stage_model.dart';
import 'package:dio/dio.dart';

class HomeRepo {
  Future<List<HomeSeasonModel>> fetchSeasons() async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/Dashboard/GetSeasons',
      );
      final data = response.data!;

      return data
          .map((json) => HomeSeasonModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      log(e.toString());
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<BusesTravelGetCenterModel>> getCenters() async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/Dashboard/GetCenters',
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
      log(e.toString());
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<StageModel>> getStages() async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/Dashboard/GetTransportStages',
      );
      final data = response.data!;
      return data
          .map((item) => StageModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      log(e.toString());
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<TrackModel>> getTracks() async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/Dashboard/GetTrack',
      );
      final data = response.data!;
      return data
          .map((item) => TrackModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      log(e.toString());
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<DashboardModel> getDashboardData(
    int seasonId,
    int centerNo,
    int stageNo,
    int trackNo,
  ) async {
    log('$seasonId   && $centerNo $stageNo  $trackNo');

    try {
      final response = await DioHelper.dio.get<Map<String, dynamic>>(
        '/Dashboard/DashboardReport?SeasonId=$seasonId&CenterNo=$centerNo&StageNo=$stageNo&TrackNo=$trackNo',
      );
      log(response.data.toString());
      return DashboardModel.fromJson(response.data!);
   
    } catch (e) {
      log(e.toString());
      throw Exception('خطأ غير متوقع: $e');
    }
  }
}
