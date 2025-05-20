import 'package:alrefadah/core/services/dio_helper.dart';
import 'package:alrefadah/data/constants_variable.dart';
import 'package:alrefadah/features/services_pages/guides/add/models/add_guide_model.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/by_criteria/assignment_model.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_centers_model.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_guide_model.dart';
import 'package:alrefadah/features/services_pages/guides/main/models/get_seasons_model.dart';
import 'package:alrefadah/features/services_pages/guides/update/models/update_guide_model.dart';
import 'package:dio/dio.dart';

class GuidesRepo {
  Future<List<GetGuidesSeasonsModel>> getSeasons() async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/Guides/GetSeasons',
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
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/Guides/GetCenters',
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
    final response = await DioHelper.dio.get<List<dynamic>>(
      '/Guides/GetEmployees',
    );
    final data = response.data!;

    return data
        .map((json) => GetGuidesModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> addHajTransGuide(List<AddGuideModel> model) async {
    final headers = {'Content-Type': 'application/json', 'Accept': '*/*'};
    final response = await DioHelper.dio.post<Map<String, dynamic>>(
      '/Guides/AddHajTransportGuide',
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
    final response = await DioHelper.dio.put<Map<String, dynamic>>(
      '/Guides/UpdateHajTransportGuide',
      data: [model.toJson()],
      options: Options(headers: headers),
    );
    if (response.statusCode != 200) {
      throw Exception('فشل الإرسال: ${response.statusCode}');
    }
  }

  Future<List<AssignmentModel>> getGuideByCriteria(
    String selectedSeasonId,
    String selectedCenterId,
  ) async {
    try {
      final response = await DioHelper.dio.get<List<dynamic>>(
        '/Guides/GetHajTransportGuideByCriteria/by-criteria?seasonId=$selectedSeasonId&centerNo=$selectedCenterId',
      );

      final data = response.data!;
      return data
          .map((json) => AssignmentModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('لم يتم العثور على مرشدين لهذا المركز');
      } else {
        throw Exception('خطأ في الاتصال بالسيرفر');
      }
    }
  }

  Future<void> deleteGuideByCriteria(
    String selectedSeasonId,
    String selectedCenterId,
    String empNo,
  ) async {
    try {
      await DioHelper.dio.delete<String>(
        '/Guides/DeleteHajTransportGuide?EmpNo=$empNo&centerNo=$selectedCenterId&companyId=$companyId&SeasonId=$selectedSeasonId',
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('لم يتم حذف المرشد لوجود خطأ');
      }
    }
  }
}
