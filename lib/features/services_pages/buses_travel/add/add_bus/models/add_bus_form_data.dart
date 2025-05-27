import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_all_transports_model.dart';
import 'package:flutter/material.dart';

class AddBusFormTripData {
  final TextEditingController _busNoController = TextEditingController();
  // final TextEditingController _pilgrimsQtyController = TextEditingController();
  final TextEditingController _tripsQtyController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController get busNoController => _busNoController;
  // TextEditingController get pilgrimsQtyController => _pilgrimsQtyController;
  TextEditingController get tripsQtyController => _tripsQtyController;
  TextEditingController get notesController => _notesController;
  GlobalKey<FormState> get formKey => _formKey;
  void dispose() {
    _busNoController.dispose();
    // _pilgrimsQtyController.dispose();
    _tripsQtyController.dispose();
    _notesController.dispose();
  }

  BusesGetAllTransportsModel? selectedTransport;
  // String? pilgrimsCount;
  String? tripsCount;
  String note = '';
}
