import 'package:dio/dio.dart';
import 'package:alrefadah/core/services/dio_helper.dart';
import 'package:alrefadah/features/services_pages/transport_stage/models/stage_model.dart';

class StageRepo {
  Future<List<StageModel>> getStages() async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/TransportStage/GetTransportStages',
      );
      final data = response.data!;
      return data
          .map((item) => StageModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<void> updateStages(List<StageModel> inputs) async {
    try {
      await DioHelper.dio.put<Map<String, dynamic>>(
        '/TransportStage/UpdateHajTransportStage',
        data: inputs.map((e) => e.toJson()).toList(),
      );
    } catch (e) {
      throw Exception('خطأ: $e');
    }
  }
}
