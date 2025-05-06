import 'package:alrefadah/data/base_api_url.dart';
import 'package:alrefadah/features/services_pages/buses/edit/models/edit_bus_model.dart';
import 'package:dio/dio.dart';

final Dio dio = Dio();

class EditBusRepo {
  Future<void> editBus(EditBusModel bus) async {
    final headers = {'Content-Type': 'application/json', 'Accept': '*/*'};
    final response = await dio.put<Map<String, dynamic>>(
      '$baseUrl/Buses/UpdateHajTransportBus',
      data: [bus.toJson()],

      options: Options(headers: headers),
    );
    if (response.statusCode != 200) {
      throw Exception('فشل تحديث البيانات');
    }
  }
}
