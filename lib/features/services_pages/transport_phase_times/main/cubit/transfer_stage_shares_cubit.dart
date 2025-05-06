import 'package:alrefadah/features/services_pages/transport_phase_times/add/models/transport_add_stage_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/cubit/transfer_stage_shares_states.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/repo/transfer_stage_shares_repo.dart';
import 'package:bloc/bloc.dart';

class TransferStageSharesCubit extends Cubit<TransferStageSharesState> {
  TransferStageSharesCubit(this.repository) : super(TransferStageSharesState());
  final TransferStageSharesRepo repository;
  String? selectedSeasonId;

  Future<void> getSeasons() async {
    emit(state.copyWith(isLoadingSeasons: true));
    try {
      final seasons = await repository.getSeasons();
      emit(state.copyWith(isLoadingSeasons: false, seasons: seasons));
    } catch (e) {
      emit(state.copyWith(isLoadingSeasons: false, error: 'حدث خطأ'));
    }
  }

  Future<void> getCenters() async {
    emit(state.copyWith(isLoadingCenters: true));
    try {
      final centers = await repository.getCenters();
      emit(state.copyWith(isLoadingCenters: false, centers: centers));
    } catch (e) {
      emit(state.copyWith(isLoadingCenters: false, error: 'حدث خطأ'));
    }
  }

  Future<void> getTransportStages() async {
    emit(state.copyWith(isLoadingTransportStages: true));
    try {
      final stages = await repository.getTransportStages();
      emit(
        state.copyWith(
          isLoadingTransportStages: false,
          transportStages: stages,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingTransportStages: false, error: 'حدث خطأ'));
    }
  }

  Future<void> getTransportStageByCriteria(
    String selectedSeasonId,
    String selectedCenterId,
  ) async {
    emit(state.copyWith(isLoadingTransportStagesByCriteria: true));
    try {
      if (selectedCenterId == null || selectedSeasonId == null) {
        emit(
          state.copyWith(
            isLoadingTransportStagesByCriteria: false,
            error: 'حدث خطأ',
          ),
        );
      }
      final stages = await repository.getTransportStageByCriteria(
        selectedSeasonId,
        selectedCenterId,
      );
      emit(
        state.copyWith(
          isLoadingTransportStagesByCriteria: false,
          transportStagesByCriteria: stages,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingTransportStagesByCriteria: false,
          error: 'حدث خطأ',
        ),
      );
    }
  }

  Future<void> addTransportStage(List<AddTransportStageModel> inputs) async {
    emit(state.copyWith(isLoadingAddTransportStage: true));
    try {
      await repository.addTransportStage(inputs);
      emit(state.copyWith(isLoadingAddTransportStage: false));
    } catch (e) {
      emit(state.copyWith(isLoadingAddTransportStage: false, error: 'حدث خطأ'));
    }
  }

  Future<void> editTransportStage(List<AddTransportStageModel> inputs) async {
    emit(state.copyWith(isLoadingEditTransportStage: true));
    try {
      await repository.editTransportStage(inputs);
      emit(state.copyWith(isLoadingEditTransportStage: false));
    } catch (e) {
      emit(
        state.copyWith(isLoadingEditTransportStage: false, error: 'حدث خطأ'),
      );
    }
  }
}
