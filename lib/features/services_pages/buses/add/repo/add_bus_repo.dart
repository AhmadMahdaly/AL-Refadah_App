import 'package:alrefadah/core/services/dio_helper.dart';
import 'package:alrefadah/features/services_pages/buses/add/models/add_bus_model.dart';
import 'package:dio/dio.dart';

class AddBusesRepo {
  Future<void> addBusesData(List<AddBusModel?> model) async {
    try {
      final response = await DioHelper.dio.post<Map<String, dynamic>>(
        '/Buses/AddHajTransportBus',
        data: model.map((e) => e!.toJson()).toList(),
      );
      final responseData = response.data;
      if (responseData == null) {
        throw Exception('الاستجابة من السيرفر فارغة');
      }
      final message = responseData['message']?.toString() ?? '';
      if (message.contains('An Error Occured') ||
          message.contains('Violation of PRIMARY KEY constraint')) {
        throw Exception('خطأ من السيرفر\n $message');
      }
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع: $e');
    }
  }
}
