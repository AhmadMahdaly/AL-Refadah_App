class StageModel {
  StageModel({
    required this.fLastUpdate,
    required this.fLastUpdateUser,
    required this.fLastUpdateSum,
    required this.fLastUpdateOper,
    required this.fStageNo,
    required this.fStageName,
    required this.fStageNameFrom,
    required this.fStageNameTo,
    required this.fStageDayNo,
    required this.fStageStatus,
    this.fStageNameE,
    this.fStageNameFromE,
    this.fStageNameToE,
  });

  factory StageModel.fromJson(Map<String, dynamic> json) {
    return StageModel(
      fLastUpdate: DateTime.parse(json['fLastUpdate'].toString()),
      fLastUpdateUser: json['fLastUpdateUser'] as int,
      fLastUpdateSum: json['fLastUpdateSum'] as int,
      fLastUpdateOper: json['fLastUpdateOper'] as int,
      fStageNo: json['fStageNo'] as int,
      fStageName: json['fStageName'].toString(),
      fStageNameFrom: json['fStageNameFrom'].toString(),
      fStageNameTo: json['fStageNameTo'].toString(),
      fStageNameE: json['fStageNameE'].toString(),
      fStageNameFromE: json['fStageNameFromE'].toString(),
      fStageNameToE: json['fStageNameToE'].toString(),
      fStageDayNo: json['fStageDayNo'] as int,
      fStageStatus: json['fStageStatus'] as int,
    );
  }
  final DateTime fLastUpdate;
  final int fLastUpdateUser;
  final int fLastUpdateSum;
  final int fLastUpdateOper;
  final int fStageNo;
  final String fStageName;
  final String fStageNameFrom;
  final String fStageNameTo;
  final String? fStageNameE;
  final String? fStageNameFromE;
  final String? fStageNameToE;
  final int fStageDayNo;
  int fStageStatus;

  Map<String, dynamic> toJson() {
    return {
      'fLastUpdate': fLastUpdate.toIso8601String(),
      'fLastUpdateUser': fLastUpdateUser,
      'fLastUpdateSum': fLastUpdateSum,
      'fLastUpdateOper': fLastUpdateOper,
      'fStageNo': fStageNo,
      'fStageName': fStageName,
      'fStageNameFrom': fStageNameFrom,
      'fStageNameTo': fStageNameTo,
      'fStageNameE': fStageNameE,
      'fStageNameFromE': fStageNameFromE,
      'fStageNameToE': fStageNameToE,
      'fStageDayNo': fStageDayNo,
      'fStageStatus': fStageStatus,
    };
  }
}
