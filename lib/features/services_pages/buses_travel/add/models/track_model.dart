import 'package:flutter/foundation.dart';

@immutable
class TrackModel {
  const TrackModel({
    this.fLastUpdate,
    this.fLastUpdateUser,
    this.fLastUpdateSum,
    this.fLastUpdateOper,
    this.fTrackNo,
    this.fTrackName,
    this.fTrackNameE,
    this.fAdditionDate,
    this.fAdditionUser,
    this.fAdditionUserNavigation,
    this.fLastUpdateUserNavigation,
    this.hajTransportTrips,
  });

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return TrackModel(
      fLastUpdate:
          json['fLastUpdate'] != null
              ? DateTime.tryParse(json['fLastUpdate'].toString())
              : null,
      fLastUpdateUser:
          json['fLastUpdateUser'] != null
              ? int.tryParse(json['fLastUpdateUser'].toString())
              : null,
      fLastUpdateSum:
          json['fLastUpdateSum'] != null
              ? int.tryParse(json['fLastUpdateSum'].toString())
              : null,
      fLastUpdateOper:
          json['fLastUpdateOper'] != null
              ? int.tryParse(json['fLastUpdateOper'].toString())
              : null,
      fTrackNo:
          json['fTrackNo'] != null
              ? int.tryParse(json['fTrackNo'].toString())
              : null,
      fTrackName: json['fTrackName'].toString(),
      fTrackNameE: json['fTrackNameE'].toString(),
      fAdditionDate:
          json['fAdditionDate'] != null
              ? DateTime.tryParse(json['fAdditionDate'].toString())
              : null,
      fAdditionUser:
          json['fAdditionUser'] != null
              ? int.tryParse(json['fAdditionUser'].toString())
              : null,
      fAdditionUserNavigation: json['fAdditionUserNavigation'],
      fLastUpdateUserNavigation: json['fLastUpdateUserNavigation'],
      hajTransportTrips:
          json['hajTransportTrips'] != null
              ? List<dynamic>.from(
                json['hajTransportTrips'] as Iterable<dynamic>,
              )
              : [],
    );
  }
  final DateTime? fLastUpdate;
  final int? fLastUpdateUser;
  final int? fLastUpdateSum;
  final int? fLastUpdateOper;
  final int? fTrackNo;
  final String? fTrackName;
  final String? fTrackNameE;
  final DateTime? fAdditionDate;
  final int? fAdditionUser;
  final dynamic fAdditionUserNavigation;
  final dynamic fLastUpdateUserNavigation;
  final List<dynamic>? hajTransportTrips;

  Map<String, dynamic> toJson() {
    return {
      'fLastUpdate': fLastUpdate?.toIso8601String(),
      'fLastUpdateUser': fLastUpdateUser,
      'fLastUpdateSum': fLastUpdateSum,
      'fLastUpdateOper': fLastUpdateOper,
      'fTrackNo': fTrackNo,
      'fTrackName': fTrackName,
      'fTrackNameE': fTrackNameE,
      'fAdditionDate': fAdditionDate?.toIso8601String(),
      'fAdditionUser': fAdditionUser,
      'fAdditionUserNavigation': fAdditionUserNavigation,
      'fLastUpdateUserNavigation': fLastUpdateUserNavigation,
      'hajTransportTrips': hajTransportTrips,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackModel &&
          runtimeType == other.runtimeType &&
          fTrackNo == other.fTrackNo;

  @override
  int get hashCode => fTrackNo.hashCode;
}
