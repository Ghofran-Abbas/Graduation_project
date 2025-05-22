class DeleteCourseModel {
  final String message;

  DeleteCourseModel({
    required this.message,
  });

  factory DeleteCourseModel.fromJson(Map<String, dynamic> json) => DeleteCourseModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}