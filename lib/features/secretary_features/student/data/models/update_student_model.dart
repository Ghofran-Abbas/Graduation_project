class UpdateStudentModel {
  late final String message;
  late final StudentInfo studentInfo;

  UpdateStudentModel({
    required this.message,
    required this.studentInfo,
  });

  factory UpdateStudentModel.fromJson(Map<String, dynamic> json) => UpdateStudentModel(
    message: json["message"],
    studentInfo: StudentInfo.fromJson(json["studentInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "studentInfo": studentInfo.toJson(),
  };
}

class StudentInfo {
  late final int id;
  late final String name;
  late final String email;
  late final String phone;
  late final String photo;
  late final String birthday;
  late final DateTime createdAt;
  late final DateTime updatedAt;

  StudentInfo({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photo,
    required this.birthday,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudentInfo.fromJson(Map<String, dynamic> json) => StudentInfo(
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