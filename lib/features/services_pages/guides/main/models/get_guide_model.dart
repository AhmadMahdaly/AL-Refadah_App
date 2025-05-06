import 'package:flutter/foundation.dart';

@immutable
class GetGuidesModel {
  const GetGuidesModel({
    required this.natiNo,
    required this.empNo,
    required this.empFirst,
    required this.empFather,
    required this.empGrandfather,
    required this.empFamily,
    required this.empName,
    required this.empFirstE,
    required this.empNameE,
    required this.gender,
    required this.birthDate,
    required this.age,
    required this.idNo,
    required this.bankIbanNo,
    required this.jawNo,
    required this.email,
    required this.homeAddress,
  });

  factory GetGuidesModel.fromJson(Map<String, dynamic> json) {
    return GetGuidesModel(
      empNo: json['fEmpNo'] as int,
      empFirst: json['fEmpFirst'].toString(),
      empFather: json['fEmpFather'].toString(),
      empGrandfather: json['fEmpGrandfather'].toString(),
      empFamily: json['fEmpFamily'].toString(),
      empName: json['fEmpName'].toString(),
      empFirstE: json['fEmpFirstE'].toString(),
      empNameE: json['fEmpNameE'].toString(),
      gender: json['fGender'] as int,
      birthDate: json['fBirthDate'].toString(),
      age: json['fAge'] as int,
      idNo: json['fIdNo'] as int,
      bankIbanNo: json['fBankIbanNo'].toString(),
      jawNo: json['fJawNo'].toString(),
      email: json['fEmail'].toString(),
      homeAddress: json['fHomeAddress'].toString(),
      natiNo: json['fNatiNo'] as int,
    );
  }
  final int empNo;
  final String empFirst;
  final String empFather;
  final String empGrandfather;
  final String empFamily;
  final String empName;
  final String empFirstE;
  final String empNameE;
  final int gender;
  final String birthDate;
  final int age;
  final int idNo;
  final String bankIbanNo;
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
