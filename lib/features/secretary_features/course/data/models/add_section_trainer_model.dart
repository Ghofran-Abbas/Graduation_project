class AddSectionTrainerModel {
  final String message;

  AddSectionTrainerModel({
    required this.message,
  });

  factory AddSectionTrainerModel.fromJson(Map<String, dynamic> json) => AddSectionTrainerModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}