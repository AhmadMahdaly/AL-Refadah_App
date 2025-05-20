class TransportModel {
  TransportModel({
    required this.fTransportNo,
    required this.fTransportName,
    required this.fTransportNameE,
    required this.fTransportMin,
    required this.fTransportStatus,
  });

  factory TransportModel.fromJson(Map<String, dynamic> json) {
    return TransportModel(
      fTransportNo: json['fTransportNo'].toString(),
      fTransportName: json['fTransportName'].toString(),
      fTransportNameE: json['fTransportNameE'].toString(),
      fTransportMin: json['fTransportMin'].toString(),
      fTransportStatus: json['fTransportStatus'].toString(),
    );
  }
  final String fTransportNo;
  final String fTransportName;
  final String fTransportNameE;
  final String fTransportMin;
  final String fTransportStatus;

  Map<String, dynamic> toJson() {
    return {
      'fTransportNo': fTransportNo,
      'fTransportName': fTransportName,
      'fTransportNameE': fTransportNameE,
      'fTransportMin': fTransportMin,
      'fTransportStatus': fTransportStatus,
    };
  }
}
