class CreateStudentModel {
  late final String message;
  late final User user;

  CreateStudentModel({
    required this.message,
    required this.user,
  });

  factory CreateStudentModel.fromJson(Map<String, dynamic> json) => CreateStudentModel(
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
  late final DateTime updatedAt;
  late final DateTime createdAt;
  late final int id;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.photo,
    required this.birthday,
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
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}