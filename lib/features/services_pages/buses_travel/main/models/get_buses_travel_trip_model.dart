class BusesTravelGetTripModel {
  BusesTravelGetTripModel({
    required this.fCompanyId,
    required this.company,
    required this.fSeasonId,
    required this.fCenterNo,
    required this.fStageNo,
    required this.transportStage,
    required this.fTripNo,
    required this.fTripDate,
    required this.fTripTime,
    required this.fBusId,
    required this.fPilgrimsAco,
    required this.fAdditionDate,
    required this.fAdditionUser,
    required this.additionUser,
    required this.fAdditionLatitude,
    required this.fAdditionLongitude,
    required this.fReceiptDate,
    required this.fReceiptUser,
    required this.receiptUser,
    required this.fReceiptLatitude,
    required this.fReceiptLongitude,
    required this.fTripStatus,
    required this.totalPilgrimsCount,
    required this.totalBusesCount,
    required this.totalTripsCount,
    required this.allocatedPilgrimsCount,
    required this.allocatedBusesCount,
    required this.allocatedTripsCount,
  });

  factory BusesTravelGetTripModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(String? dateStr) {
      if (dateStr == null || dateStr == '0001-01-01T00:00:00') return null;
      return DateTime.tryParse(dateStr);
    }

    return BusesTravelGetTripModel(
      fCompanyId: json['fCompanyId'].toString(),
      company: json['company']?.toString() ?? '',
      fSeasonId: json['fSeasonId'].toString(),
      fCenterNo: json['fCenterNo'].toString(),
      fStageNo: json['fStageNo'].toString(),
      transportStage: json['transportStage']?.toString() ?? '',
      fTripNo: json['fTripNo'].toString(),
      fTripDate: parseDate(json['fTripDate']?.toString()) ?? DateTime(2000),
      fTripTime: parseDate(json['fTripTime']?.toString()) ?? DateTime(2000),
      fBusId: json['fBusId'].toString(),
      fPilgrimsAco: json['fPilgrimsAco'].toString(),
      fAdditionDate:
          parseDate(json['fAdditionDate']?.toString()) ?? DateTime(2000),
      fAdditionUser: json['fAdditionUser'].toString(),
      additionUser: json['additionUser']?.toString(),
      fAdditionLatitude: json['fAdditionLatitude']?.toString(),
      fAdditionLongitude: json['fAdditionLongitude']?.toString(),
      fReceiptDate: parseDate(json['fReceiptDate']?.toString()),
      fReceiptUser: json['fReceiptUser']?.toString(),
      receiptUser: json['receiptUser']?.toString(),
      fReceiptLatitude: json['fReceiptLatitude']?.toString(),
      fReceiptLongitude: json['fReceiptLongitude']?.toString(),
      fTripStatus: json['fTripStatus'].toString(),
      totalPilgrimsCount: json['totalPilgrimsCount'].toString(),
      totalBusesCount: json['totalBusesCount'].toString(),
      totalTripsCount: json['totalTripsCount'].toString(),
      allocatedPilgrimsCount: json['allocatedPilgrimsCount'].toString(),
      allocatedBusesCount: json['allocatedBusesCount'].toString(),
      allocatedTripsCount: json['allocatedTripsCount'].toString(),
    );
  }

  final String fCompanyId;
  final String company;
  final String fSeasonId;
  final String fCenterNo;
  final String fStageNo;
  final String transportStage;
  final String fTripNo;
  final DateTime fTripDate;
  final DateTime fTripTime;
  final String fBusId;
  final String fPilgrimsAco;
  final DateTime fAdditionDate;
  final String fAdditionUser;
  final String? additionUser;
  final String? fAdditionLatitude;
  final String? fAdditionLongitude;
  final DateTime? fReceiptDate;
  final String? fReceiptUser;
  final String? receiptUser;
  final String? fReceiptLatitude;
  final String? fReceiptLongitude;
  final String fTripStatus;
  final String totalPilgrimsCount;
  final String totalBusesCount;
  final String totalTripsCount;
  final String allocatedPilgrimsCount;
  final String allocatedBusesCount;
  final String allocatedTripsCount;

  Map<String, dynamic> toJson() {
    return {
      'fCompanyId': fCompanyId,
      'company': company,
      'fSeasonId': fSeasonId,
      'fCenterNo': fCenterNo,
      'fStageNo': fStageNo,
      'transportStage': transportStage,
      'fTripNo': fTripNo,
      'fTripDate': fTripDate.toIso8601String(),
      'fTripTime': fTripTime.toIso8601String(),
      'fBusId': fBusId,
      'fPilgrimsAco': fPilgrimsAco,
      'fAdditionDate': fAdditionDate.toIso8601String(),
      'fAdditionUser': fAdditionUser,
      'additionUser': additionUser,
      'fAdditionLatitude': fAdditionLatitude,
      'fAdditionLongitude': fAdditionLongitude,
      'fReceiptDate': fReceiptDate,
      'fReceiptUser': fReceiptUser,
      'receiptUser': receiptUser,
      'fReceiptLatitude': fReceiptLatitude,
      'fReceiptLongitude': fReceiptLongitude,
      'fTripStatus': fTripStatus,
      'totalPilgrimsCount': totalPilgrimsCount,
      'totalBusesCount': totalBusesCount,
      'totalTripsCount': totalTripsCount,
      'allocatedPilgrimsCount': allocatedPilgrimsCount,
      'allocatedBusesCount': allocatedBusesCount,
      'allocatedTripsCount': allocatedTripsCount,
    };
  }
}
