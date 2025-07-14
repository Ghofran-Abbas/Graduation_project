class SectionProgressModel {
  final String message;
  final int progressPercentage;

  SectionProgressModel({
    required this.message,
    required this.progressPercentage,
  });

  factory SectionProgressModel.fromJson(Map<String, dynamic> json) => SectionProgressModel(
    message: json["message"],
    progressPercentage: json["progress_percentage"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "progress_percentage": progressPercentage,
  };
}