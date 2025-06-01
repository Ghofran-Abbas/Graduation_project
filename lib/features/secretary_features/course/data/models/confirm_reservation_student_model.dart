class ConfirmReservationStudentModel {
  final String message;

  ConfirmReservationStudentModel({
    required this.message,
  });

  factory ConfirmReservationStudentModel.fromJson(Map<String, dynamic> json) => ConfirmReservationStudentModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}