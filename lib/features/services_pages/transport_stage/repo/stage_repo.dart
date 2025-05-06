import 'package:alrefadah/data/base_api_url.dart';
import 'package:alrefadah/features/services_pages/transport_stage/models/stage_model.dart';
import 'package:dio/dio.dart';

class StageRepo {
  final Dio dio = Dio();

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

  Future<void> updateStages(List<StageModel> inputs) async {
    try {
      await dio.put<Map<String, dynamic>>(
        '$baseUrl/TransportStage/UpdateHajTransportStage',
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
}
