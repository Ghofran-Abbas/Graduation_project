class DetailsReportModel {
  final String message;
  final Report report;

  DetailsReportModel({
    required this.message,
    required this.report,
  });

  factory DetailsReportModel.fromJson(Map<String, dynamic> json) => DetailsReportModel(
    message: json["message"],
    report: Report.fromJson(json["report"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "report": report.toJson(),
  };
}

class Report {
  final int id;
  final String name;
  final String description;
  final String file;
  final int secretaryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Secretary secretary;

  Report({
    required this.id,
    required this.name,
    required this.description,
    required this.file,
    required this.secretaryId,
    required this.createdAt,
    required this.updatedAt,
    required this.secretary,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    file: json["file"],
    secretaryId: json["secretary_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    secretary: Secretary.fromJson(json["secretary"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "file": file,
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
  final String birthday;
  final String gender;
  final DateTime createdAt;
  final DateTime updatedAt;

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
  });

  factory Secretary.fromJson(Map<String, dynamic> json) => Secretary(
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