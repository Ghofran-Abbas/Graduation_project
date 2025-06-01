class PasswordResetModel {
  final String message;

  PasswordResetModel({
    required this.message,
  });

  factory PasswordResetModel.fromJson(Map<String, dynamic> json) => PasswordResetModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}