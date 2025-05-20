import 'package:alrefadah/features/services_pages/transport_stage/models/stage_model.dart';

abstract class StageStates {}

class StagesInitialState extends StageStates {}

/// base
class StagesLoadingState extends StageStates {}

class StagesSuccessState extends StageStates {}

class StagesErrorState extends StageStates {
  StagesErrorState(this.message);
  final String message;
}

///
class GetStagesLoaded extends StageStates {
  GetStagesLoaded(this.stages);
  final List<StageModel> stages;
}
