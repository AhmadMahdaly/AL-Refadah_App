import 'package:alrefadah/features/services_pages/transport_stage/models/stage_model.dart';

class DelayedTripModel {
  DelayedTripModel({
    this.lastUpdate,
    this.lastUpdateUser,
    this.lastUpdateSum,
    this.lastUpdateOper,
    this.companyId,
    this.seasonId,
    this.centerNo,
    this.stageNo,
    this.tripNo,
    this.tripDate,
    this.tripTime,
    this.busId,
    this.pilgrimsAco,
    this.additionDate,
    this.additionUser,
    this.additionLatitude,
    this.additionLongitude,
    this.receiptDate,
    this.receiptUser,
    this.receiptLatitude,
    this.receiptLongitude,
    this.tripStatus,
    this.transportStage,
  });

  factory DelayedTripModel.fromJson(Map<String, dynamic> json) {
    return DelayedTripModel(
      lastUpdate:
          json['fLastUpdate'] != null
              ? DateTime.parse(json['fLastUpdate'].toString())
              : null,
      lastUpdateUser: json['fLastUpdateUser'].toString(),
      lastUpdateSum: json['fLastUpdateSum'].toString(),
      lastUpdateOper: json['fLastUpdateOper'].toString(),
      companyId: json['fCompanyId'].toString(),
      seasonId: json['fSeasonId'].toString(),
      centerNo: json['fCenterNo'].toString(),
      stageNo: json['fStageNo'].toString(),
      tripNo: json['fTripNo'].toString(),
      tripDate: json['fTripDate'].toString(),
      tripTime:
          json['fTripTime'] != null
              ? DateTime.parse(json['fTripTime'].toString())
              : null,
      busId: json['fBusId'].toString(),
      pilgrimsAco: json['fPilgrimsAco'].toString(),
      additionDate:
          json['fAdditionDate'] != null
              ? DateTime.parse(json['fAdditionDate'].toString())
              : null,
      additionUser: json['fAdditionUser'].toString(),
      additionLatitude: json['fAdditionLatitude'].toString(),
      additionLongitude: json['fAdditionLongitude'].toString(),
      receiptDate:
          json['fReceiptDate'] != null
              ? DateTime.parse(json['fReceiptDate'].toString())
              : null,
      receiptUser: json['fReceiptUser'].toString(),
      receiptLatitude: json['fReceiptLatitude'].toString(),
      receiptLongitude: json['fReceiptLongitude'].toString(),
      tripStatus: json['fTripStstus'].toString(),
      transportStage:
          json['transportStage'] != null
              ? StageModel.fromJson(
                json['transportStage'] as Map<String, dynamic>,
              )
              : null,
    );
  }
  final DateTime? lastUpdate;
  final String? lastUpdateUser;
  final String? lastUpdateSum;
  final String? lastUpdateOper;
  final String? companyId;
  final String? seasonId;
  final String? centerNo;
  final String? stageNo;
  final String? tripNo;
  final String? tripDate;
  final DateTime? tripTime;
  final String? busId;
  final String? pilgrimsAco;
  final DateTime? additionDate;
  final String? additionUser;
  final String? additionLatitude;
  final String? additionLongitude;
  final DateTime? receiptDate;
  final String? receiptUser;
  final String? receiptLatitude;
  final String? receiptLongitude;
  final String? tripStatus;
  final StageModel? transportStage;
}
