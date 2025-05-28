class EmpResponseModel {
  EmpResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EmpResponseModel.fromJson(Map<String, dynamic> json) {
    return EmpResponseModel(
      status: json['status'] as String,
      message: json['message'] as String,
      data:
          (json['data'] as List)
              .map(
                (item) => EmpDataModel.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
    );
  }
  final String status;
  final String message;
  final List<EmpDataModel> data;
}

class EmpDataModel {
  EmpDataModel({required this.id, required this.name});

  factory EmpDataModel.fromJson(Map<String, dynamic> json) {
    return EmpDataModel(
      id: json['f_Id'] as int,
      name: json['f_Name'] as String,
    );
  }
  final int id;
  final String name;
}
