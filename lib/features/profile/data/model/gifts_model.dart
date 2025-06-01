class GiftsModel {
  final String message;
  final List<Gift>? gifts;
  final Pagination pagination;

  GiftsModel({
    required this.message,
    required this.gifts,
    required this.pagination,
  });

  factory GiftsModel.fromJson(Map<String, dynamic> json) => GiftsModel(
    message: json["message"],
    gifts: List<Gift>.from(json["gifts"].map((x) => Gift.fromJson(x))),
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "gifts": List<dynamic>.from(gifts!.map((x) => x.toJson())),
    "pagination": pagination.toJson(),
  };
}

class Gift {
  final int id;
  final String description;
  final DateTime date;
  final String? photo;
  final int? studentId;
  final int secretaryId;
  final DateTime createdAt;
  final DateTime updatedAt;
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

class Pagination {
  final int total;
  final int perPage;
  final int currentPage;
  final int lastPage;
  final int? from;
  final int? to;

  Pagination({
    required this.total,
    required this.perPage,
    required this.currentPage,
    required this.lastPage,
    required this.from,
    required this.to,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    perPage: json["per_page"],
    currentPage: json["current_page"],
    lastPage: json["last_page"],
    from: json["from"],
    to: json["to"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "per_page": perPage,
    "current_page": currentPage,
    "last_page": lastPage,
    "from": from,
    "to": to,
  };
}