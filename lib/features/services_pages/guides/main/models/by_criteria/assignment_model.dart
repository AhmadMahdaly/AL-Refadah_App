import 'package:alrefadah/features/services_pages/guides/main/models/by_criteria/employee_model.dart';

class AssignmentModel {
  AssignmentModel({
    required this.insert,
    required this.update,
    required this.delete,
    required this.fLastUpdate,
    required this.fLastUpdateUser,
    required this.fLastUpdateSum,
    required this.fLastUpdateOper,
    required this.fCompanyId,
    required this.fSeasonId,
    required this.fCenterNo,
    required this.fEmpNo,
    this.employee,
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
      insert: json['insert'] as int,
      update: json['update'] as int,
      delete: json['delete'] as int,
      fLastUpdate: json['fLastUpdate'].toString(),
      fLastUpdateUser: json['fLastUpdateUser'] as int,
      fLastUpdateSum: json['fLastUpdateSum'] as int,
      fLastUpdateOper: json['fLastUpdateOper'] as int,
      fCompanyId: json['fCompanyId'] as int,
      fSeasonId: json['fSeasonId'] as int,
      fCenterNo: json['fCenterNo'] as int,
      fEmpNo: json['fEmpNo'] as int,
      employee:
          json['employee'] != null
              ? Employee.fromJson(json['employee'] as Map<String, dynamic>)
              : null,
    );
  }
  final int insert;
  final int update;
  final int delete;
  final String fLastUpdate;
  final int fLastUpdateUser;
  final int fLastUpdateSum;
  final int fLastUpdateOper;
  final int fCompanyId;
  final int fSeasonId;
  final int fCenterNo;
  final int fEmpNo;
  final Employee? employee;

  Map<String, dynamic> toJson() {
    return {
      'insert': insert,
      'update': update,
      'delete': delete,
      'fLastUpdate': fLastUpdate,
      'fLastUpdateUser': fLastUpdateUser,
      'fLastUpdateSum': fLastUpdateSum,
      'fLastUpdateOper': fLastUpdateOper,
      'fCompanyId': fCompanyId,
      'fSeasonId': fSeasonId,
      'fCenterNo': fCenterNo,
      'fEmpNo': fEmpNo,
      'employee': employee?.toJson(),
    };
  }
}
