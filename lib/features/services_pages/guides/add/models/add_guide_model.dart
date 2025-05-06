class AddGuideModel {
  AddGuideModel({
    required this.fLastUpdate,
    required this.fLastUpdateUser,
    required this.fLastUpdateSum,
    required this.fLastUpdateOper,
    required this.fCompanyId,
    required this.fSeasonId,
    required this.fCenterNo,
    required this.fEmpNo,
  });
  DateTime fLastUpdate;
  int fLastUpdateUser;
  int fLastUpdateSum;
  int fLastUpdateOper;
  int fCompanyId;
  int fSeasonId;
  int fCenterNo;
  int fEmpNo;

  Map<String, dynamic> toJson() {
    return {
      'fLastUpdate': fLastUpdate.toIso8601String(),
      'fLastUpdateUser': fLastUpdateUser,
      'fLastUpdateSum': fLastUpdateSum,
      'fLastUpdateOper': fLastUpdateOper,
      'fCompanyId': fCompanyId,
      'fSeasonId': fSeasonId,
      'fCenterNo': fCenterNo,
      'fEmpNo': fEmpNo,
    };
  }
}
