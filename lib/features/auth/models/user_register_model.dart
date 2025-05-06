class UserRegisterModel {
  UserRegisterModel({
    required this.fUserType,
    required this.fUserCode,
    required this.fUserPass,
    required this.fUserName,
    required this.fIdNo,
    required this.fJawNo,
    required this.fEmail,
    required this.fVerificatOption,
    required this.fSectionNo,
    required this.fUserStatus,
    required this.fCompanyId,
    required this.fCenterNo,
  });

  factory UserRegisterModel.fromJson(Map<String, dynamic> json) {
    return UserRegisterModel(
      fUserType: json['fUserType'] as int,
      fUserCode: json['fUserCode'].toString(),
      fUserPass: json['fUserPass'].toString(),
      fUserName: json['fUserName'].toString(),
      fIdNo: json['fIdNo'] as int,
      fJawNo: json['fJawNo'].toString(),
      fEmail: json['fEmail'].toString(),
      fVerificatOption: json['fVerificatOption'] as int,
      fSectionNo: json['fSectionNo'] as int,
      fUserStatus: json['fUserStatus'] as int,
      fCompanyId: json['fCompanyId'] as int,
      fCenterNo: json['fCenterNo'] as int,
    );
  }
  final int fUserType;
  final String fUserCode;
  final String fUserPass;
  final String fUserName;
  final int fIdNo;
  final String fJawNo;
  final String fEmail;
  final int fVerificatOption;
  final int fSectionNo;
  final int fUserStatus;
  final int fCompanyId;
  final int fCenterNo;

  Map<String, dynamic> toJson() {
    return {
      'fUserType': fUserType,
      'fUserCode': fUserCode,
      'fUserPass': fUserPass,
      'fUserName': fUserName,
      'fIdNo': fIdNo,
      'fJawNo': fJawNo,
      'fEmail': fEmail,
      'fVerificatOption': fVerificatOption,
      'fSectionNo': fSectionNo,
      'fUserStatus': fUserStatus,
      'fCompanyId': fCompanyId,
      'fCenterNo': fCenterNo,
    };
  }
}
