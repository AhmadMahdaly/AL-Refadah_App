class AddBusModel {
  AddBusModel({
    required this.fAdditionUser,
    required this.fCompanyId,
    required this.fSeasonId,
    required this.fCenterNo,
    required this.fStageNo,
    required this.fTransportNo,
    required this.fBusNo,
    required this.fOperatingNo,
    required this.fPilgrimsAco,
    required this.fTripAco,
    required this.fBusStatus,
    required this.fBusNote,
    required this.fBusIdTrip,
    required this.fBusId,
  });
  final int fCompanyId;
  final int fSeasonId;
  final int fCenterNo;
  final int fStageNo;
  final int fTransportNo;
  final String fBusNo;
  final String fOperatingNo;
  final int fPilgrimsAco;
  final int fTripAco;
  final int fBusStatus;
  final String fBusNote;
  final String fBusIdTrip;
  final String fBusId;
  final String fAdditionUser;

  Map<String, dynamic> toJson() => {
    'fCompanyId': fCompanyId,
    'fSeasonId': fSeasonId,
    'fCenterNo': fCenterNo,
    'fStageNo': fStageNo,
    'fTransportNo': fTransportNo,
    'fBusNo': fBusNo,
    'fOperatingNo': fOperatingNo,
    'fPilgrimsAco': fPilgrimsAco,
    'fTripAco': fTripAco,
    'fBusStatus': fBusStatus,
    'fBusNote': fBusNote,
    'fLastUpdate': DateTime.now().toIso8601String(),
    'fLastUpdateUser': 1,
    'fLastUpdateSum': 1,
    'fLastUpdateOper': 0,
    'fAdditionDate': DateTime.now().toIso8601String(),
    'fAdditionUser': fAdditionUser,
    'fReceiptDate': DateTime.now().toIso8601String(),
    'fReceiptUser': fAdditionUser,
    'fBusId': fBusId,
    'fBusIdTrip': fBusIdTrip,
  };
}
