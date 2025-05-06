import 'package:flutter/foundation.dart';

@immutable
class BusesGetStageModel {
  const BusesGetStageModel({required this.fStageNo, required this.fStageName});

  factory BusesGetStageModel.fromJson(Map<String, dynamic> json) {
    return BusesGetStageModel(
      fStageNo: json['fStageNo'] as int,
      fStageName: json['fStageName'].toString(),
    );
  }
  final int fStageNo;
  final String fStageName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusesGetStageModel &&
          runtimeType == other.runtimeType &&
          fStageNo == other.fStageNo;

  @override
  int get hashCode => fStageNo.hashCode;
}
