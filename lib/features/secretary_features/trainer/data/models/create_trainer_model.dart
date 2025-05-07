class CreateTrainerModel {
  late final String message;
  late final User user;

  CreateTrainerModel({
    required this.message,
    required this.user,
  });

  factory CreateTrainerModel.fromJson(Map<String, dynamic> json) => CreateTrainerModel(
    message: json["Message"],
    user: User.fromJson(json["User"]),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "User": user.toJson(),
  };
}

class User {
  late final String name;
  late final String email;
  late final String phone;
  late final String photo;
  late final String birthday;
  late final String gender;
  late final String specialization;
  late final String experience;
  late final DateTime updatedAt;
  late final DateTime createdAt;
  late final int id;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.photo,
    required this.birthday,
    required this.gender,
    required this.specialization,
    required this.experience,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    photo: json["photo"],
    birthday: json["birthday"],
    gender: json["gender"],
    specialization: json["specialization"],
    experience: json["experience"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "photo": photo,
    "birthday": birthday,
    "gender": gender,
    "specialization": specialization,
    "experience": experience,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}