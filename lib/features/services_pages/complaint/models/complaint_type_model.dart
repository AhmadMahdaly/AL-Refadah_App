import 'package:flutter/foundation.dart';

@immutable
class ComplaintTypeModel {
  const ComplaintTypeModel({
    required this.fComplaintTypeNo,
    required this.fComplaintTypeName,
    this.fComplaintTypeNameE,
    this.fComplaintTypeStatus,
  });

  factory ComplaintTypeModel.fromJson(Map<String, dynamic> json) {
    return ComplaintTypeModel(
      fComplaintTypeNo: json['fComplaintTypeNo'] as int,
      fComplaintTypeName: json['fComplaintTypeName'].toString(),
      fComplaintTypeNameE: json['fComplaintTypeNameE'].toString(),
      fComplaintTypeStatus: json['fComplaintTypeStatus'] as int,
    );
  }
  final int fComplaintTypeNo;
  final String fComplaintTypeName;
  final String? fComplaintTypeNameE;
  final int? fComplaintTypeStatus;

  Map<String, dynamic> toJson() {
    return {
      'fComplaintTypeNo': fComplaintTypeNo,
      'fComplaintTypeName': fComplaintTypeName,
      'fComplaintTypeNameE': fComplaintTypeNameE,
      'fComplaintTypeStatus': fComplaintTypeStatus,
    };
  }

  @override
  String toString() => fComplaintTypeName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComplaintTypeModel &&
          runtimeType == other.runtimeType &&
          fComplaintTypeNo == other.fComplaintTypeNo;

  @override
  int get hashCode => fComplaintTypeNo.hashCode;
}
