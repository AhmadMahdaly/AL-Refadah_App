import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_all_transports_model.dart';
import 'package:flutter/material.dart';

class AddBusFormData {
  final TextEditingController _busNoController = TextEditingController();
  final TextEditingController _pilgrimsQtyController = TextEditingController();
  final TextEditingController _tripsQtyController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  TextEditingController get busNoController => _busNoController;
  TextEditingController get pilgrimsQtyController => _pilgrimsQtyController;
  TextEditingController get tripsQtyController => _tripsQtyController;
  TextEditingController get notesController => _notesController;

  void dispose() {
    _busNoController.dispose();
    _pilgrimsQtyController.dispose();
    _tripsQtyController.dispose();
    _notesController.dispose();
  }

  BusesGetAllTransportsModel? selectedTransport;
  String pilgrimsCount = '';
  String tripsCount = '';
  String note = '';
}
