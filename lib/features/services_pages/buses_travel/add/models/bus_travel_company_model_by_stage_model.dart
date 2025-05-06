class CompanyModel {
  CompanyModel({
    required this.fCompanyId,
    required this.fCompanyName,
    required this.fCompanyNameE,
    required this.fUnifiedNo,
    required this.fIdNo,
    required this.fVatNo,
    required this.fEmail,
    required this.fJawNo,
    required this.fBankNo,
    required this.fBankIban,
    required this.fAddress,
    required this.fCityNo,
    required this.fBuildingNo,
    required this.fSecondaryNo,
    required this.fPostalCode,
    required this.fCompanyStatus,
    required this.fDomain,
    required this.fCeoJob,
    required this.fCeoName,
    required this.fCeoJaw,
    required this.fCeoEmail,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      fCompanyId: json['fCompanyId'].toString(),
      fCompanyName: json['fCompanyName'].toString(),
      fCompanyNameE: json['fCompanyNameE'].toString(),
      fUnifiedNo: json['fUnifiedNo'].toString(),
      fIdNo: json['fIdNo'].toString(),
      fVatNo: json['fVatNo'].toString(),
      fEmail: json['fEmail'].toString(),
      fJawNo: json['fJawNo'].toString(),
      fBankNo: json['fBankNo'].toString(),
      fBankIban: json['fBankIban'].toString(),
      fAddress: json['fAddress'].toString(),
      fCityNo: json['fCityNo'].toString(),
      fBuildingNo: json['fBuildingNo'].toString(),
      fSecondaryNo: json['fSecondaryNo'].toString(),
      fPostalCode: json['fPostalCode'].toString(),
      fCompanyStatus: json['fCompanyStatus'].toString(),
      fDomain: json['fDomain'].toString(),
      fCeoJob: json['fCeoJob'].toString(),
      fCeoName: json['fCeoName'].toString(),
      fCeoJaw: json['fCeoJaw'].toString(),
      fCeoEmail: json['fCeoEmail'].toString(),
    );
  }
  final String fCompanyId;
  final String fCompanyName;
  final String fCompanyNameE;
  final String fUnifiedNo;
  final String fIdNo;
  final String fVatNo;
  final String fEmail;
  final String fJawNo;
  final String fBankNo;
  final String fBankIban;
  final String fAddress;
  final String fCityNo;
  final String fBuildingNo;
  final String fSecondaryNo;
  final String fPostalCode;
  final String fCompanyStatus;
  final String fDomain;
  final String fCeoJob;
  final String fCeoName;
  final String fCeoJaw;
  final String fCeoEmail;
}
