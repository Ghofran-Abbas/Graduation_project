class LoginSecretaryModel {
  final String message;
  final AccessToken accessToken;

  LoginSecretaryModel({
    required this.message,
    required this.accessToken,
  });

  factory LoginSecretaryModel.fromJson(Map<String, dynamic> json) => LoginSecretaryModel(
    message: json["Message"],
    accessToken: AccessToken.fromJson(json["AccessToken"]),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "AccessToken": accessToken.toJson(),
  };
}

class AccessToken {
  final String accessToken;
  final String tokenType;
  final User user;

  AccessToken({
    required this.accessToken,
    required this.tokenType,
    required this.user,
  });

  factory AccessToken.fromJson(Map<String, dynamic> json) => AccessToken(
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "user": user.toJson(),
  };
}

class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final dynamic photo;
  final DateTime birthday;
  final String gender;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int points;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photo,
    required this.birthday,
    required this.gender,
    required this.createdAt,
    required this.updatedAt,
    required this.points,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    photo: json["photo"],
    birthday: DateTime.parse(json["birthday"]),
    gender: json["gender"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    points: json["points"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "photo": photo,
    "birthday": "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "points": points,
  };
}