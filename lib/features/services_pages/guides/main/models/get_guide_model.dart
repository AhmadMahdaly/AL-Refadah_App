import 'package:flutter/foundation.dart';

@immutable
class GetGuidesModel {
  const GetGuidesModel({
    required this.natiNo,
    required this.empNo,
    required this.empName,
    required this.idNo,
    required this.jawNo,
    required this.email,
    required this.homeAddress,
  });

  factory GetGuidesModel.fromJson(Map<String, dynamic> json) {
    return GetGuidesModel(
      empNo: json['fEmpNo'] as int,
      empName: json['fEmpName'].toString(),
      idNo: json['fIdNo'] as int,
      jawNo: json['fJawNo'].toString(),
      email: json['fEmail'].toString(),
      homeAddress: json['fHomeAddress'].toString(),
      natiNo: json['fNatiNo'] as int,
    );
  }
  final int empNo;
  final String empName;
  final int idNo;
  final String jawNo;
  final String email;
  final String homeAddress;
  final int natiNo;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetGuidesModel &&
          runtimeType == other.runtimeType &&
          empNo == other.empNo;

  @override
  int get hashCode => empNo.hashCode;
}
