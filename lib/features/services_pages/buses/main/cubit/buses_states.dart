import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_all_transports_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_center_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_operating_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_season_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/buses_get_stage_model.dart';
import 'package:alrefadah/features/services_pages/buses/main/models/get_all_buses_model.dart';

class BusesState {
  BusesState({
    this.isLoadingCenters = false,
    this.isLoadingSeasons = false,
    this.isLoadingStages = false,
    this.isLoadingTransportOperating = false,
    this.isLoadingAllTransports = false,
    this.isLoadingAddTransportBus = false,
    this.isLoadingEditTransportBus = false,
    this.isLoadingAllBuses = false,
    this.isLoadingAddBus = false,
    this.isSuccessAddBus = false,
    this.isLoadingDeleteBus = false,
    this.isDeletedBus = false,
    this.centers = const [],
    this.seasons = const [],
    this.stages = const [],
    this.transportOperating = const [],
    this.alltransports = const [],
    this.allBuses = const [],
    this.error,
    this.showDeleteErrorDialog = false,
    this.selectedCenter,
    this.isLoadingAllBusesByCrietia = false,
    this.allBusesByCrietia = const [],
    this.isEditDone = false,
  });
  final bool isLoadingCenters;
  final bool isLoadingSeasons;
  final bool isLoadingStages;
  final bool isLoadingTransportOperating;
  final bool isLoadingAllTransports;
  final bool isLoadingAddTransportBus;
  final bool isLoadingEditTransportBus;
  final bool isLoadingAllBuses;
  final bool isLoadingAddBus;
  final bool isSuccessAddBus;
  final bool isLoadingDeleteBus;
  final bool isDeletedBus;
  final bool isLoadingAllBusesByCrietia;
  final List<BusesGetCenterModel> centers;
  final List<BusesGetSeasonModel> seasons;
  final List<BusesGetStageModel> stages;
  final List<BusesGetOperatingModel> transportOperating;
  final List<BusesGetAllTransportsModel> alltransports;
  final List<GetAllBusesModel> allBuses;
  final bool showDeleteErrorDialog;
  final String? selectedCenter;
  final List<GetAllBusesModel> allBusesByCrietia;
  final String? error;
  final bool isEditDone;
  BusesState copyWith({
    bool? isLoadingCenters,
    bool? isLoadingSeasons,
    bool? isLoadingStages,
    bool? isLoadingTransportOperating,
    bool? isLoadingAllTransports,
    bool? isLoadingAddTransportBus,
    bool? isLoadingEditTransportBus,
    bool? isLoadingAllBuses,
    bool? isLoadingAddBus,
    bool? isSuccessAddBus,
    bool? isLoadingDeleteBus,
    bool? isDeletedBus,
    List<BusesGetCenterModel>? centers,
    List<BusesGetSeasonModel>? seasons,
    List<BusesGetStageModel>? stages,
    List<BusesGetOperatingModel>? transportOperating,
    List<BusesGetAllTransportsModel>? alltransports,
    List<GetAllBusesModel>? allBuses,
    String? error,
    bool? showDeleteErrorDialog,
    String? selectedCenter,
    bool? isLoadingAllBusesByCrietia,
    List<GetAllBusesModel>? allBusesByCrietia,
    bool? isEditDone,
  }) {
    return BusesState(
      isLoadingCenters: isLoadingCenters ?? this.isLoadingCenters,
      isLoadingSeasons: isLoadingSeasons ?? this.isLoadingSeasons,
      isLoadingStages: isLoadingStages ?? this.isLoadingStages,
      isLoadingTransportOperating:
          isLoadingTransportOperating ?? this.isLoadingTransportOperating,
      isLoadingAddTransportBus:
          isLoadingAddTransportBus ?? this.isLoadingAddTransportBus,
      isLoadingEditTransportBus:
          isLoadingEditTransportBus ?? this.isLoadingEditTransportBus,
      isLoadingAllBuses: isLoadingAllBuses ?? this.isLoadingAllBuses,
      isLoadingAllTransports:
          isLoadingAllTransports ?? this.isLoadingAllTransports,
      centers: centers ?? this.centers,
      seasons: seasons ?? this.seasons,
      stages: stages ?? this.stages,
      transportOperating: transportOperating ?? this.transportOperating,
      alltransports: alltransports ?? this.alltransports,
      allBuses: allBuses ?? this.allBuses,
      error: error ?? this.error,
      isLoadingAddBus: isLoadingAddBus ?? this.isLoadingAddBus,
      isSuccessAddBus: isSuccessAddBus ?? this.isSuccessAddBus,
      isLoadingDeleteBus: isLoadingDeleteBus ?? this.isLoadingDeleteBus,
      isDeletedBus: isDeletedBus ?? this.isDeletedBus,
      showDeleteErrorDialog:
          showDeleteErrorDialog ?? this.showDeleteErrorDialog,
      selectedCenter: selectedCenter ?? this.selectedCenter,
      isLoadingAllBusesByCrietia:
          isLoadingAllBusesByCrietia ?? this.isLoadingAllBusesByCrietia,
      allBusesByCrietia: allBusesByCrietia ?? this.allBusesByCrietia,
      isEditDone: isEditDone ?? this.isEditDone,
    );
  }
}
