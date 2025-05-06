import 'package:alrefadah/features/services_pages/transport_stage/models/stage_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

/// base
class AppLoadingState extends AppStates {}

class AppSuccessState extends AppStates {}

class AppErrorState extends AppStates {
  AppErrorState(this.message);
  final String message;
}

///
class GetStagesLoaded extends AppStates {
  GetStagesLoaded(this.stages);
  final List<StageModel> stages;
}
