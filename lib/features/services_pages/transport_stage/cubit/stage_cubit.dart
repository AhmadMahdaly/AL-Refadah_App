import 'package:alrefadah/core/manager/app_states.dart';
import 'package:alrefadah/features/services_pages/transport_stage/models/stage_model.dart';
import 'package:alrefadah/features/services_pages/transport_stage/repo/stage_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StageCubit extends Cubit<AppStates> {
  StageCubit(this.repository) : super(AppInitialState());
  final StageRepo repository;

  Future<void> getStages() async {
    emit(AppLoadingState());
    try {
      final stage = await repository.getStages();
      emit(GetStagesLoaded(stage));
    } catch (e) {
      emit(
        AppErrorState('Failed to fetch transport phase times: get stages\n$e'),
      );
    }
  }

  Future<void> updateStage(List<StageModel> inputs) async {
    emit(AppLoadingState());
    try {
      await repository.updateStages(inputs);
      emit(AppSuccessState());
    } catch (e) {
      emit(
        AppErrorState('Failed to fetch transport phase times: get stages\n$e'),
      );
    }
  }
}
