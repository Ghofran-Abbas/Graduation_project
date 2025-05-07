class VerificationModel {
  final String message;

  VerificationModel({
    required this.message,
  });

  factory VerificationModel.fromJson(Map<String, dynamic> json) => VerificationModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}