import 'package:alrefadah/features/services_pages/buses_travel/add/models/track_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/trip_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_centers_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_seasons_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/main/models/get_buses_travel_trip_model.dart';
import 'package:alrefadah/features/services_pages/complaint/add/models/complaint_type_model.dart';
import 'package:alrefadah/features/services_pages/complaint/show_all/models/complaint_model.dart';

class BusTravelState {
  BusTravelState({
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
    this.isLoadingIncomingTripByStage = false,
    this.isSuccessIncomingTripByStage = false,
    this.centers = const [],
    this.seasons = const [],
    this.trips = const [],
    this.tripsByStage = const [],
    this.incomingTripsByStage = const [],
    this.isLoadingArrivingTripByStage = false,
    this.isSuccessArrivingTripByStage = false,
    this.arrivingTripsByStage = const [],
    this.isLoadingTrackTrip = false,
    this.complaintType = const [],
    this.isLoadingcomplaintType = false,
    this.track = const [],
    this.error,
    this.showEditErrorDialog = false,
    this.isLoadingAddcomplaint = false,
    this.isSuccessAddcomplaint = false,
    this.complaint = const [],
    this.isLoadingcomplaint = false,
    this.selectedTrack,
    this.selectedCenter,
    this.selectedStage,
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
  final bool isLoadingIncomingTripByStage;
  final bool isSuccessIncomingTripByStage;
  final List<BusesTravelGetCenterModel> centers;
  final List<BusesTravelGetSeasonModel> seasons;
  final List<BusesTravelGetTripModel> trips;
  final List<TripModel> tripsByStage;
  final List<TripModel> incomingTripsByStage;
  final List<TrackModel> track;

  final bool isLoadingArrivingTripByStage;
  final bool isSuccessArrivingTripByStage;
  final List<TripModel> arrivingTripsByStage;
  final String? error;
  final bool showEditErrorDialog;
  final bool isLoadingTrackTrip;
  final List<ComplaintTypeModel> complaintType;
  final bool isLoadingcomplaintType;
  final bool isLoadingAddcomplaint;
  final bool isSuccessAddcomplaint;
  final List<ComplaintModel> complaint;
  final bool isLoadingcomplaint;
  int? selectedTrack;
  int? selectedCenter;
  int? selectedStage;

  BusTravelState copyWith({
    bool? isLoadingTrackTrip,
    List<TrackModel>? track,
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
    bool? isLoadingIncomingTripByStage,
    bool? isSuccessIncomingTripByStage,
    bool? showEditErrorDialog,
    List<BusesTravelGetCenterModel>? centers,
    List<BusesTravelGetSeasonModel>? seasons,
    List<BusesTravelGetTripModel>? trips,

    List<TripModel>? tripsByStage,

    String? error,
    List<TripModel>? incomingTripsByStage,
    bool? isLoadingArrivingTripByStage,
    bool? isSuccessArrivingTripByStage,
    List<TripModel>? arrivingTripsByStage,
    List<ComplaintTypeModel>? complaintType,
    bool? isLoadingcomplaintType,
    bool? isLoadingAddcomplaint,
    bool? isSuccessAddcomplaint,
    List<ComplaintModel>? complaint,
    bool? isLoadingcomplaint,
    int? selectedTrack,
    int? selectedCenter,
    int? selectedStage,
  }) {
    return BusTravelState(
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
      isLoadingIncomingTripByStage:
          isLoadingIncomingTripByStage ?? this.isLoadingIncomingTripByStage,
      isSuccessIncomingTripByStage:
          isSuccessIncomingTripByStage ?? this.isSuccessIncomingTripByStage,
      incomingTripsByStage: incomingTripsByStage ?? this.incomingTripsByStage,
      isLoadingArrivingTripByStage:
          isLoadingArrivingTripByStage ?? this.isLoadingArrivingTripByStage,
      isSuccessArrivingTripByStage:
          isSuccessArrivingTripByStage ?? this.isSuccessArrivingTripByStage,
      arrivingTripsByStage: arrivingTripsByStage ?? this.arrivingTripsByStage,
      showEditErrorDialog: showEditErrorDialog ?? this.showEditErrorDialog,
      isLoadingTrackTrip: isLoadingTrackTrip ?? this.isLoadingTrackTrip,
      track: track ?? this.track,
      complaintType: complaintType ?? this.complaintType,
      isLoadingcomplaintType:
          isLoadingcomplaintType ?? this.isLoadingcomplaintType,
      isLoadingAddcomplaint:
          isLoadingAddcomplaint ?? this.isLoadingAddcomplaint,
      isSuccessAddcomplaint:
          isSuccessAddcomplaint ?? this.isSuccessAddcomplaint,
      complaint: complaint ?? this.complaint,
      isLoadingcomplaint: isLoadingcomplaint ?? this.isLoadingcomplaint,
      selectedTrack: selectedTrack ?? this.selectedTrack,
      selectedCenter: selectedCenter ?? this.selectedCenter,
      selectedStage: selectedStage ?? this.selectedStage,
    );
  }
}
