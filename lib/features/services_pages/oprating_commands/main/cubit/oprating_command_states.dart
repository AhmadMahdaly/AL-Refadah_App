import 'package:alrefadah/features/services_pages/oprating_commands/main/models/get_all_operatings_model.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/models/operating_command_get_centers_model.dart';
import 'package:alrefadah/features/services_pages/oprating_commands/main/models/operating_command_get_seasons_model.dart';

class OperatingCommandState {
  OperatingCommandState({
    this.isLoadingCenters = false,
    this.isLoadingSeasons = false,
    this.isLoadingTransportOprating = false,
    this.isLoadingAddOperating = false,
    this.isLoadingEditOperating = false,
    this.isSuccessAddTransportOperating = false,
    this.isSuccessEditTransportOperating = false,
    this.isLoadingDeleteOperating = false,
    this.isSuccessDeleteOperating = false,
    this.showDeleteErrorDialog = false,
    this.centers = const [],
    this.seasons = const [],
    this.operatingList = const [],
    this.error,
  });
  final bool showDeleteErrorDialog;
  final bool isLoadingCenters;
  final bool isLoadingSeasons;
  final bool isLoadingTransportOprating;
  final bool isLoadingAddOperating;
  final bool isLoadingEditOperating;
  final bool isSuccessAddTransportOperating;
  final bool isSuccessEditTransportOperating;
  final bool isLoadingDeleteOperating;
  final bool isSuccessDeleteOperating;
  final List<OperatindCommandGetCentersModel> centers;
  final List<OperatingCommandsGetSeasonsModel> seasons;
  final List<GetAllOperatingsModel> operatingList;
  final String? error;
  OperatingCommandState copyWith({
    bool? isLoadingCenters,
    bool? isLoadingSeasons,
    bool? isLoadingTransportOprating,
    bool? isLoadingAddOperating,
    bool? isLoadingEditOperating,
    bool? isSuccessAddTransportOperating,
    bool? isSuccessEditTransportOperating,
    bool? isLoadingDeleteOperating,
    bool? isSuccessDeleteOperating,
    bool? showDeleteErrorDialog,
    List<OperatindCommandGetCentersModel>? centers,
    List<OperatingCommandsGetSeasonsModel>? seasons,
    List<GetAllOperatingsModel>? operatingList,
    String? error,
  }) {
    return OperatingCommandState(
      isLoadingCenters: isLoadingCenters ?? this.isLoadingCenters,
      isLoadingSeasons: isLoadingSeasons ?? this.isLoadingSeasons,
      isLoadingTransportOprating:
          isLoadingTransportOprating ?? this.isLoadingTransportOprating,
      isLoadingAddOperating:
          isLoadingAddOperating ?? this.isLoadingAddOperating,
      isLoadingEditOperating:
          isLoadingEditOperating ?? this.isLoadingEditOperating,
      isSuccessAddTransportOperating:
          isSuccessAddTransportOperating ?? this.isSuccessAddTransportOperating,
      isSuccessEditTransportOperating:
          isSuccessEditTransportOperating ??
          this.isSuccessEditTransportOperating,
      centers: centers ?? this.centers,
      seasons: seasons ?? this.seasons,
      operatingList: operatingList ?? this.operatingList,
      error: error ?? this.error,
      isLoadingDeleteOperating:
          isLoadingDeleteOperating ?? this.isLoadingDeleteOperating,
      isSuccessDeleteOperating:
          isSuccessDeleteOperating ?? this.isSuccessDeleteOperating,
      showDeleteErrorDialog:
          showDeleteErrorDialog ?? this.showDeleteErrorDialog,
    );
  }
}
