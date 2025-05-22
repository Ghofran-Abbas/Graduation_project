class LogoutSecretaryModel {
  final String message;

  LogoutSecretaryModel({
    required this.message,
  });

  factory LogoutSecretaryModel.fromJson(Map<String, dynamic> json) => LogoutSecretaryModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}