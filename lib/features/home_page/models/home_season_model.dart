class HomeSeasonModel {
  HomeSeasonModel({
    required this.fLastUpdate,
    required this.fLastUpdateUser,
    required this.fLastUpdateSum,
    required this.fLastUpdateOper,
    required this.fSeasonId,
    required this.fSeasonName,
    required this.fSeasonDateFromH,
    required this.fSeasonDateToH,
    required this.fSeasonDateFromM,
    required this.fSeasonDateToM,
    required this.fHajDateFromH,
    required this.fHajDateToH,
    required this.fHajDateFromM,
    required this.fHajDateToM,
    this.fSeasonNameE,
  });

  factory HomeSeasonModel.fromJson(Map<String, dynamic> json) {
    return HomeSeasonModel(
      fLastUpdate: DateTime.parse(json['fLastUpdate'].toString()),
      fLastUpdateUser: json['fLastUpdateUser'] as int,
      fLastUpdateSum: json['fLastUpdateSum'] as int,
      fLastUpdateOper: json['fLastUpdateOper'] as int,
      fSeasonId: json['fSeasonId'] as int,
      fSeasonName: json['fSeasonName'].toString(),
      fSeasonNameE: json['fSeasonNameE'].toString(),
      fSeasonDateFromH: json['fSeasonDateFromH'].toString(),
      fSeasonDateToH: json['fSeasonDateToH'].toString(),
      fSeasonDateFromM: json['fSeasonDateFromM'].toString(),
      fSeasonDateToM: json['fSeasonDateToM'].toString(),
      fHajDateFromH: json['fHajDateFromH'].toString(),
      fHajDateToH: json['fHajDateToH'].toString(),
      fHajDateFromM: json['fHajDateFromM'].toString(),
      fHajDateToM: json['fHajDateToM'].toString(),
    );
  }
  final DateTime fLastUpdate;
  final int fLastUpdateUser;
  final int fLastUpdateSum;
  final int fLastUpdateOper;
  final int fSeasonId;
  final String fSeasonName;
  final String? fSeasonNameE;
  final String fSeasonDateFromH;
  final String fSeasonDateToH;
  final String fSeasonDateFromM;
  final String fSeasonDateToM;
  final String fHajDateFromH;
  final String fHajDateToH;
  final String fHajDateFromM;
  final String fHajDateToM;

  // Map<String, dynamic> toJson() {
  //   return {
  //     'fLastUpdate': fLastUpdate.toIso8601String(),
  //     'fLastUpdateUser': fLastUpdateUser,
  //     'fLastUpdateSum': fLastUpdateSum,
  //     'fLastUpdateOper': fLastUpdateOper,
  //     'fSeasonId': fSeasonId,
  //     'fSeasonName': fSeasonName,
  //     'fSeasonNameE': fSeasonNameE,
  //     'fSeasonDateFromH': fSeasonDateFromH,
  //     'fSeasonDateToH': fSeasonDateToH,
  //     'fSeasonDateFromM': fSeasonDateFromM,
  //     'fSeasonDateToM': fSeasonDateToM,
  //     'fHajDateFromH': fHajDateFromH,
  //     'fHajDateToH': fHajDateToH,
  //     'fHajDateFromM': fHajDateFromM,
  //     'fHajDateToM': fHajDateToM,
  //   };
  // }

  @override
  String toString() {
    return 'SeasonModel(fSeasonId: $fSeasonId, fSeasonName: $fSeasonName)';
  }
}
