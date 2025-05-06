class OperatindCommandGetCentersModel {
  OperatindCommandGetCentersModel({
    required this.isAdded,
    required this.fLastUpdate,
    required this.fLastUpdateUser,
    required this.fLastUpdateSum,
    required this.fLastUpdateOper,
    required this.fCompanyId,
    required this.fSeasonId,
    required this.fCenterNo,
    required this.fCenterCode,
    required this.fCenterName,
    required this.fSectionNo,
    required this.fCenterStatus,
    required this.fCenterTransport,
    this.fCenterNameE,
    this.fCenterType,
    this.fCenterEmail,
    this.fCenterJaw,
    this.fLatitudeMak,
    this.fLongitudeMak,
    this.fLatitudeArafat,
    this.fLongitudeArafat,
    this.fLatitudeMona,
    this.fLongitudeMona,
  });

  factory OperatindCommandGetCentersModel.fromJson(Map<String, dynamic> json) {
    return OperatindCommandGetCentersModel(
      isAdded: json['isAdded'] as int,
      fLastUpdate: DateTime.parse(json['fLastUpdate'].toString()),
      fLastUpdateUser: json['fLastUpdateUser'] as int,
      fLastUpdateSum: json['fLastUpdateSum'] as int,
      fLastUpdateOper: json['fLastUpdateOper'] as int,
      fCompanyId: json['fCompanyId'] as int,
      fSeasonId: json['fSeasonId'] as int,
      fCenterNo: json['fCenterNo'] as int,
      fCenterCode: json['fCenterCode'].toString(),
      fCenterName: json['fCenterName'].toString(),
      fCenterNameE: json['fCenterNameE'].toString(),
      fCenterType: json['fCenterType'].toString(),
      fCenterEmail: json['fCenterEmail'].toString(),
      fCenterJaw: json['fCenterJaw'].toString(),
      fSectionNo: json['fSectionNo'] as int,
      fLatitudeMak:
          (json['fLatitudeMak'] != null)
              ? double.tryParse(json['fLatitudeMak'].toString())
              : null,
      fLongitudeMak:
          (json['fLongitudeMak'] != null)
              ? double.tryParse(json['fLongitudeMak'].toString())
              : null,
      fLatitudeArafat:
          (json['fLatitudeArafat'] != null)
              ? double.tryParse(json['fLatitudeArafat'].toString())
              : null,
      fLongitudeArafat:
          (json['fLongitudeArafat'] != null)
              ? double.tryParse(json['fLongitudeArafat'].toString())
              : null,
      fLatitudeMona:
          (json['fLatitudeMona'] != null)
              ? double.tryParse(json['fLatitudeMona'].toString())
              : null,
      fLongitudeMona:
          (json['fLongitudeMona'] != null)
              ? double.tryParse(json['fLongitudeMona'].toString())
              : null,
      fCenterStatus: json['fCenterStatus'] as int,
      fCenterTransport: json['fCenterTransport'] as int,
    );
  }
  final int isAdded;
  final DateTime fLastUpdate;
  final int fLastUpdateUser;
  final int fLastUpdateSum;
  final int fLastUpdateOper;
  final int fCompanyId;
  final int fSeasonId;
  final int fCenterNo;
  final String fCenterCode;
  final String fCenterName;
  final String? fCenterNameE;
  final String? fCenterType;
  final String? fCenterEmail;
  final String? fCenterJaw;
  final int fSectionNo;
  final double? fLatitudeMak;
  final double? fLongitudeMak;
  final double? fLatitudeArafat;
  final double? fLongitudeArafat;
  final double? fLatitudeMona;
  final double? fLongitudeMona;
  final int fCenterStatus;
  final int fCenterTransport;

  Map<String, dynamic> toJson() {
    return {
      'isAdded': isAdded,
      'fLastUpdate': fLastUpdate.toIso8601String(),
      'fLastUpdateUser': fLastUpdateUser,
      'fLastUpdateSum': fLastUpdateSum,
      'fLastUpdateOper': fLastUpdateOper,
      'fCompanyId': fCompanyId,
      'fSeasonId': fSeasonId,
      'fCenterNo': fCenterNo,
      'fCenterCode': fCenterCode,
      'fCenterName': fCenterName,
      'fCenterNameE': fCenterNameE,
      'fCenterType': fCenterType,
      'fCenterEmail': fCenterEmail,
      'fCenterJaw': fCenterJaw,
      'fSectionNo': fSectionNo,
      'fLatitudeMak': fLatitudeMak,
      'fLongitudeMak': fLongitudeMak,
      'fLatitudeArafat': fLatitudeArafat,
      'fLongitudeArafat': fLongitudeArafat,
      'fLatitudeMona': fLatitudeMona,
      'fLongitudeMona': fLongitudeMona,
      'fCenterStatus': fCenterStatus,
      'fCenterTransport': fCenterTransport,
    };
  }
}
