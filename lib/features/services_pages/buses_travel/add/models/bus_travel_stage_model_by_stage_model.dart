class StageModel {
  StageModel({
    required this.fStageNo,
    required this.fStageName,
    required this.fStageNameFrom,
    required this.fStageNameTo,
    required this.fStageNameE,
    required this.fStageNameFromE,
    required this.fStageNameToE,
    required this.fStageDayNo,
    required this.fStageStatus,
  });

  factory StageModel.fromJson(Map<String, dynamic> json) {
    return StageModel(
      fStageNo: json['fStageNo'].toString(),
      fStageName: json['fStageName'].toString(),
      fStageNameFrom: json['fStageNameFrom'].toString(),
      fStageNameTo: json['fStageNameTo'].toString(),
      fStageNameE: json['fStageNameE'].toString(),
      fStageNameFromE: json['fStageNameFromE'].toString(),
      fStageNameToE: json['fStageNameToE'].toString(),
      fStageDayNo: json['fStageDayNo'].toString(),
      fStageStatus: json['fStageStatus'].toString(),
    );
  }
  final String fStageNo;
  final String fStageName;
  final String fStageNameFrom;
  final String fStageNameTo;
  final String fStageNameE;
  final String fStageNameFromE;
  final String fStageNameToE;
  final String fStageDayNo;
  final String fStageStatus;
}
