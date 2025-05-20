class Country {
  Country({
    required this.fCountryName,
    required this.fCountryNameE,
    required this.fNatiName,
    required this.fNatiNameE,
  });
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      fCountryName: json['fCountryName'].toString(),
      fCountryNameE: json['fCountryNameE'].toString(),
      fNatiName: json['fNatiName'].toString(),
      fNatiNameE: json['fNatiNameE'].toString(),
    );
  }
  final String fCountryName;
  final String fCountryNameE;
  final String fNatiName;
  final String fNatiNameE;

  Map<String, dynamic> toJson() {
    return {
      'fCountryName': fCountryName,
      'fCountryNameE': fCountryNameE,
      'fNatiName': fNatiName,
      'fNatiNameE': fNatiNameE,
    };
  }
}
