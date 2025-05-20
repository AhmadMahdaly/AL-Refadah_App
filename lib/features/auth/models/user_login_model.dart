class LoginResponse {
  LoginResponse({
    required this.success,
    required this.accessToken,
    required this.role,
    required this.user,
    required this.userId,
    this.errorMessage,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] as bool,
      accessToken: json['accessToken'].toString(),
      role: Role.fromJson(json['role'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      userId: json['userId'] as int,
      errorMessage: json['errorMessage'].toString(),
    );
  }
  final bool success;
  final String accessToken;
  final Role role;
  final User user;
  final int userId;
  final String? errorMessage;
}

class Role {
  Role({required this.fPermName, required this.fPermNo});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      fPermName: json['fPermName'].toString(),
      fPermNo: json['fPermNo'] as int,
    );
  }
  final String fPermName;
  final int fPermNo;

  Map<String, dynamic> toJson() {
    return {'fPermName': fPermName, 'fPermNo': fPermNo};
  }
}

class User {
  User({
    required this.fUserId,
    required this.fUserName,
    required this.fCompanyId,
    required this.fEmail,
    required this.fIdNo,
    required this.fJawNo,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fUserId: json['fUserId'] as int,
      fUserName: json['fUserName'].toString(),
      fCompanyId: json['fCompanyId'] as int,
      fEmail: json['fEmail'].toString(),
      fIdNo: json['fIdNo'] as int,
      fJawNo: json['fJawNo'].toString(),
    );
  }
  final int fUserId;
  final String fUserName;
  final int fCompanyId;
  final String fEmail;
  final int fIdNo;
  final String fJawNo;
}
