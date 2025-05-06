import 'package:alrefadah/features/services_pages/buses_travel/add/models/bus_travel_trip_model_by_stage_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_centers_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_seasons_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_trip_model.dart';

class BusesTravelState {
  BusesTravelState({
    this.isLoadingCenters = false,
    this.isLoadingSeasons = false,
    this.isLoadingTrips = false,
    this.isLoadingTripsByStage = false,
    this.isEditingTripByStage = false,
    this.isAddingTripByStage = false,
    this.isAddingTripByStageSuccess = false,
    this.isEditingTripByStageSuccess = false,
    this.isDeleteTripByStage = false,
    this.isDeleteTripByStageSuccess = false,
    this.centers = const [],
    this.seasons = const [],
    this.trips = const [],
    this.tripsByStage = const [],
    this.error,
  });
  final bool isLoadingCenters;
  final bool isLoadingSeasons;
  final bool isLoadingTrips;
  final bool isLoadingTripsByStage;
  final bool isEditingTripByStage;
  final bool isAddingTripByStage;
  final bool isAddingTripByStageSuccess;
  final bool isEditingTripByStageSuccess;
  final bool isDeleteTripByStage;
  final bool isDeleteTripByStageSuccess;
  final List<BusesTravelGetCenterModel> centers;
  final List<BusesTravelGetSeasonModel> seasons;
  final List<BusesTravelGetTripModel> trips;
  final List<TripModel> tripsByStage;

  final String? error;

  BusesTravelState copyWith({
    bool? isLoadingCenters,
    bool? isLoadingSeasons,
    bool? isLoadingTrips,
    bool? isLoadingTripsByStage,
    bool? isEditingTripByStage,
    bool? isAddingTripByStage,
    bool? isAddingTripByStageSuccess,
    bool? isEditingTripByStageSuccess,
    bool? isDeleteTripByStage,
    bool? isDeleteTripByStageSuccess,
    List<BusesTravelGetCenterModel>? centers,
    List<BusesTravelGetSeasonModel>? seasons,
    List<BusesTravelGetTripModel>? trips,
    List<TripModel>? tripsByStage,
    String? error,
  }) {
    return BusesTravelState(
      isLoadingCenters: isLoadingCenters ?? this.isLoadingCenters,
      isLoadingSeasons: isLoadingSeasons ?? this.isLoadingSeasons,
      isLoadingTrips: isLoadingTrips ?? this.isLoadingTrips,
      isDeleteTripByStage: isDeleteTripByStage ?? this.isDeleteTripByStage,
      isDeleteTripByStageSuccess:
          isDeleteTripByStageSuccess ?? this.isDeleteTripByStageSuccess,
      isEditingTripByStageSuccess:
          isEditingTripByStageSuccess ?? this.isEditingTripByStageSuccess,
      isAddingTripByStageSuccess:
          isAddingTripByStageSuccess ?? this.isAddingTripByStageSuccess,
      isLoadingTripsByStage:
          isLoadingTripsByStage ?? this.isLoadingTripsByStage,
      isEditingTripByStage: isEditingTripByStage ?? this.isEditingTripByStage,
      isAddingTripByStage: isAddingTripByStage ?? this.isAddingTripByStage,
      centers: centers ?? this.centers,
      seasons: seasons ?? this.seasons,
      trips: trips ?? this.trips,
      tripsByStage: tripsByStage ?? this.tripsByStage,
      error: error ?? this.error,
    );
  }
}
