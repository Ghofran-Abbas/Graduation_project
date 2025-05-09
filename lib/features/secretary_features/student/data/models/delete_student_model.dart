class DeleteStudentModel {
  final String message;

  DeleteStudentModel({
    required this.message,
  });

  factory DeleteStudentModel.fromJson(Map<String, dynamic> json) => DeleteStudentModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}