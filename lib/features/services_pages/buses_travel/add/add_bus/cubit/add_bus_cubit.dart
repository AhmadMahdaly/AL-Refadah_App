import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_all_transports_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/repo/buses_repo.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/add_bus/cubit/add_bus_state.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/add_bus/models/add_bus_form_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBusTripCubit extends Cubit<AddBusTripState> {
  AddBusTripCubit() : super(AddBusTripState());
  final BusesRepo repository = BusesRepo();
  int? selectedSeason;

  void addNewBusForm() {
    final updatedForms = List<AddBusFormTripData>.from(state.busForms)
      ..add(AddBusFormTripData());
    final updatedKeys = List<GlobalKey<FormState>>.from(state.formKeys)
      ..add(GlobalKey<FormState>());

    emit(state.copyWith(busForms: updatedForms, formKeys: updatedKeys));
  }

  /// Selects a stage and resets subsequent selections
  Future<void> selectOprating(String center) async {
    try {
      emit(
        state.copyWith(
          operations: [], // تصفير قائمة أوامر التشغيل
        ),
      );
      final operations = await repository.getTransportOperting(
        selectedSeason!,
        center,
      );
      emit(state.copyWith(operations: operations));
    } catch (e) {
      emit(AddBusErrorState());
    }
  }

  void selectOperation(String operation) {
    emit(state.copyWith(selectedOperation: operation));
  }

  void hideAddButton() {
    emit(state.copyWith(showAddButton: false));
  }

  void removeBusForm(int index) {
    final updatedForms = List<AddBusFormTripData>.from(state.busForms)
      ..removeAt(index);
    final updatedKeys = List<GlobalKey<FormState>>.from(state.formKeys)
      ..removeAt(index);
    emit(
      state.copyWith(
        busForms: updatedForms,
        formKeys: updatedKeys,
        showAddButton: true,
      ),
    );
  }

  Future<void> loadTransports() async {
    emit(AddBusLoadingState());
    try {
      final transports = await repository.getAllTransports();
      emit(state.copyWith(transports: transports));
    } catch (e) {
      emit(AddBusErrorState());
    }
  }

  void selectTransport(BusesGetAllTransportsModel transport) {
    emit(state.copyWith(selectedTransport: transport));
  }

  void reset() {
    emit(
      state.copyWith(
        transports: [],
        selectedOperation: null,
        operations: [],
        busForms: [],
      ),
    );
  }
}
