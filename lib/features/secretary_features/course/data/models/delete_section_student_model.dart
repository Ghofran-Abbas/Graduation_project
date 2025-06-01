class DeleteSectionStudentModel {
  final String message;

  DeleteSectionStudentModel({
    required this.message,
  });

  factory DeleteSectionStudentModel.fromJson(Map<String, dynamic> json) => DeleteSectionStudentModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}