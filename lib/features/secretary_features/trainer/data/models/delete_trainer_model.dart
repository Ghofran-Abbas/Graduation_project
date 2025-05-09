class DeleteTrainerModel {
  final String message;

  DeleteTrainerModel({
    required this.message,
  });

  factory DeleteTrainerModel.fromJson(Map<String, dynamic> json) => DeleteTrainerModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}