import 'package:alrefadah/features/services_pages/buses_travel/add/models/transport_model.dart';

class BusModel {
  BusModel({
    required this.fBusId,
    required this.fCompanyName,
    required this.fCompanyId,
    required this.fBusIdTrip,
    required this.fBusNo,
    required this.fSeasonId,
    required this.fCenterNo,
    required this.fStageNo,
    required this.fTransportNo,
    required this.fOperatingNo,
    required this.fPilgrimsAco,
    required this.fTripAco,
    required this.fBusStatus,
    required this.fBusNote,
    required this.fAdditionDate,
    required this.fAdditionUser,
    required this.fReceiptDate,
    required this.fReceiptUser,
    this.transport,
  });

  factory BusModel.fromJson(Map<String, dynamic> json) {
    return BusModel(
      fBusId: json['fBusId'].toString(),
      fCompanyName: json['fCompanyName'].toString(),
      fCompanyId: json['fCompanyId'] as int,
      fBusIdTrip: json['fBusIdTrip'].toString(),
      fBusNo: json['fBusNo'].toString(),
      fSeasonId: json['fSeasonId'] as int,
      fCenterNo: json['fCenterNo'] as int,
      fStageNo: json['fStageNo'] as int,
      fTransportNo: json['fTransportNo'] as int,
      fOperatingNo: json['fOperatingNo'].toString(),
      fPilgrimsAco: json['fPilgrimsAco'] as int,
      fTripAco: json['fTripAco'] as int,
      fBusStatus: json['fBusStatus'] as int,
      fBusNote: json['fBusNote'].toString(),
      fAdditionDate: json['fAdditionDate'].toString(),
      fAdditionUser: json['fAdditionUser'] as int,
      fReceiptDate: json['fReceiptDate'].toString(),
      fReceiptUser: json['fReceiptUser'].toString(),
      transport:
          json['transport'] != null
              ? TransportModel.fromJson(
                json['transport'] as Map<String, dynamic>,
              )
              : null,
    );
  }
  final String fBusId;
  final String fCompanyName;
  final int fCompanyId;
  final String fBusIdTrip;
  final String fBusNo;
  final int fSeasonId;
  final int fCenterNo;
  final int fStageNo;
  final int fTransportNo;
  final String fOperatingNo;
  final int fPilgrimsAco;
  final int fTripAco;
  final int fBusStatus;
  final String fBusNote;
  final String fAdditionDate;
  final int fAdditionUser;
  final String fReceiptDate;
  final String? fReceiptUser;
  final TransportModel? transport;
}
