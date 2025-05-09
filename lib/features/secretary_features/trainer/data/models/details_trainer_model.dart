class DetailsTrainerModel {
  final String message;
  final Trainer trainer;

  DetailsTrainerModel({
    required this.message,
    required this.trainer,
  });

  factory DetailsTrainerModel.fromJson(Map<String, dynamic> json) => DetailsTrainerModel(
    message: json["message"],
    trainer: Trainer.fromJson(json["Trainer"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "Trainer": trainer.toJson(),
  };
}

class Trainer {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? photo;
  final String birthday;
  final String gender;
  final String specialization;
  final String experience;
  final DateTime createdAt;
  final DateTime updatedAt;

  Trainer({
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

  factory Trainer.fromJson(Map<String, dynamic> json) => Trainer(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    photo: json["photo"],
    birthday: json["birthday"],
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
    "birthday": birthday,
    "gender": gender,
    "specialization": specialization,
    "experience": experience,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}