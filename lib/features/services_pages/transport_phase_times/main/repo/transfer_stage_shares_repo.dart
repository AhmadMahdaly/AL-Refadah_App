import 'package:dio/dio.dart';
import 'package:alrefadah/core/services/dio_helper.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/add/models/transport_add_stage_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_stage_get_centers_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_stage_get_session_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_stage_get_stages_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_stage_get_transport_by_criteria_model.dart';

class TransferStageSharesRepo {
  Future<List<TranferStageGetSeasonsModel>> getSeasons() async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/TransferStageShares/GetSeasons',
      );
      final data = response.data!;
      return data
          .map(
            (item) => TranferStageGetSeasonsModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<TransferStageGetCenterModel>> getCenters() async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/TransferStageShares/GetCenters',
      );
      final data = response.data!;
      return data
          .map(
            (item) => TransferStageGetCenterModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<TransferStageGetStageModel>> getTransportStages() async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/TransferStageShares/GetTransportStages',
      );
      final data = response.data!;
      return data
          .map(
            (item) => TransferStageGetStageModel.fromJson(
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
      await DioHelper.dio.post<Map<String, dynamic>>(
        '/TransferStageShares/AddHajTransportMax',
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
      await DioHelper.dio.put<Map<String, dynamic>>(
        '/TransferStageShares/UpdateHajTransportMax',
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

  Future<List<TransferStageGetTransportByCriteriaModel>>
  getTransportStageByCriteria(
    String selectedSeasonId,
    String selectedCenterId,
  ) async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/TransferStageShares/GetHajTransportMaxByCriteria/by-criteria?seasonId=$selectedSeasonId&centerNo=$selectedCenterId',
      );
      final data = response.data!;
      return data
          .map(
            (json) => TransferStageGetTransportByCriteriaModel.fromJson(
              json as Map<String, dynamic>,
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response}');
    }
  }

  Future<String?> deleteTransportStage(
    String stageNo,
    String centerNo,
    String selectedSeasonId,
  ) async {
    final data = await DioHelper.dio.delete<String>(
      '/TransferStageShares/DeleteHajTransportMax?stageNo=$stageNo&centerNo=$centerNo&companyId=$companyId&SeasonId=$selectedSeasonId',
    );

    return data.data;
  }
}
