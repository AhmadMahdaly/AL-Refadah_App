class GetAllBusesModel {
  GetAllBusesModel({
    required this.fBusNote,
    required this.fBusIdTrip,
    required this.fCompanyId,
    required this.fSeasonId,
    required this.fBusId,
    required this.fTransportNo,
    required this.fStageNo,
    required this.fCenterNo,
    required this.fBusAco,
    required this.fOperatingNo,
    required this.fTransportName,
    required this.fStageName,
    required this.fBusNo,
    required this.fPilgrimsAco,
    required this.fTripAco,
    required this.fBusStatus,
    required this.fCenterName,
  });

  factory GetAllBusesModel.fromJson(Map<String, dynamic> json) {
    return GetAllBusesModel(
      fBusNote: json['fBusNote'].toString(),
      fBusIdTrip: json['fBusIdTrip'].toString(),
      fSeasonId: json['fSeasonId'] as int,
      fCompanyId: json['fCompanyId'] as int,
      fCenterNo: json['fCenterNo'] as int,
      fBusAco: json['fPilgrimsAco'] as int,
      fOperatingNo: json['fOperatingNo'].toString(),
      fBusId: json['fBusId'].toString(),
      fTransportName:
          (json['transport'] as Map<String, dynamic>)['fTransportName']
              .toString(),
      fTransportNo:
          (json['transport'] as Map<String, dynamic>)['fTransportNo'] as int,
      fStageNo:
          (json['transportStage'] as Map<String, dynamic>)['fStageNo'] as int,
      fStageName:
          (json['transportStage'] as Map<String, dynamic>)['fStageName']
              .toString(),
      fBusNo: json['fBusNo'].toString(),
      fPilgrimsAco: json['fPilgrimsAco'] as int,
      fTripAco: json['fTripAco'] as int,
      fBusStatus: json['fBusStatus'] as int,
      fCenterName:
          ((json['hajTransportOperating'] as Map<String, dynamic>?)?['center']
                  as Map<String, dynamic>?)?['fCenterName']
              ?.toString() ??
          '',
    );
  }
  final String fBusNote;
  final String fBusIdTrip;
  final int fSeasonId;
  final int fCompanyId;
  final String fBusId;
  final int fTransportNo;
  final int fStageNo;
  final int fCenterNo;
  final int fBusAco;
  final String fOperatingNo;
  final String fTransportName;
  final String fStageName;
  final String fBusNo;
  final int fPilgrimsAco;
  final int fTripAco;
  final int fBusStatus;
  final String fCenterName;
}
