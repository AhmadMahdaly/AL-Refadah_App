class UserModel {
  UserModel({required this.fUserId, required this.fUserName});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fUserId: json['fUserId'].toString(),
      fUserName: json['fUserName'].toString(),
    );
  }
  final String fUserId;
  final String fUserName;
}
