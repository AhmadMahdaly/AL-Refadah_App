import 'dart:developer';

import 'package:alrefadah/features/services_pages/buses/add/models/add_bus_model.dart';
import 'package:alrefadah/features/services_pages/buses/add/repo/add_bus_repo.dart';
import 'package:alrefadah/features/services_pages/buses/edit/models/edit_bus_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/cubit/buses_states.dart';
import 'package:alrefadah/features/services_pages/buses/main/repo/buses_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusesCubit extends Cubit<BusesState> {
  BusesCubit(this.repository) : super(BusesState());
  final BusesRepo repository;
  int? selectedSeason;
  String? selectedCenter;
  String? selectedStage;
  Future<void> getSeasons() async {
    emit(state.copyWith(isLoadingSeasons: true));
    try {
      final seasons = await repository.getSeasons();
      emit(state.copyWith(isLoadingSeasons: false, seasons: seasons));
    } catch (e) {
      emit(state.copyWith(isLoadingSeasons: false, error: e.toString()));
    }
  }

  Future<void> getCenters() async {
    emit(state.copyWith(isLoadingCenters: true));
    try {
      final centers = await repository.getCenters();
      emit(state.copyWith(isLoadingCenters: false, centers: centers));
    } catch (e) {
      emit(state.copyWith(isLoadingCenters: false, error: e.toString()));
    }
  }

  void selectCenter(String newCenter) {
    emit(state.copyWith(selectedCenter: newCenter));
  }

  Future<void> getStages() async {
    emit(state.copyWith(isLoadingStages: true));
    try {
      final stages = await repository.getStages();
      emit(state.copyWith(isLoadingStages: false, stages: stages));
    } catch (e) {
      emit(state.copyWith(isLoadingStages: false, error: e.toString()));
    }
  }

  Future<void> getTransportOperating(String selectedCenter) async {
    emit(state.copyWith(isLoadingTransportOperating: true));
    try {
      final transportOperating = await repository.getTransportOperting(
        selectedSeason!,
        selectedCenter,
      );
      emit(
        state.copyWith(
          isLoadingTransportOperating: false,
          transportOperating: transportOperating,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(isLoadingTransportOperating: false, error: e.toString()),
      );
    }
  }

  Future<void> getAllBuses() async {
    emit(state.copyWith(isLoadingAllBuses: true));
    try {
      final allBuses = await repository.getAllBuses(selectedSeason!);
      emit(state.copyWith(isLoadingAllBuses: false, allBuses: allBuses));
    } catch (e) {
      emit(state.copyWith(isLoadingAllBuses: false, error: e.toString()));
    }
  }

  Future<void> getAllTransports() async {
    emit(state.copyWith(isLoadingAllTransports: true));
    try {
      final allTransports = await repository.getAllTransports();
      emit(
        state.copyWith(
          isLoadingAllTransports: false,
          alltransports: allTransports,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingAllTransports: false, error: e.toString()));
    }
  }

  Future<void> editTransportBus(List<EditBusModel> inputs) async {
    emit(state.copyWith(isLoadingEditTransportBus: true, isEditDone: false));
    try {
      await repository.editTransportBus(inputs);
      emit(state.copyWith(isLoadingEditTransportBus: false, isEditDone: true));
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingEditTransportBus: false,
          isEditDone: false,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> addBus(List<AddBusModel?> model) async {
    emit(state.copyWith(isLoadingAddBus: true, isSuccessAddBus: false));
    try {
      final response = await AddBusesRepo().addBusesData(model);
      if (response.toString().contains('Data inserted Successfully')) {
        emit(state.copyWith(isLoadingAddBus: false, isSuccessAddBus: true));
      } else if (response.toString().contains('An Error Occured ')) {
        emit(
          state.copyWith(
            isLoadingAddBus: false,
            error: 'خطأ',
            isSuccessAddBus: false,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingAddBus: false,
          error: e.toString(),
          isSuccessAddBus: false,
        ),
      );
    }
  }

  Future<void> deleteBus(
    int centerNo,
    int stageNo,
    String busNo,
    int busId,
  ) async {
    emit(
      state.copyWith(
        isLoadingDeleteBus: true,
        isDeletedBus: false,
        showDeleteErrorDialog: false,
      ),
    );
    try {
      final data = await repository.deleteBus(
        selectedSeason ?? 0,
        centerNo,
        stageNo,
        busNo,
        busId,
      );
      if (data.data!.contains('Bus Deleted Successfully')) {
        emit(
          state.copyWith(
            isLoadingDeleteBus: false,
            isDeletedBus: true,
            showDeleteErrorDialog: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isLoadingDeleteBus: false,
            showDeleteErrorDialog: true,
            isDeletedBus: false,
          ),
        );
      }
    } catch (e) {
      log('Delete failed: $e');
      emit(
        state.copyWith(
          isLoadingDeleteBus: false,
          showDeleteErrorDialog: true,
          isDeletedBus: false,
        ),
      );
    }
  }

  Future<void> getAllBusesByCrietia(String centerNo) async {
    emit(state.copyWith(isLoadingAllBusesByCrietia: true));
    try {
      if (centerNo != null && selectedSeason != null) {
        final allBuses = await repository.getAllBusesByCriatia(
          selectedSeason!,
          centerNo,
        );
        emit(
          state.copyWith(
            isLoadingAllBusesByCrietia: false,
            allBusesByCrietia: allBuses,
          ),
        );
      }
      emit(state.copyWith(isLoadingAllBusesByCrietia: false, error: 'حدث خطأ'));
    } catch (e) {
      emit(
        state.copyWith(isLoadingAllBusesByCrietia: false, error: e.toString()),
      );
    }
  }
}
