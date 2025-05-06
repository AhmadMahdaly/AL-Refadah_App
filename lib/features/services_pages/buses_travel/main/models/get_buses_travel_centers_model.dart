import 'package:flutter/foundation.dart';

@immutable
class BusesTravelGetCenterModel {
  const BusesTravelGetCenterModel({
    required this.fCenterNo,
    required this.fCenterName,
  });

  factory BusesTravelGetCenterModel.fromJson(Map<String, dynamic> json) {
    return BusesTravelGetCenterModel(
      fCenterNo: json['fCenterNo'] as int,
      fCenterName: json['fCenterName'].toString(),
    );
  }
  final int fCenterNo;
  final String fCenterName;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusesTravelGetCenterModel &&
          runtimeType == other.runtimeType &&
          fCenterName == other.fCenterName;

  @override
  int get hashCode => fCenterName.hashCode;
}
