import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alrefadah/features/services_pages/transport_stage/cubit/stage_states.dart';
import 'package:alrefadah/features/services_pages/transport_stage/models/stage_model.dart';
import 'package:alrefadah/features/services_pages/transport_stage/repo/stage_repo.dart';

class StageCubit extends Cubit<StageStates> {
  StageCubit(this.repository) : super(StagesInitialState());
  final StageRepo repository;

  Future<void> getStages() async {
    emit(StagesLoadingState());
    try {
      final stage = await repository.getStages();
      emit(GetStagesLoaded(stage));
    } catch (e) {
      emit(
        StagesErrorState(
          'Failed to fetch transport phase times: get stages\n$e',
        ),
      );
    }
  }

  Future<void> updateStage(List<StageModel> inputs) async {
    emit(StagesLoadingState());
    try {
      await repository.updateStages(inputs);
      emit(StagesSuccessState());
    } catch (e) {
      emit(
        StagesErrorState(
          'Failed to fetch transport phase times: get stages\n$e',
        ),
      );
    }
  }
}
