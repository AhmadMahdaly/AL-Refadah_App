import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_stage_get_centers_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_stage_get_session_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_stage_get_stages_model.dart';
import 'package:alrefadah/features/services_pages/transport_phase_times/main/models/transfer_stage_get_transport_by_criteria_model.dart';

class TransferStageSharesState {
  TransferStageSharesState({
    /// Loading
    this.isLoadingCenters = false,
    this.isLoadingSeasons = false,
    this.isLoadingTransportStages = false,
    this.isLoadingTransportStagesByCriteria = false,
    this.isLoadingAddTransportStage = false,
    this.isLoadingEditTransportStage = false,
    this.isLoadingDeleteTransportStage = false,

    /// Success
    this.isSuccessDeleteTransportStage = false,
    this.showDeleteErrorDialog = false,

    /// Data
    this.centers = const [],
    this.seasons = const [],
    this.transportStages = const [],
    this.transportStagesByCriteria = const [],

    /// Error
    this.error,
  });

  /// Loading
  final bool isLoadingCenters;
  final bool isLoadingSeasons;
  final bool isLoadingTransportStages;
  final bool isLoadingTransportStagesByCriteria;
  final bool isLoadingAddTransportStage;
  final bool isLoadingEditTransportStage;
  final bool isLoadingDeleteTransportStage;

  /// Success
  final bool isSuccessDeleteTransportStage;
  final bool showDeleteErrorDialog;

  /// Data
  final List<TransferStageGetCenterModel> centers;
  final List<TranferStageGetSeasonsModel> seasons;
  final List<TransferStageGetStageModel> transportStages;
  final List<TransferStageGetTransportByCriteriaModel>
  transportStagesByCriteria;

  /// Error
  final String? error;

  TransferStageSharesState copyWith({
    /// Loading
    bool? isLoadingCenters,
    bool? isLoadingSeasons,
    bool? isLoadingTransportStages,
    bool? isLoadingTransportStagesByCriteria,
    bool? isLoadingAddTransportStage,
    bool? isLoadingEditTransportStage,
    bool? isLoadingDeleteTransportStage,

    /// Success
    bool? isSuccessDeleteTransportStage,
    bool? showDeleteErrorDialog,

    /// Data
    List<TransferStageGetCenterModel>? centers,
    List<TranferStageGetSeasonsModel>? seasons,
    List<TransferStageGetStageModel>? transportStages,
    List<TransferStageGetTransportByCriteriaModel>? transportStagesByCriteria,

    /// Error
    String? error,
  }) {
    return TransferStageSharesState(
      /// Loading
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
      isLoadingDeleteTransportStage:
          isLoadingDeleteTransportStage ?? this.isLoadingDeleteTransportStage,

      /// Success
      isSuccessDeleteTransportStage:
          isSuccessDeleteTransportStage ?? this.isSuccessDeleteTransportStage,
      showDeleteErrorDialog:
          showDeleteErrorDialog ?? this.showDeleteErrorDialog,

      /// Data
      centers: centers ?? this.centers,
      seasons: seasons ?? this.seasons,
      transportStages: transportStages ?? this.transportStages,
      transportStagesByCriteria:
          transportStagesByCriteria ?? this.transportStagesByCriteria,

      /// Error
      error: error ?? this.error,
    );
  }
}
