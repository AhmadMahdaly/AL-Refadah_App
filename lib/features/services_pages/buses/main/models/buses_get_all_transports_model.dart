import 'package:flutter/foundation.dart';

@immutable
class BusesGetAllTransportsModel {
  const BusesGetAllTransportsModel({
    required this.fTransportNo,
    required this.fTransportName,
  });

  factory BusesGetAllTransportsModel.fromJson(Map<String, dynamic> json) {
    return BusesGetAllTransportsModel(
      fTransportNo: json['fTransportNo'] as int,
      fTransportName: json['fTransportName'].toString(),
    );
  }
  final int fTransportNo;
  final String fTransportName;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusesGetAllTransportsModel &&
          runtimeType == other.runtimeType &&
          fTransportName == other.fTransportName;

  @override
  int get hashCode => fTransportName.hashCode;
}
