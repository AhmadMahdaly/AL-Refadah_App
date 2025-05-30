import 'package:alrefadah/features/home_page/models/delayed_trip_model.dart';

class DashboardModel {
  DashboardModel({
    required this.totalStageBuses,
    required this.totalStageTrips,
    required this.totalDepartingBuses,
    required this.totalTrips,
    required this.totalFinishedBuses,
    required this.totalPilgrims,
    required this.totalStagePilgrims,
    required this.totalEvacueesPilgrims,
    required this.totalArrivedPilgrims,
    required this.totalRemainingPilgrims,
    required this.totalFinishedCenters,
    required this.totalRemainingCenterPilgrims,
    required this.totalDelayedTrips,
    required this.delayedTrip,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      totalStageBuses: json['totalStageBuses'] as int? ?? 0,
      totalStageTrips: json['totalStageTrips'] as int? ?? 0,
      totalDepartingBuses: json['totaldepartingBuses'] as int? ?? 0,
      totalTrips: json['totalTrips'] as int? ?? 0,
      totalFinishedBuses: json['totalFinishedBuses'] as int? ?? 0,
      totalPilgrims: json['totalPilgrims'] as int? ?? 0,
      totalStagePilgrims: json['totalStagePilgrims'] as int? ?? 0,
      totalEvacueesPilgrims: json['totalEvacueesPilgrims'] as int? ?? 0,
      totalArrivedPilgrims: json['totalArrivedPilgrims'] as int? ?? 0,
      totalRemainingPilgrims: json['totalRemainigPilgrims'] as int? ?? 0,
      totalFinishedCenters: json['totalFinishedCenters'] as int? ?? 0,
      totalRemainingCenterPilgrims:
          json['totalRemainingCenterPilgrims'] as int? ?? 0,
      totalDelayedTrips: json['totalDelayedTrips'] as int? ?? 0,

      delayedTrip: (json['delayedTrip'] as List<dynamic>)
          .map((e) => DelayedTripModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final int? totalStageBuses;
  final int? totalStageTrips;
  final int? totalDepartingBuses;
  final int? totalTrips;
  final int? totalFinishedBuses;
  final int? totalPilgrims;
  final int? totalStagePilgrims;
  final int? totalEvacueesPilgrims;
  final int? totalArrivedPilgrims;
  final int? totalRemainingPilgrims;
  final int? totalFinishedCenters;
  final int? totalRemainingCenterPilgrims;
  final int? totalDelayedTrips;
  final List<DelayedTripModel>? delayedTrip;
}
