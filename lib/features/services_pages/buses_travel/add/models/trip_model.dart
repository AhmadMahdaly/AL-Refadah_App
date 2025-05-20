import 'package:alrefadah/features/services_pages/buses_travel/add/models/bus_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/company_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/user_model.dart';
import 'package:alrefadah/features/services_pages/transport_stage/models/stage_model.dart';
import 'package:flutter/foundation.dart';

@immutable
class TripModel {
  const TripModel({
    required this.fCompanyId,
    required this.fSeasonId,
    required this.fCenterNo,
    required this.fStageNo,
    required this.fTripNo,
    required this.fTripDate,
    required this.fTripTime,
    required this.fBusId,
    required this.fPilgrimsAco,
    required this.fAdditionDate,
    required this.fAdditionUser,
    required this.fAdditionLatitude,
    required this.fAdditionLongitude,
    required this.fReceiptDate,
    required this.fReceiptUser,
    required this.fReceiptLatitude,
    required this.fReceiptLongitude,
    required this.fTripStstus,
    required this.totalPilgrimsCount,
    required this.totalBusesCount,
    required this.totalTripsCount,
    required this.allocatedPilgrimsCount,
    required this.allocatedBusesCount,
    required this.allocatedTripsCount,
    required this.company,
    required this.transportStage,
    required this.additionUser,
    required this.receiptUser,
    required this.delete,
    required this.insert,
    required this.update,
    required this.fApprovalDate,
    required this.fApprovalLatitude,
    required this.fApprovalLongitude,
    required this.fApprovalUser,
    required this.fEmpNo,
    required this.fTrackNo,
    required this.fBus,
    required this.busOccurrencesCount,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      fCompanyId: json['fCompanyId'].toString(),
      fSeasonId: json['fSeasonId'].toString(),
      fCenterNo: json['fCenterNo'].toString(),
      fStageNo: json['fStageNo'].toString(),
      fTripNo: json['fTripNo'].toString(),
      fTripDate: json['fTripDate'].toString(),
      fTripTime: json['fTripTime'].toString(),
      fBusId: json['fBusId'].toString(),
      fPilgrimsAco: json['fPilgrimsAco'].toString(),
      fAdditionDate: DateTime.parse(json['fAdditionDate'].toString()),
      fAdditionUser: json['fAdditionUser'].toString(),
      fAdditionLatitude: json['fAdditionLatitude'].toString(),
      fAdditionLongitude: json['fAdditionLongitude'].toString(),
      fReceiptDate: json['fReceiptDate'].toString(),
      fReceiptUser: json['fReceiptUser'].toString(),
      fReceiptLatitude: json['fReceiptLatitude'].toString(),
      fReceiptLongitude: json['fReceiptLongitude'].toString(),
      fTripStstus: json['fTripStstus'].toString(),
      totalPilgrimsCount: json['totalPilgrimsCount'].toString(),
      totalBusesCount: json['totalBusesCount'].toString(),
      totalTripsCount: json['totalTripsCount'].toString(),
      allocatedPilgrimsCount: json['allocatedPilgrimsCount'].toString(),
      allocatedBusesCount: json['allocatedBusesCount'].toString(),
      allocatedTripsCount: json['allocatedTripsCount'].toString(),
      company: CompanyModel.fromJson(json['company'] as Map<String, dynamic>),
      transportStage: StageModel.fromJson(
        json['transportStage'] as Map<String, dynamic>,
      ),
      additionUser: UserModel.fromJson(
        json['additionUser'] as Map<String, dynamic>,
      ),
      receiptUser: UserModel.fromJson(
        json['receiptUser'] as Map<String, dynamic>,
      ),
      insert: json['insert'].toString(),
      update: json['update'].toString(),
      delete: json['delete'].toString(),

      fEmpNo: int.tryParse(json['fEmpNo']?.toString() ?? ''),
      fApprovalDate: json['fApprovalDate'].toString(),
      fApprovalLongitude: json['fApprovalLongitude'].toString(),
      fApprovalLatitude: json['fApprovalLatitude'].toString(),
      fApprovalUser: json['fApprovalUser'].toString(),
      fTrackNo: int.tryParse(json['fTrackNo']?.toString() ?? ''),
      fBus: BusModel.fromJson(json['fBus'] as Map<String, dynamic>),
      busOccurrencesCount: json['busOccurrencesCount'].toString(),
    );
  }
  final int? fTrackNo;
  final String insert;
  final String update;
  final String delete;
  final String fCompanyId;
  final String fSeasonId;
  final String fCenterNo;
  final String fStageNo;
  final String fTripNo;
  final String fTripDate;
  final String fTripTime;
  final String fBusId;
  final String fPilgrimsAco;
  final DateTime fAdditionDate;
  final String fAdditionUser;
  final String fAdditionLatitude;
  final String fAdditionLongitude;
  final String fReceiptDate;
  final String fReceiptUser;
  final String fReceiptLatitude;
  final String fReceiptLongitude;
  final String fTripStstus;
  final String busOccurrencesCount;
  final String totalPilgrimsCount;
  final String totalBusesCount;
  final String totalTripsCount;
  final String allocatedPilgrimsCount;
  final String allocatedBusesCount;
  final String allocatedTripsCount;
  final CompanyModel company;
  final StageModel transportStage;
  final UserModel additionUser;
  final UserModel receiptUser;
  final BusModel fBus;
  final int? fEmpNo;
  final String fApprovalDate;
  final String fApprovalUser;
  final String fApprovalLatitude;
  final String fApprovalLongitude;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripModel &&
          runtimeType == other.runtimeType &&
          fBus.fBusNo == other.fBus.fBusNo;

  @override
  int get hashCode => fBus.fBusNo.hashCode;
}
