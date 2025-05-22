class AddSectionStudentModel {
  final String message;

  AddSectionStudentModel({
    required this.message,
  });

  factory AddSectionStudentModel.fromJson(Map<String, dynamic> json) => AddSectionStudentModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}