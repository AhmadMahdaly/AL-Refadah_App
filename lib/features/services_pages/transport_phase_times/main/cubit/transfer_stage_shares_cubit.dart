import 'package:alrefadah/features/services_pages/transport_phase_times/add/models/transport_add_stage_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/cubit/transfer_stage_shares_states.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/repo/transfer_stage_shares_repo.dart';
import 'package:bloc/bloc.dart';

class TransferStageSharesCubit extends Cubit<TransferStageSharesState> {
  TransferStageSharesCubit(this.repository) : super(TransferStageSharesState());
  final TransferStageSharesRepo repository;
  String? selectedSeasonId;

  Future<void> getSeasons() async {
    emit(state.copyWith(isLoadingSeasons: true, error: null));
    try {
      final seasons = await repository.getSeasons();
      emit(
        state.copyWith(isLoadingSeasons: false, seasons: seasons, error: null),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingSeasons: false, error: 'حدث خطأ'));
    }
  }

  Future<void> getCenters() async {
    emit(state.copyWith(isLoadingCenters: true, error: null));
    try {
      final centers = await repository.getCenters();
      emit(
        state.copyWith(isLoadingCenters: false, centers: centers, error: null),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingCenters: false, error: 'حدث خطأ'));
    }
  }

  Future<void> getTransportStages() async {
    emit(state.copyWith(isLoadingTransportStages: true, error: null));
    try {
      final transport = await repository.getTransportStages();
      emit(
        state.copyWith(
          isLoadingTransportStages: false,
          transportStages: transport,
          error: null,
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
    emit(state.copyWith(isLoadingTransportStagesByCriteria: true, error: null));
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
          error: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingTransportStagesByCriteria: false,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> addTransportStage(List<AddTransportStageModel> inputs) async {
    emit(state.copyWith(isLoadingAddTransportStage: true, error: null));
    try {
      await repository.addTransportStage(inputs);
      emit(state.copyWith(isLoadingAddTransportStage: false, error: null));
    } catch (e) {
      emit(state.copyWith(isLoadingAddTransportStage: false, error: 'حدث خطأ'));
    }
  }

  Future<void> editTransportStage(List<AddTransportStageModel> inputs) async {
    emit(state.copyWith(isLoadingEditTransportStage: true, error: null));
    try {
      await repository.editTransportStage(inputs);
      emit(state.copyWith(isLoadingEditTransportStage: false, error: null));
    } catch (e) {
      emit(
        state.copyWith(isLoadingEditTransportStage: false, error: 'حدث خطأ'),
      );
    }
  }

  Future<void> deleteTransportStage(String stageNo, String centerNo) async {
    emit(
      state.copyWith(
        isLoadingDeleteTransportStage: true,
        isSuccessDeleteTransportStage: false,
        showDeleteErrorDialog: false,
        error: null,
      ),
    );
    try {
      final response = await repository.deleteTransportStage(
        stageNo,
        centerNo,
        selectedSeasonId!,
      );
      if (response!.contains('Max Deleted Successfully')) {
        emit(
          state.copyWith(
            isLoadingDeleteTransportStage: false,
            isSuccessDeleteTransportStage: true,
            showDeleteErrorDialog: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isLoadingDeleteTransportStage: false,
            showDeleteErrorDialog: true,
            isSuccessDeleteTransportStage: false,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingDeleteTransportStage: false,
          isSuccessDeleteTransportStage: false,
          error: e.toString(),
          showDeleteErrorDialog: true,
        ),
      );
    }
  }
}
