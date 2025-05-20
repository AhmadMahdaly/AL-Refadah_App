import 'package:alrefadah/features/services_pages/guides/main/models/by_criteria/country_model.dart';

class Employee {
  Employee({
    required this.fEmpNo,
    required this.fEmpName,
    required this.fEmpNameE,
    required this.fEmpFirst,
    required this.fEmpFather,
    required this.fEmpGrandfather,
    required this.fEmpFamily,
    required this.fJawNo,
    required this.fEmail,
    required this.fBirthDate,
    required this.fGender,
    required this.fIdNo,
    required this.country,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      fEmpNo: json['fEmpNo'] as int,
      fEmpName: json['fEmpName'].toString(),
      fEmpNameE: json['fEmpNameE'].toString(),
      fEmpFirst: json['fEmpFirst'].toString(),
      fEmpFather: json['fEmpFather'].toString(),
      fEmpGrandfather: json['fEmpGrandfather'].toString(),
      fEmpFamily: json['fEmpFamily'].toString(),
      fJawNo: json['fJawNo'].toString(),
      fEmail: json['fEmail'].toString(),
      fBirthDate: json['fBirthDate'].toString(),
      fGender: json['fGender'] as int,
      fIdNo: json['fIdNo'] as int,
      country:
          json['country'] != null
              ? Country.fromJson(json['country'] as Map<String, dynamic>)
              : null,
    );
  }
  final int fEmpNo;
  final String fEmpName;
  final String fEmpNameE;
  final String fEmpFirst;
  final String fEmpFather;
  final String fEmpGrandfather;
  final String fEmpFamily;
  final String fJawNo;
  final String fEmail;
  final String fBirthDate;
  final int fGender;
  final int fIdNo;
  final Country? country;

  Map<String, dynamic> toJson() {
    return {
      'fEmpNo': fEmpNo,
      'fEmpName': fEmpName,
      'fEmpNameE': fEmpNameE,
      'fEmpFirst': fEmpFirst,
      'fEmpFather': fEmpFather,
      'fEmpGrandfather': fEmpGrandfather,
      'fEmpFamily': fEmpFamily,
      'fJawNo': fJawNo,
      'fEmail': fEmail,
      'fBirthDate': fBirthDate,
      'fGender': fGender,
      'fIdNo': fIdNo,
      'country': country?.toJson(),
    };
  }
}
