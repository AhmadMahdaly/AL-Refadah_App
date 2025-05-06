class BusModel {
  BusModel({
    required this.fBusId,
    required this.fCompanyName,
    required this.fCompanyId,
  });

  factory BusModel.fromJson(Map<String, dynamic> json) {
    return BusModel(
      fBusId: json['fBusId'] as int,
      fCompanyName: json['fCompanyName'].toString(),
      fCompanyId: json['fCompanyId'] as int,
    );
  }
  final int fBusId;
  final String fCompanyName;
  final int fCompanyId;
}
