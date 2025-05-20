import 'package:alrefadah/core/services/dio_helper.dart';
import 'package:alrefadah/features/services_pages/buses/edit/models/edit_bus_model.dart';

class EditBusRepo {
  Future<void> editBus(EditBusModel bus) async {
    final response = await DioHelper.dio.put<Map<String, dynamic>>(
      '/Buses/UpdateHajTransportBus',
      data: [bus.toJson()],
    );
    if (response.statusCode != 200) {
      throw Exception('فشل تحديث البيانات');
    }
  }
}
