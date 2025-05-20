import 'package:alrefadah/features/services_pages/buses/add/cubit/add_bus_state.dart';
import 'package:alrefadah/features/services_pages/buses/add/models/add_bus_form_data.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_all_transports_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_center_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_operating_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_stage_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/repo/buses_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBusCubit extends Cubit<AddBusState> {
  AddBusCubit(this.repository) : super(AddBusState());
  final BusesRepo repository;
  int? selectedSeason;

  /// Loads the list of centers from the repository
  Future<void> loadCenters() async {
    emit(AddBusLoadingState());
    try {
      final centers = await repository.getCenters();
      emit(state.copyWith(centers: centers));
    } catch (e) {
      emit(AddBusErrorState());
    }
  }

  /// Selects a center and loads its related stages and operations
  Future<void> selectCenter(BusesGetCenterModel center) async {
    try {
      // أولاً: تصفير الاختيارات اللاحقة
      emit(
        state.copyWith(
          selectedCenter: center,
          selectedStage: null,
          selectedOperation: null,
          stages: [],
          operations: [],
        ),
      ); // ثانياً: تحميل البيانات المرتبطة بالمركز
      final stages = await repository.getStages();
      final operations = await repository.getTransportOperting(
        selectedSeason!,
        center.fCenterNo.toString(),
      );
      // تحديث الحالة بالبيانات الجديدة
      emit(state.copyWith(stages: stages, operations: operations));
    } catch (e) {
      emit(AddBusErrorState());
    }
  }

  /// Adds a new bus form to the list
  void addNewBusForm() {
    final updatedForms = List<AddBusFormData>.from(state.busForms)
      ..add(AddBusFormData());
    emit(state.copyWith(busForms: updatedForms));
  }

  /// Selects a stage and resets subsequent selections
  Future<void> selectStage(
    BusesGetStageModel stage,
    BusesGetCenterModel center,
  ) async {
    try {
      emit(
        state.copyWith(
          selectedCenter: center,
          selectedStage: stage,
          selectedOperation: null, // تصفير أمر التشغيل
          operations: [], // تصفير قائمة أوامر التشغيل
        ),
      );

      final operations = await repository.getTransportOperting(
        selectedSeason!,
        center.fCenterNo.toString(),
      );
      emit(state.copyWith(operations: operations));
    } catch (e) {
      emit(AddBusErrorState());
    }
  }

  void removeBusForm(int index) {
    final updatedForms = List<AddBusFormData>.from(state.busForms)
      ..removeAt(index);
    emit(state.copyWith(busForms: updatedForms));
  }

  void selectOperation(BusesGetOperatingModel operation) {
    emit(state.copyWith(busForms: [], selectedOperation: operation));
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
        centers: [],
        transports: [],
        selectedCenter: null,
        selectedStage: null,
        selectedOperation: null,
        stages: [],
        operations: [],
        busForms: [],
      ),
    );
  }
}
