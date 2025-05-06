class AddTripModel {
  AddTripModel({
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
  });
  final DateTime fLastUpdate;
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
  final int fBusId;
  final int fPilgrimsAco;
  final DateTime fAdditionDate;
  final int fAdditionUser;
  final String fAdditionLatitude;
  final DateTime fReceiptDate;
  final int fReceiptUser;
  final String fReceiptLatitude;
  final int fTripStstus;
  final String fReceiptLongitude;
  final String fAdditionLongitude;

  Map<String, dynamic> toJson() {
    return {
      'fLastUpdate': fLastUpdate.toIso8601String(),
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
      'fAdditionDate': fAdditionDate.toIso8601String(),
      'fAdditionUser': fAdditionUser,
      'fAdditionLatitude': fAdditionLatitude,
      'fReceiptDate': fReceiptDate.toIso8601String(),
      'fReceiptUser': fReceiptUser,
      'fReceiptLatitude': fReceiptLatitude,
      'fTripStstus': fTripStstus,
      'fReceiptLongitude': fReceiptLongitude,
      'fAdditionLongitude': fAdditionLongitude,
    };
  }
}
