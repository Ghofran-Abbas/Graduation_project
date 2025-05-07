class ForgotPasswordModel {
  final String mes;

  ForgotPasswordModel({
    required this.mes,
  });

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) => ForgotPasswordModel(
    mes: json["mes"],
  );

  Map<String, dynamic> toJson() => {
    "mes": mes,
  };
}