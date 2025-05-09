class UpdateTrainerModel {
  final String message;
  final TrainerInfo trainerInfo;

  UpdateTrainerModel({
    required this.message,
    required this.trainerInfo,
  });

  factory UpdateTrainerModel.fromJson(Map<String, dynamic> json) => UpdateTrainerModel(
    message: json["message"],
    trainerInfo: TrainerInfo.fromJson(json["TrainerInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "TrainerInfo": trainerInfo.toJson(),
  };
}

class TrainerInfo {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String photo;
  final DateTime birthday;
  final String gender;
  final String specialization;
  final String experience;
  final DateTime createdAt;
  final DateTime updatedAt;

  TrainerInfo({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photo,
    required this.birthday,
    required this.gender,
    required this.specialization,
    required this.experience,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TrainerInfo.fromJson(Map<String, dynamic> json) => TrainerInfo(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    photo: json["photo"],
    birthday: DateTime.parse(json["birthday"]),
    gender: json["gender"],
    specialization: json["specialization"],
    experience: json["experience"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "photo": photo,
    "birthday": "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "specialization": specialization,
    "experience": experience,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}