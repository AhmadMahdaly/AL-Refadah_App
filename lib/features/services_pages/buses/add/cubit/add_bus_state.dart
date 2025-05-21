import 'package:flutter/material.dart';
import 'package:alrefadah/features/services_pages/buses/add/models/add_bus_form_data.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_all_transports_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_center_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_operating_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_stage_model.dart';

class AddBusState {
  AddBusState({
    this.busForms = const [],
    this.centers = const [],
    this.selectedCenter,
    this.stages = const [],
    this.selectedStage,
    this.operations = const [],
    this.selectedOperation,
    this.transports = const [],
    this.formKeys = const [],
  });
  final List<BusesGetCenterModel> centers;
  final BusesGetCenterModel? selectedCenter;
  final List<BusesGetStageModel> stages;
  final BusesGetStageModel? selectedStage;
  final List<BusesGetOperatingModel> operations;
  final BusesGetOperatingModel? selectedOperation;
  final List<BusesGetAllTransportsModel> transports;
  final List<AddBusFormData> busForms;
  final List<GlobalKey<FormState>> formKeys;

  AddBusState copyWith({
    List<AddBusFormData>? busForms,
    List<BusesGetCenterModel>? centers,
    BusesGetCenterModel? selectedCenter,
    List<BusesGetStageModel>? stages,
    BusesGetStageModel? selectedStage,
    List<BusesGetOperatingModel>? operations,
    BusesGetOperatingModel? selectedOperation,
    List<BusesGetAllTransportsModel>? transports,
    BusesGetAllTransportsModel? selectedTransport,
    List<GlobalKey<FormState>>? formKeys,
  }) {
    return AddBusState(
      busForms: busForms ?? this.busForms,
      centers: centers ?? this.centers,
      selectedCenter: selectedCenter ?? this.selectedCenter,
      stages: stages ?? this.stages,
      selectedStage: selectedStage ?? this.selectedStage,
      operations: operations ?? this.operations,
      selectedOperation: selectedOperation ?? this.selectedOperation,
      transports: transports ?? this.transports,
      formKeys: formKeys ?? this.formKeys,
    );
  }
}

class AddBusLoadingState extends AddBusState {}

class AddBusErrorState extends AddBusState {}
