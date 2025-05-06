import 'package:alrefadah/data/base_api_url.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/add/models/transport_add_stage_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_get_centers_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_get_session_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_get_stages_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transport_get_by_criteria_model.dart';
import 'package:dio/dio.dart';

class TransferStageSharesRepo {
  final Dio dio = Dio();

  Future<List<TranferStageSharesGetSeasonsModel>> getSeasons() async {
    try {
      final response = await dio.get<List<dynamic>>(
        '$baseUrl/TransferStageShares/GetSeasons',
      );
      final data = response.data!;
      return data
          .map(
            (item) => TranferStageSharesGetSeasonsModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<TransferStageSharesGetCenterModel>> getCenters() async {
    try {
      final response = await dio.get<List<dynamic>>(
        '$baseUrl/TransferStageShares/GetCenters',
      );
      final data = response.data!;
      return data
          .map(
            (item) => TransferStageSharesGetCenterModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<TransferStageSharesGetStageModel>> getTransportStages() async {
    try {
      final response = await dio.get<List<dynamic>>(
        '$baseUrl/TransferStageShares/GetTransportStages',
      );
      final data = response.data!;
      return data
          .map(
            (item) => TransferStageSharesGetStageModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<void> addTransportStage(List<AddTransportStageModel> inputs) async {
    try {
      await dio.post<Map<String, dynamic>>(
        '$baseUrl/TransferStageShares/AddHajTransportMax',
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

  Future<void> editTransportStage(List<AddTransportStageModel> inputs) async {
    try {
      await dio.put<Map<String, dynamic>>(
        '$baseUrl/TransferStageShares/UpdateHajTransportMax',
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

  Future<List<TransferStageSharesGetByCriteriaModel>>
  getTransportStageByCriteria(
    String selectedSeasonId,
    String selectedCenterId,
  ) async {
    try {
      final response = await dio.get<List<dynamic>>(
        '$baseUrl/TransferStageShares/GetHajTransportMaxByCriteria/by-criteria?seasonId=$selectedSeasonId&centerNo=$selectedCenterId',
      );
      final data = response.data!;
      return data
          .map(
            (json) => TransferStageSharesGetByCriteriaModel.fromJson(
              json as Map<String, dynamic>,
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }
}
