import 'package:flutter/foundation.dart';

@immutable
class BusesGetCenterModel {
  const BusesGetCenterModel({
    required this.fCenterNo,
    required this.fCenterName,
  });

  factory BusesGetCenterModel.fromJson(Map<String, dynamic> json) {
    return BusesGetCenterModel(
      fCenterNo: json['fCenterNo'] as int,
      fCenterName: json['fCenterName'].toString(),
    );
  }
  final int fCenterNo;
  final String fCenterName;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusesGetCenterModel &&
          runtimeType == other.runtimeType &&
          fCenterName == other.fCenterName;

  @override
  int get hashCode => fCenterName.hashCode;
}
