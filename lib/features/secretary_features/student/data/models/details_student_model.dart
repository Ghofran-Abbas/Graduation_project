class DetailsStudentModel {
  final String message;
  final Student student;

  DetailsStudentModel({
    required this.message,
    required this.student,
  });

  factory DetailsStudentModel.fromJson(Map<String, dynamic> json) => DetailsStudentModel(
    message: json["message"],
    student: Student.fromJson(json["student"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "student": student.toJson(),
  };
}

class Student {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String photo;
  final String birthday;
  final DateTime createdAt;
  final DateTime updatedAt;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photo,
    required this.birthday,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    photo: json["photo"],
    birthday: json["birthday"],
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
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}