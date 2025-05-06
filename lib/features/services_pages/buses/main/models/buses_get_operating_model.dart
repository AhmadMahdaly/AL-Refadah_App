import 'package:flutter/foundation.dart';

@immutable
class BusesGetOperatingModel {
  const BusesGetOperatingModel({
    required this.fSeasonId,
    required this.fCenterNo,
    required this.fOperatingNo,
    required this.fTransportType,
    required this.fBusAco,
    required this.fOperatingStatus,
  });

  factory BusesGetOperatingModel.fromJson(Map<String, dynamic> json) {
    return BusesGetOperatingModel(
      fSeasonId: json['fSeasonId'] as int,
      fCenterNo: json['fCenterNo'] as int,
      fOperatingNo: json['fOperatingNo'].toString(),
      fTransportType: json['fTransportType'] as int,
      fBusAco: json['fBusAco'] as int,
      fOperatingStatus: json['fOperatingStatus'] as int,
    );
  }
  final int fSeasonId;
  final int fCenterNo;
  final String fOperatingNo;
  final int fTransportType;
  final int fBusAco;
  final int fOperatingStatus;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusesGetOperatingModel &&
          runtimeType == other.runtimeType &&
          fOperatingNo == other.fOperatingNo;

  @override
  int get hashCode => fOperatingNo.hashCode;
}
