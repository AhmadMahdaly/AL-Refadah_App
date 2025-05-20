class AddTripModel {
  AddTripModel({
    required this.fApprovalDate,
    required this.fLastUpdate,
    required this.fLastUpdateUser,
    required this.fLastUpdateSum,
    required this.fLastUpdateOper,
    required this.fCompanyId,
    required this.fSeasonId,
    required this.fCenterNo,
    required this.fStageNo,
    required this.fTripNo,
    required this.fTripDate,
    required this.fTripTime,
    required this.fBusId,
    required this.fPilgrimsAco,
    required this.fAdditionDate,
    required this.fAdditionUser,
    required this.fAdditionLatitude,
    required this.fReceiptDate,
    required this.fReceiptUser,
    required this.fReceiptLatitude,
    required this.fTripStstus,
    required this.fReceiptLongitude,
    required this.fAdditionLongitude,
    required this.fApprovalUser,
    required this.fApprovalLatitude,
    required this.fApprovalLongitude,
    required this.fEmpNo,
    required this.fTrackNo,
  });
  final String fLastUpdate;
  final int fLastUpdateUser;
  final int fLastUpdateSum;
  final int fLastUpdateOper;
  final int fCompanyId;
  final int fSeasonId;
  final int fCenterNo;
  final int fStageNo;
  final int fTripNo;
  final String fTripDate;
  final String fTripTime;
  final String fBusId;
  final int fPilgrimsAco;
  final String fAdditionDate;
  final String fAdditionUser;
  final String fAdditionLatitude;
  final String fReceiptDate;
  final int? fReceiptUser;
  final String fReceiptLatitude;
  final int fTripStstus;
  final String fReceiptLongitude;
  final String fAdditionLongitude;
  final int? fApprovalUser;
  final String fApprovalLatitude;
  final String fApprovalLongitude;
  final int? fEmpNo;
  final int fTrackNo;
  final String fApprovalDate;
  Map<String, dynamic> toJson() {
    return {
      'fTrackNo': fTrackNo,
      'fLastUpdate': fLastUpdate,
      'fLastUpdateUser': fLastUpdateUser,
      'fLastUpdateSum': fLastUpdateSum,
      'fLastUpdateOper': fLastUpdateOper,
      'fCompanyId': fCompanyId,
      'fSeasonId': fSeasonId,
      'fCenterNo': fCenterNo,
      'fStageNo': fStageNo,
      'fTripNo': fTripNo,
      'fTripDate': fTripDate,
      'fTripTime': fTripTime,
      'fBusId': fBusId,
      'fPilgrimsAco': fPilgrimsAco,
      'fAdditionDate': fAdditionDate,
      'fAdditionUser': fAdditionUser,
      'fAdditionLatitude': fAdditionLatitude,
      'fReceiptDate': fReceiptDate,
      'fReceiptUser': fReceiptUser,
      'fReceiptLatitude': fReceiptLatitude,
      'fTripStstus': fTripStstus,
      'fReceiptLongitude': fReceiptLongitude,
      'fAdditionLongitude': fAdditionLongitude,
      'fApprovalUser': fApprovalUser,
      'fApprovalLatitude': fApprovalLatitude,
      'fApprovalLongitude': fApprovalLongitude,
      'fEmpNo': fEmpNo,
      'fApprovalDate': fApprovalDate,
    };
  }
}
