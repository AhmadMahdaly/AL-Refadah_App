import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_all_transports_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_operating_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/add_bus/models/add_bus_form_data.dart';
import 'package:flutter/material.dart';

class AddBusTripState {
  AddBusTripState({
    this.busForms = const [],
    this.operations = const [],
    this.selectedOperation,
    this.transports = const [],
    this.formKeys = const [],
    this.showAddButton = true,
  });

  final List<BusesGetOperatingModel> operations;
  String? selectedOperation;
  final List<BusesGetAllTransportsModel> transports;
  final List<AddBusFormTripData> busForms;
  final List<GlobalKey<FormState>> formKeys;
  final bool showAddButton;
  AddBusTripState copyWith({
    List<AddBusFormTripData>? busForms,
    List<BusesGetOperatingModel>? operations,
    String? selectedOperation,
    List<BusesGetAllTransportsModel>? transports,
    BusesGetAllTransportsModel? selectedTransport,
    List<GlobalKey<FormState>>? formKeys,
    bool? showAddButton,
  }) {
    return AddBusTripState(
      busForms: busForms ?? this.busForms,

      operations: operations ?? this.operations,
      selectedOperation: selectedOperation ?? this.selectedOperation,
      transports: transports ?? this.transports,
      formKeys: formKeys ?? this.formKeys,
      showAddButton: showAddButton ?? this.showAddButton,
    );
  }
}

class AddBusLoadingState extends AddBusTripState {}

class AddBusErrorState extends AddBusTripState {}
