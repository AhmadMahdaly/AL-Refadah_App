import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_get_centers_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_get_session_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_get_stages_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transport_get_by_criteria_model.dart';

class TransferStageSharesState {
  TransferStageSharesState({
    this.isLoadingCenters = false,
    this.isLoadingSeasons = false,
    this.isLoadingTransportStages = false,
    this.isLoadingTransportStagesByCriteria = false,
    this.isLoadingAddTransportStage = false,
    this.isLoadingEditTransportStage = false,
    this.centers = const [],
    this.seasons = const [],
    this.transportStages = const [],
    this.transportStagesByCriteria = const [],
    this.error,
  });
  final bool isLoadingCenters;
  final bool isLoadingSeasons;
  final bool isLoadingTransportStages;
  final bool isLoadingTransportStagesByCriteria;
  final bool isLoadingAddTransportStage;
  final bool isLoadingEditTransportStage;

  final List<TransferStageSharesGetCenterModel> centers;
  final List<TranferStageSharesGetSeasonsModel> seasons;
  final List<TransferStageSharesGetStageModel> transportStages;
  final List<TransferStageSharesGetByCriteriaModel> transportStagesByCriteria;

  final String? error;

  TransferStageSharesState copyWith({
    bool? isLoadingCenters,
    bool? isLoadingSeasons,
    bool? isLoadingTransportStages,
    bool? isLoadingTransportStagesByCriteria,
    bool? isLoadingAddTransportStage,
    bool? isLoadingEditTransportStage,
    List<TransferStageSharesGetCenterModel>? centers,
    List<TranferStageSharesGetSeasonsModel>? seasons,
    List<TransferStageSharesGetStageModel>? transportStages,
    List<TransferStageSharesGetByCriteriaModel>? transportStagesByCriteria,
    String? error,
  }) {
    return TransferStageSharesState(
      isLoadingCenters: isLoadingCenters ?? this.isLoadingCenters,
      isLoadingSeasons: isLoadingSeasons ?? this.isLoadingSeasons,
      isLoadingTransportStages:
          isLoadingTransportStages ?? this.isLoadingTransportStages,
      isLoadingTransportStagesByCriteria:
          isLoadingTransportStagesByCriteria ??
          this.isLoadingTransportStagesByCriteria,
      isLoadingAddTransportStage:
          isLoadingAddTransportStage ?? this.isLoadingAddTransportStage,
      isLoadingEditTransportStage:
          isLoadingEditTransportStage ?? this.isLoadingEditTransportStage,
      centers: centers ?? this.centers,
      seasons: seasons ?? this.seasons,
      transportStages: transportStages ?? this.transportStages,
      transportStagesByCriteria:
          transportStagesByCriteria ?? this.transportStagesByCriteria,
      error: error ?? this.error,
    );
  }
}
