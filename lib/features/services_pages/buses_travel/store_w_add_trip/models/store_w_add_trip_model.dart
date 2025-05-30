class StoreWAddTripModel {
  StoreWAddTripModel({
    required this.bus,
    required this.operating,
    required this.trip,
  });
  final StoreWAddBus bus;
  final StoreWAddOperating operating;
  final StoreWAddTrip trip;

  Map<String, dynamic> toJson() {
    return {
      'bus': bus.toJson(),
      'operating': operating.toJson(),
      'trip': trip.toJson(),
    };
  }
}

class StoreWAddBus {
  StoreWAddBus({
    required this.fBusNo,
    required this.fCenterNo,
    required this.fSeasonId,
    required this.fBusStatus,
  });
  final String fBusNo;
  final int fCenterNo;
  final int fSeasonId;
  final int fBusStatus;

  Map<String, dynamic> toJson() {
    return {
      'fBusNo': fBusNo,
      'fCenterNo': fCenterNo,
      'fSeasonId': fSeasonId,
      'fBusStatus': fBusStatus,
    };
  }
}

class StoreWAddOperating {
  StoreWAddOperating({required this.fOperatingNo});
  final String fOperatingNo;

  Map<String, dynamic> toJson() {
    return {'fOperatingNo': fOperatingNo};
  }
}

class StoreWAddTrip {
  StoreWAddTrip({
    required this.fBusId,
    required this.fSeasonId,
    required this.fStageNo,
    required this.fEmpNo,
    required this.fAdditionLatitude,
    required this.fAdditionLongitude,
    required this.fAdditionUser,
    required this.fTrackNo,
  });
  final int fBusId;
  final int fSeasonId;
  final int fStageNo;
  int? fEmpNo;
  final String fAdditionLatitude;
  final String fAdditionLongitude;
  final int fAdditionUser;
  final int fTrackNo;

  Map<String, dynamic> toJson() {
    return {
      'fBusId': fBusId,
      'fSeasonId': fSeasonId,
      'fStageNo': fStageNo,
      'fEmpNo': fEmpNo,
      'fAdditionLatitude': fAdditionLatitude,
      'fAdditionLongitude': fAdditionLongitude,
      'fAdditionUser': fAdditionUser,
      'fTrackNo': fTrackNo,
    };
  }
}
