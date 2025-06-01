class PointsModel {
  final String message;
  final int points;

  PointsModel({
    required this.message,
    required this.points,
  });

  factory PointsModel.fromJson(Map<String, dynamic> json) => PointsModel(
    message: json["message"],
    points: json["points"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "points": points,
  };
}