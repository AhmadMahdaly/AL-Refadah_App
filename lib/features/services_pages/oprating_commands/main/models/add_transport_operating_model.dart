class AddTransportOperatingModel {
  AddTransportOperatingModel({
    required this.fLastUpdate,
    required this.fLastUpdateUser,
    required this.fLastUpdateSum,
    required this.fLastUpdateOper,
    required this.fCompanyId,
    required this.fSeasonId,
    required this.fCenterNo,
    required this.fOperatingNo,
    required this.fTransportType,
    required this.fBusAco,
    required this.fOperatingStatus,
  });

  factory AddTransportOperatingModel.fromJson(Map<String, dynamic> json) {
    return AddTransportOperatingModel(
      fLastUpdate: DateTime.parse(json['fLastUpdate'].toString()),
      fLastUpdateUser: json['fLastUpdateUser'] as int,
      fLastUpdateSum: json['fLastUpdateSum'] as int,
      fLastUpdateOper: json['fLastUpdateOper'] as int,
      fCompanyId: json['fCompanyId'] as int,
      fSeasonId: json['fSeasonId'] as int,
      fCenterNo: json['fCenterNo'] as int,
      fOperatingNo: json['fOperatingNo'].toString(),
      fTransportType: json['fTransportType'] as int,
      fBusAco: json['fBusAco'] as int,
      fOperatingStatus: json['fOperatingStatus'] as int,
    );
  }
  final DateTime fLastUpdate;
  final int fLastUpdateUser;
  final int fLastUpdateSum;
  final int fLastUpdateOper;
  final int fCompanyId;
  final int fSeasonId;
  final int fCenterNo;
  final String fOperatingNo;
  final int fTransportType;
  final int fBusAco;
  final int fOperatingStatus;

  Map<String, dynamic> toJson() {
    return {
      'fLastUpdate': fLastUpdate.toIso8601String(),
      'fLastUpdateUser': fLastUpdateUser,
      'fLastUpdateSum': fLastUpdateSum,
      'fLastUpdateOper': fLastUpdateOper,
      'fCompanyId': fCompanyId,
      'fSeasonId': fSeasonId,
      'fCenterNo': fCenterNo,
      'fOperatingNo': fOperatingNo,
      'fTransportType': fTransportType,
      'fBusAco': fBusAco,
      'fOperatingStatus': fOperatingStatus,
    };
  }
}
