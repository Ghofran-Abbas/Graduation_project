class LoginSecretaryModel {
  late final String message;
  late final AccessToken accessToken;

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
  late final String accessToken;
  late final String tokenType;
  late final User user;

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
  late final int id;
  late final String name;
  late final String email;
  late final String phone;
  late final String photo;
  late final String birthday;
  late final String gender;
  late final DateTime createdAt;
  late final DateTime updatedAt;

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
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    photo: json["photo"],
    birthday: json["birthday"],
    gender: json["gender"],
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
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}