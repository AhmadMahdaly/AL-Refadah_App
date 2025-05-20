class AddTransportStageModel {
  AddTransportStageModel({
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
