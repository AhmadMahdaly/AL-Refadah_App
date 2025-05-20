class EditBusModel {
  EditBusModel({
    required this.fBusIdTrip,
    required this.fBusAco,
    required this.fTransportName,
    required this.fStageName,
    required this.fCenterName,
    required this.fBusId,
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
  });
  final String fBusId;
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
  final int fBusAco;
  final String fTransportName;
  final String fStageName;
  final String fCenterName;

  Map<String, dynamic> toJson() => {
    'fBusIdTrip': fBusIdTrip,
    'fBusId': fBusId,
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
    'fLastUpdateSum': 0,
    'fLastUpdateOper': 1,
    'fAdditionDate': DateTime.now().toIso8601String(),
    'fAdditionUser': 1,
    'fReceiptDate': DateTime.now().toIso8601String(),
    'fReceiptUser': 0,
  };
}

class BusModel {
  BusModel({
    required this.fLastUpdate,
    required this.fLastUpdateUser,
    required this.fLastUpdateSum,
    required this.fLastUpdateOper,
    required this.fCompanyId,
    required this.fSeasonId,
    required this.fCenterNo,
    required this.fStageNo,
    required this.fTransportNo,
    required this.fBusNo,
    required this.fBusId,
    required this.fBusIdTrip,
    required this.fOperatingNo,
    required this.fPilgrimsAco,
    required this.fTripAco,
    required this.fAdditionDate,
    required this.fAdditionUser,
    required this.fReceiptDate,
    required this.fReceiptUser,
    required this.fBusNote,
    required this.fBusStatus,
  });

  factory BusModel.fromJson(Map<String, dynamic> json) {
    return BusModel(
      fLastUpdate: DateTime.parse(json['fLastUpdate'].toString()),
      fLastUpdateUser: json['fLastUpdateUser'] as int,
      fLastUpdateSum: json['fLastUpdateSum'] as int,
      fLastUpdateOper: json['fLastUpdateOper'] as int,
      fCompanyId: json['fCompanyId'] as int,
      fSeasonId: json['fSeasonId'] as int,
      fCenterNo: json['fCenterNo'] as int,
      fStageNo: json['fStageNo'] as int,
      fTransportNo: json['fTransportNo'] as int,
      fBusNo: json['fBusNo'].toString(),
      fBusId: json['fBusId'].toString(),
      fBusIdTrip: json['fBusIdTrip'].toString(),
      fOperatingNo: json['fOperatingNo'].toString(),
      fPilgrimsAco: json['fPilgrimsAco'] as int,
      fTripAco: json['fTripAco'] as int,
      fAdditionDate: DateTime.parse(json['fAdditionDate'].toString()),
      fAdditionUser: json['fAdditionUser'] as int,
      fReceiptDate:
          json['fReceiptDate'] != null
              ? DateTime.tryParse(json['fReceiptDate'].toString())
              : null,
      fReceiptUser: json['fReceiptUser'] as int,
      fBusNote: json['fBusNote'].toString(),
      fBusStatus: json['fBusStatus'] as int,
    );
  }
  final DateTime fLastUpdate;
  final int fLastUpdateUser;
  final int fLastUpdateSum;
  final int fLastUpdateOper;
  final int fCompanyId;
  final int fSeasonId;
  final int fCenterNo;
  final int fStageNo;
  int fTransportNo;
  String fBusNo;
  final String fBusId;
  final String fBusIdTrip;
  final String fOperatingNo;
  int fPilgrimsAco;
  int fTripAco;
  final DateTime fAdditionDate;
  final int fAdditionUser;
  final DateTime? fReceiptDate;
  final int? fReceiptUser;
  String fBusNote;
  final int fBusStatus;

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
      'fTransportNo': fTransportNo,
      'fBusNo': fBusNo,
      'fBusId': fBusId,
      'fBusIdTrip': fBusIdTrip,
      'fOperatingNo': fOperatingNo,
      'fPilgrimsAco': fPilgrimsAco,
      'fTripAco': fTripAco,
      'fAdditionDate': fAdditionDate.toIso8601String(),
      'fAdditionUser': fAdditionUser,
      'fReceiptDate': fReceiptDate?.toIso8601String(),
      'fReceiptUser': fReceiptUser,
      'fBusNote': fBusNote,
      'fBusStatus': fBusStatus,
    };
  }
}
