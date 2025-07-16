class UpdateStudentModel {
  final String message;
  final StudentInfo studentInfo;

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
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String photo;
  final DateTime birthday;
  final String gender;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int points;
  final dynamic referrerId;

  StudentInfo({
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
    required this.referrerId,
  });

  factory StudentInfo.fromJson(Map<String, dynamic> json) => StudentInfo(
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
    referrerId: json["referrer_id"],
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
    "referrer_id": referrerId,
  };
}