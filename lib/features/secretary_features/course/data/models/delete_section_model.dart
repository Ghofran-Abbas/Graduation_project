class DeleteSectionModel {
  final String message;

  DeleteSectionModel({
    required this.message,
  });

  factory DeleteSectionModel.fromJson(Map<String, dynamic> json) => DeleteSectionModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}