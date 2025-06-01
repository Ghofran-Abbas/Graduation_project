class DetailsGiftModel {
  final String message;
  final Gift gift;

  DetailsGiftModel({
    required this.message,
    required this.gift,
  });

  factory DetailsGiftModel.fromJson(Map<String, dynamic> json) => DetailsGiftModel(
    message: json["message"],
    gift: Gift.fromJson(json["gift"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "gift": gift.toJson(),
  };
}

class Gift {
  final int id;
  final String description;
  final DateTime date;
  final String photo;
  final dynamic studentId;
  final int secretaryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic student;
  final Secretary secretary;

  Gift({
    required this.id,
    required this.description,
    required this.date,
    required this.photo,
    required this.studentId,
    required this.secretaryId,
    required this.createdAt,
    required this.updatedAt,
    required this.student,
    required this.secretary,
  });

  factory Gift.fromJson(Map<String, dynamic> json) => Gift(
    id: json["id"],
    description: json["description"],
    date: DateTime.parse(json["date"]),
    photo: json["photo"],
    studentId: json["student_id"],
    secretaryId: json["secretary_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    student: json["student"],
    secretary: Secretary.fromJson(json["secretary"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "date": date.toIso8601String(),
    "photo": photo,
    "student_id": studentId,
    "secretary_id": secretaryId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "student": student,
    "secretary": secretary.toJson(),
  };
}

class Secretary {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String photo;
  final DateTime birthday;
  final String gender;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int points;

  Secretary({
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

  factory Secretary.fromJson(Map<String, dynamic> json) => Secretary(
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