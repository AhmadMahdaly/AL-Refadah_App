import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_all_transports_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_center_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_operating_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_stage_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/add_bus/models/add_bus_form_data.dart';
import 'package:flutter/material.dart';

class AddBusTripState {
  AddBusTripState({
    this.busForms = const [],
    this.centers = const [],
    this.selectedCenter,
    this.stages = const [],
    this.selectedStage,
    this.operations = const [],
    this.selectedOperation,
    this.transports = const [],
    this.formKeys = const [],
    this.showAddButton = true,
  });
  final List<BusesGetCenterModel> centers;
  final BusesGetCenterModel? selectedCenter;
  final List<BusesGetStageModel> stages;
  final BusesGetStageModel? selectedStage;
  final List<BusesGetOperatingModel> operations;
  BusesGetOperatingModel? selectedOperation;
  final List<BusesGetAllTransportsModel> transports;
  final List<AddBusFormTripData> busForms;
  final List<GlobalKey<FormState>> formKeys;
  final bool showAddButton;
  AddBusTripState copyWith({
    List<AddBusFormTripData>? busForms,
    List<BusesGetCenterModel>? centers,
    BusesGetCenterModel? selectedCenter,
    List<BusesGetStageModel>? stages,
    BusesGetStageModel? selectedStage,
    List<BusesGetOperatingModel>? operations,
    BusesGetOperatingModel? selectedOperation,
    List<BusesGetAllTransportsModel>? transports,
    BusesGetAllTransportsModel? selectedTransport,
    List<GlobalKey<FormState>>? formKeys,
    bool? showAddButton,
  }) {
    return AddBusTripState(
      busForms: busForms ?? this.busForms,
      centers: centers ?? this.centers,
      selectedCenter: selectedCenter ?? this.selectedCenter,
      stages: stages ?? this.stages,
      selectedStage: selectedStage ?? this.selectedStage,
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
