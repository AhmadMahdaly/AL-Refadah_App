import 'package:alrefadah/features/home_page/models/dashboard_model.dart';
import 'package:alrefadah/features/home_page/models/home_season_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/track_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_centers_model.dart';
import 'package:alrefadah/features/services_pages/transport_stage/models/stage_model.dart';

class HomeState {
  HomeState({
    this.isLoadingCenters = false,
    this.isLoadingSeasons = false,
    this.isLoadingStages = false,
    this.isLoadingTracks = false,
    this.isLoadingAllData = false,

    this.centers = const [],
    this.seasons = const [],
    this.stages = const [],
    this.tracks = const [],
    this.allData,
    this.error,
  });
  final bool isLoadingCenters;
  final bool isLoadingSeasons;
  final bool isLoadingStages;
  final bool isLoadingTracks;
  final bool isLoadingAllData;

  final List<BusesTravelGetCenterModel> centers;
  final List<HomeSeasonModel> seasons;
  final List<StageModel> stages;
  final List<TrackModel> tracks;
  final DashboardModel? allData;

  final String? error;

  HomeState copyWith({
    bool? isLoadingCenters,
    bool? isLoadingSeasons,
    bool? isLoadingStages,
    bool? isLoadingAllData,
    bool? isLoadingTracks,
    List<BusesTravelGetCenterModel>? centers,
    List<HomeSeasonModel>? seasons,
    List<StageModel>? stages,
    List<TrackModel>? tracks,
    DashboardModel? allData,
    String? error,
  }) {
    return HomeState(
      isLoadingCenters: isLoadingCenters ?? this.isLoadingCenters,
      isLoadingSeasons: isLoadingSeasons ?? this.isLoadingSeasons,
      isLoadingStages: isLoadingStages ?? this.isLoadingStages,
      isLoadingAllData: isLoadingAllData ?? this.isLoadingAllData,
      isLoadingTracks: isLoadingTracks ?? this.isLoadingTracks,
      centers: centers ?? this.centers,
      seasons: seasons ?? this.seasons,
      stages: stages ?? this.stages,
      tracks: tracks ?? this.tracks,
      allData: allData ?? this.allData,
      error: error ?? this.error,
    );
  }
}
