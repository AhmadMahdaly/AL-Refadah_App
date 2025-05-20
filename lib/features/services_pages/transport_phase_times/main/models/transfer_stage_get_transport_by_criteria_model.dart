class TransferStageGetTransportByCriteriaModel {
  TransferStageGetTransportByCriteriaModel({
    required this.fLastUpdate,
    required this.fLastUpdateUser,
    required this.fLastUpdateSum,
    required this.fLastUpdateOper,
    required this.fCompanyId,
    required this.fSeasonId,
    required this.fCenterNo,
    required this.fStageNo,
    required this.fPilgrimsAco,
    required this.fBusesAco,
    required this.fTripsAco,
  });

  factory TransferStageGetTransportByCriteriaModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TransferStageGetTransportByCriteriaModel(
      fLastUpdate: DateTime.parse(json['fLastUpdate'].toString()),
      fLastUpdateUser: json['fLastUpdateUser'] as int,
      fLastUpdateSum: json['fLastUpdateSum'] as int,
      fLastUpdateOper: json['fLastUpdateOper'] as int,
      fCompanyId: json['fCompanyId'] as int,
      fSeasonId: json['fSeasonId'] as int,
      fCenterNo: json['fCenterNo'] as int,
      fStageNo: json['fStageNo'] as int,
      fPilgrimsAco: json['fPilgrimsAco'] as int,
      fBusesAco: json['fBusesAco'] as int,
      fTripsAco: json['fTripsAco'] as int,
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
  final int fPilgrimsAco;
  final int fBusesAco;
  final int fTripsAco;

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
      'fPilgrimsAco': fPilgrimsAco,
      'fBusesAco': fBusesAco,
      'fTripsAco': fTripsAco,
    };
  }
}
