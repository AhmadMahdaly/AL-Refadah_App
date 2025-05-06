import 'package:alrefadah/data/base_api_url.dart';
import 'package:alrefadah/features/services_pages/guides/add/models/add_guide_model.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_centers_model.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_guide_model.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_seasons_model.dart';
import 'package:alrefadah/features/services_pages/guides/update/models/update_guide_model.dart';
import 'package:dio/dio.dart';

class GuidesRepo {
  final Dio dio = Dio();
  Future<List<GetGuidesSeasonsModel>> getSeasons() async {
    try {
      final response = await dio.get<List<dynamic>>(
        '$baseUrl/Guides/GetSeasons',
      );
      final data = response.data!;
      return data
          .map(
            (item) =>
                GetGuidesSeasonsModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<GetGuidesCenterModel>> getCenters() async {
    try {
      final response = await dio.get<List<dynamic>>(
        '$baseUrl/Guides/GetCenters',
      );
      final data = response.data!;
      return data
          .map(
            (item) =>
                GetGuidesCenterModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('خطأ: ${e.response?.data}');
    }
  }

  Future<List<GetGuidesModel>> fetchGuides() async {
    final response = await dio.get<List<dynamic>>(
      '$baseUrl/Guides/GetEmployees',
    );
    final data = response.data!;

    return data
        .map((json) => GetGuidesModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> addHajTransGuide(List<AddGuideModel> model) async {
    final headers = {'Content-Type': 'application/json', 'Accept': '*/*'};
    final response = await dio.post<Map<String, dynamic>>(
      '$baseUrl/Guides/AddHajTransportGuide',
      data: model.map((e) => e.toJson()).toList(),
      options: Options(headers: headers),
    );
    if (response.statusCode == 200) {
      await getSeasons();
    } else {
      throw Exception('فشل الإرسال: ${response.statusCode}');
    }
  }

  Future<void> updateHajTransGuide(UpateGuideModel model) async {
    final headers = {'Content-Type': 'application/json', 'Accept': '*/*'};
    final response = await dio.put<Map<String, dynamic>>(
      '$baseUrl/Guides/UpdateHajTransportGuide',
      data: [model.toJson()],
      options: Options(headers: headers),
    );
    if (response.statusCode != 200) {
      throw Exception('فشل الإرسال: ${response.statusCode}');
    }
  }

  Future<List<GetGuidesModel>> getGuideByCriteria(
    String selectedSeasonId,
    String selectedCenterId,
  ) async {
    final response = await dio.get<List<dynamic>>(
      '$baseUrl/Guides/GetHajTransportGuideByCriteria/by-criteria?seasonId=$selectedSeasonId&centerNo=$selectedCenterId',
    );
    final data = response.data!;

    return data
        .map((json) => GetGuidesModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
