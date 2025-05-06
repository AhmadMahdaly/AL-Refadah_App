import 'package:alrefadah/data/base_api_url.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/models/add_transport_operating_model.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/models/get_all_operatings_model.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/models/operating_command_get_centers_model.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/models/operating_command_get_seasons_model.dart';
import 'package:dio/dio.dart';

class OperatingCommandsRepo {
  final Dio dio = Dio();
  Future<List<OperatingCommandsGetSeasonsModel>> getSeasons() async {
    try {
      final response = await dio.get<List<dynamic>>(
        '$baseUrl/OperatingCommands/GetSeasons',
      );
      final data = response.data!;
      return data
          .map(
            (item) => OperatingCommandsGetSeasonsModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<OperatindCommandGetCentersModel>> getCenters() async {
    try {
      final response = await dio.get<List<dynamic>>(
        '$baseUrl/OperatingCommands/GetCenters',
      );
      final data = response.data!;
      return data
          .map(
            (item) => OperatindCommandGetCentersModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<GetAllOperatingsModel>> fetchOperatingList(
    String seasonId,
  ) async {
    final response = await dio.get<List<dynamic>>(
      '$baseUrl/OperatingCommands/GetAllHajTransportOperatings?SeasonId=$seasonId',
    );
    final data = response.data!;

    return data
        .map(
          (json) =>
              GetAllOperatingsModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  Future<void> addOperating(GetAllOperatingsModel model) async {
    final response = await dio.post<Map<String, dynamic>>(
      '$baseUrl/OperatingCommands/AddHajTransportOperating',
      data: [model.toJson()],
    );
    if (response.statusCode != 200) {
      throw Exception('فشل الإرسال: ${response.statusCode}');
    }
  }

  Future<void> editOperating(AddTransportOperatingModel model) async {
    final response = await dio.put<Map<String, dynamic>>(
      '$baseUrl/OperatingCommands/UpdateHajTransportOperating',
      data: [model.toJson()],
    );
    if (response.statusCode != 200) {
      throw Exception('فشل الإرسال: ${response.statusCode}');
    }
  }
}
