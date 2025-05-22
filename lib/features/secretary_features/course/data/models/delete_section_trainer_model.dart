class DeleteSectionTrainerModel {
  final String message;

  DeleteSectionTrainerModel({
    required this.message,
  });

  factory DeleteSectionTrainerModel.fromJson(Map<String, dynamic> json) => DeleteSectionTrainerModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}