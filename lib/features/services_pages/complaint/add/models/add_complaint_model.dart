class AddComplaintModel {
  AddComplaintModel({
    required this.fComplaintNo,
    required this.fComplaintTypeNo,
    required this.fCompanyId,
    required this.fSeasonId,
    required this.fComplaintTypeName,
    required this.fCenterNo,
    required this.fCenterName,
    required this.fBusId,
    required this.fBusName,
    required this.fComplaintDate,
    required this.fComplaintDescription,
    required this.fComplaintStatus,
    required this.fAdditionDate,
    required this.fAdditionUser,
    required this.fAdditionUserName,
  });
  final int fComplaintNo;
  final int fComplaintTypeNo;
  final int fCompanyId;
  final int fSeasonId;
  final String fComplaintTypeName;
  final int fCenterNo;
  final String fCenterName;
  final int fBusId;
  final String fBusName;
  final DateTime fComplaintDate;
  final String fComplaintDescription;
  final int fComplaintStatus;
  final DateTime fAdditionDate;
  final int fAdditionUser;
  final String fAdditionUserName;

  Map<String, dynamic> toJson() {
    return {
      'fComplaintNo': fComplaintNo,
      'fComplaintTypeNo': fComplaintTypeNo,
      'fCompanyId': fCompanyId,
      'fSeasonId': fSeasonId,
      'fComplaintTypeName': fComplaintTypeName,
      'fCenterNo': fCenterNo,
      'fCenterName': fCenterName,
      'fBusId': fBusId,
      'fBusName': fBusName,
      'fComplaintDate': fComplaintDate.toIso8601String(),
      'fComplaintDescription': fComplaintDescription,
      'fComplaintStatus': fComplaintStatus,
      'fAdditionDate': fAdditionDate.toIso8601String(),
      'fAdditionUser': fAdditionUser,
      'fAdditionUserName': fAdditionUserName,
    };
  }
}
