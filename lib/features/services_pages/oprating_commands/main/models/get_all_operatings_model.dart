class GetAllOperatingsModel {
  GetAllOperatingsModel({
    required this.fLastUpdateUser,
    required this.fLastUpdateSum,
    required this.fLastUpdateOper,
    required this.fCompanyId,
    required this.fSeasonId,
    required this.fOperatingNo,
    required this.fTransportType,
    required this.fBusAco,
    required this.fOperatingStatus,
    required this.fCenterNo,
    required this.busReceiptCount,
    this.center,
  });

  factory GetAllOperatingsModel.fromJson(Map<String, dynamic> json) {
    return GetAllOperatingsModel(
      busReceiptCount: json['busReceiptCount'] as int,
      fLastUpdateUser: json['fLastUpdateUser'] as int,
      fLastUpdateSum: json['fLastUpdateSum'] as int,
      fLastUpdateOper: json['fLastUpdateOper'] as int,
      fCompanyId: json['fCompanyId'] as int,
      fSeasonId: json['fSeasonId'] as int,
      fOperatingNo: json['fOperatingNo'].toString(),
      fTransportType: json['fTransportType'] as int,
      fBusAco: json['fBusAco'] as int,
      fOperatingStatus: json['fOperatingStatus'] as int,
      fCenterNo: json['fCenterNo'] as int,
      center: CenterOprModel.fromJson(json['center'] as Map<String, dynamic>),
    );
  }
  final String fOperatingNo;
  final int fTransportType;
  final int fBusAco;
  final int fOperatingStatus;
  final int fCenterNo;
  final int fLastUpdateUser;
  final int fLastUpdateSum;
  final int fLastUpdateOper;
  final int fCompanyId;
  final int fSeasonId;
  final int busReceiptCount;
  final CenterOprModel? center;

  Map<String, dynamic> toJson() {
    return {
      'fLastUpdateUser': fLastUpdateUser,
      'fLastUpdateSum': fLastUpdateSum,
      'fLastUpdateOper': fLastUpdateOper,
      'fCompanyId': fCompanyId,
      'fSeasonId': fSeasonId,
      'fOperatingNo': fOperatingNo,
      'fTransportType': fTransportType,
      'fBusAco': fBusAco,
      'fOperatingStatus': fOperatingStatus,
      'fCenterNo': fCenterNo,
      'center': center?.toJson(),
    };
  }
}

class CenterOprModel {
  CenterOprModel({
    required this.isAdded,
    required this.fCenterCode,
    required this.fCenterName,
    required this.fCenterNameE,
    required this.fCenterType,
    required this.fCenterEmail,
    required this.fCenterJaw,
    required this.fLatitudeMak,
    required this.fLongitudeMak,
    required this.fLatitudeArafat,
    required this.fLongitudeArafat,
    required this.fLatitudeMona,
    required this.fLongitudeMona,
    required this.fCenterTransport,
    required this.fLastUpdateUser,
    required this.fLastUpdateSum,
    required this.fLastUpdateOper,
    required this.fCompanyId,
    required this.fSeasonId,
    required this.fCenterNo,
    required this.fSectionNo,
    required this.fCenterStatus,
    required this.fLastUpdate,
  });

  factory CenterOprModel.fromJson(Map<String, dynamic> json) {
    return CenterOprModel(
      isAdded: json['isAdded'].toString(),
      fCenterCode: json['fCenterCode'].toString(),
      fCenterName: json['fCenterName'].toString(),
      fCenterNameE: json['fCenterNameE'].toString(),
      fCenterType: json['fCenterType'].toString(),
      fCenterEmail: json['fCenterEmail'].toString(),
      fCenterJaw: json['fCenterJaw'].toString(),
      fLatitudeMak: json['fLatitudeMak'].toString(),
      fLongitudeMak: json['fLongitudeMak'].toString(),
      fLatitudeArafat: json['fLatitudeArafat'].toString(),
      fLongitudeArafat: json['fLongitudeArafat'].toString(),
      fLatitudeMona: json['fLatitudeMona'].toString(),
      fLongitudeMona: json['fLongitudeMona'].toString(),
      fCenterTransport: json['fCenterTransport'].toString(),
      fLastUpdateUser: json['fLastUpdateUser'].toString(),
      fLastUpdateSum: json['fLastUpdateSum'].toString(),
      fLastUpdateOper: json['fLastUpdateOper'].toString(),
      fCompanyId: json['fCompanyId'].toString(),
      fSeasonId: json['fSeasonId'].toString(),
      fCenterNo: json['fCenterNo'].toString(),
      fSectionNo: json['fSectionNo'].toString(),
      fCenterStatus: json['fCenterStatus'].toString(),
      fLastUpdate: DateTime.parse(json['fLastUpdate'].toString()),
    );
  }
  final String isAdded;
  final String fCenterCode;
  final String fCenterName;
  final String fCenterNameE;
  final String fCenterType;
  final String fCenterEmail;
  final String fCenterJaw;
  final String fLatitudeMak;
  final String fLongitudeMak;
  final String fLatitudeArafat;
  final String fLongitudeArafat;
  final String fLatitudeMona;
  final String fLongitudeMona;
  final String fCenterTransport;
  DateTime fLastUpdate = DateTime.now();
  final String fLastUpdateUser;
  final String fLastUpdateSum;
  final String fLastUpdateOper;
  final String fCompanyId;
  final String fSeasonId;
  final String fCenterNo;
  final String fSectionNo;
  final String fCenterStatus;

  Map<String, dynamic> toJson() {
    return {
      'isAdded': isAdded,
      'fCenterCode': fCenterCode,
      'fCenterName': fCenterName,
      'fCenterNameE': fCenterNameE,
      'fCenterType': fCenterType,
      'fCenterEmail': fCenterEmail,
      'fCenterJaw': fCenterJaw,
      'fLatitudeMak': fLatitudeMak,
      'fLongitudeMak': fLongitudeMak,
      'fLatitudeArafat': fLatitudeArafat,
      'fLongitudeArafat': fLongitudeArafat,
      'fLatitudeMona': fLatitudeMona,
      'fLongitudeMona': fLongitudeMona,
      'fCenterTransport': fCenterTransport,
      'fLastUpdate': fLastUpdate.toIso8601String(),
      'fLastUpdateUser': fLastUpdateUser,
      'fLastUpdateSum': fLastUpdateSum,
      'fLastUpdateOper': fLastUpdateOper,
      'fCompanyId': fCompanyId,
      'fSeasonId': fSeasonId,
      'fCenterNo': fCenterNo,
      'fSectionNo': fSectionNo,
      'fCenterStatus': fCenterStatus,
    };
  }
}

class CenterModel {
  CenterModel({
    required this.fCenterNo,
    required this.fCenterName,
    required this.fCenterCode,
    required this.fCenterStatus,
    required this.fSectionNo,
    required this.fLastUpdateUser,
    required this.fLastUpdateSum,
    required this.fLastUpdateOper,
    required this.fCenterEmail,
    required this.fCenterJaw,
    required this.fLatitudeMak,
    required this.fLongitudeMak,
    required this.fLatitudeArafat,
    required this.fLongitudeArafat,
    required this.fLatitudeMona,
    required this.fLongitudeMona,
    required this.fCenterNameE,
    required this.fCenterType,
    required this.fCenterTransport,
    required this.fCompanyId,
    required this.fSeasonId,
    required this.fLastUpdate,
  });

  factory CenterModel.fromJson(Map<String, dynamic> json) {
    return CenterModel(
      fLastUpdate: DateTime.parse(json['fLastUpdate'].toString()),
      fCenterNo: json['fCenterNo'] as int,
      fCenterName: json['fCenterName'].toString(),
      fCenterCode: json['fCenterCode'].toString(),
      fCenterStatus: json['fCenterStatus'] as int,
      fSectionNo: json['fSectionNo'] as int,
      fCenterEmail: json['fCenterEmail'].toString(),
      fCenterJaw: json['fCenterJaw'].toString(),
      fLatitudeMak: json['fLatitudeMak'].toString(),
      fLongitudeMak: json['fLongitudeMak'].toString(),
      fLatitudeArafat: json['fLatitudeArafat'].toString(),
      fLongitudeArafat: json['fLongitudeArafat'].toString(),
      fLatitudeMona: json['fLatitudeMona'].toString(),
      fLongitudeMona: json['fLongitudeMona'].toString(),
      fCenterNameE: json['fCenterNameE'].toString(),
      fCenterType: json['fCenterType'].toString(),
      fCenterTransport: json['fCenterTransport'] as int,
      fCompanyId: json['fCompanyId'] as int,
      fSeasonId: json['fSeasonId'] as int,
      fLastUpdateUser: json['fLastUpdateUser'] as int,
      fLastUpdateSum: json['fLastUpdateSum'] as int,
      fLastUpdateOper: json['fLastUpdateOper'] as int,
    );
  }
  final String? fCenterNameE;
  final int fCenterNo;
  final String fCenterName;
  final String? fCenterEmail;
  final String? fCenterJaw;
  final String fCenterCode;
  final int fCenterStatus;
  final int fSectionNo;
  final String fLatitudeMak;
  final String fLongitudeMak;
  final String fLatitudeArafat;
  final String fLongitudeArafat;
  final String fLatitudeMona;
  final String fLongitudeMona;
  final String fCenterType;
  final int fCenterTransport;
  final int fCompanyId;
  final int fSeasonId;
  DateTime fLastUpdate = DateTime.now();
  final int fLastUpdateUser;
  final int fLastUpdateSum;
  final int fLastUpdateOper;
}
