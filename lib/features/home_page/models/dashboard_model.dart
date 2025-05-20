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
      totalStageBuses: json['totalStageBuses'] as int,
      totalStageTrips: json['totalStageTrips'] as int,
      totalDepartingBuses: json['totaldepartingBuses'] as int,
      totalTrips: json['totalTrips'] as int,
      totalFinishedBuses: json['totalFinishedBuses'] as int,
      totalPilgrims: json['totalPilgrims'] as int,
      totalStagePilgrims: json['totalStagePilgrims'] as int,
      totalEvacueesPilgrims: json['totalEvacueesPilgrims'] as int,
      totalArrivedPilgrims: json['totalArrivedPilgrims'] as int,
      totalRemainingPilgrims: json['totalRemainigPilgrims'] as int,
      totalFinishedCenters: json['totalFinishedCenters'] as int,
      totalRemainingCenterPilgrims: json['totalRemainingCenterPilgrims'] as int,
      totalDelayedTrips: json['totalDelayedTrips'] as int,

      delayedTrip:
          (json['delayedTrip'] as List<dynamic>)
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

  Map<String, dynamic> toJson() {
    return {
      'totalStageBuses': totalStageBuses,
      'totalStageTrips': totalStageTrips,
      'totaldepartingBuses': totalDepartingBuses,
      'totalTrips': totalTrips,
      'totalFinishedBuses': totalFinishedBuses,
      'totalPilgrims': totalPilgrims,
      'totalStagePilgrims': totalStagePilgrims,
      'totalEvacueesPilgrims': totalEvacueesPilgrims,
      'totalArrivedPilgrims': totalArrivedPilgrims,
      'totalRemainigPilgrims': totalRemainingPilgrims,
      'totalFinishedCenters': totalFinishedCenters,
      'totalRemainingCenterPilgrims': totalRemainingCenterPilgrims,
      'totalDelayedTrips': totalDelayedTrips,
      'delayedTrip': delayedTrip,
    };
  }
}
