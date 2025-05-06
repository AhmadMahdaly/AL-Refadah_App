import 'package:alrefadah/features/services_pages/buses_travel/add/models/bus_travel_company_model_by_stage_model.dart';
import 'package:alrefadah/features/services_pages/buses_travel/add/models/bus_travel_user_model_by_stage_model.dart';
import 'package:alrefadah/features/services_pages/transport_stage/models/stage_model.dart';

class TripModel {
  TripModel({
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
    required this.fTripStatus,
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
      fTripStatus: json['fTripStatus'].toString(),
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
    );
  }
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
  final String fTripStatus;
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
}
