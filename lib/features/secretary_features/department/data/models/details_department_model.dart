class DetailsDepartmentModel {
  final String message;
  final Department department;

  DetailsDepartmentModel({
    required this.message,
    required this.department,
  });

  factory DetailsDepartmentModel.fromJson(Map<String, dynamic> json) => DetailsDepartmentModel(
    message: json["message"],
    department: Department.fromJson(json["department"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "department": department.toJson(),
  };
}

class Department {
  final int id;
  final String name;
  final String photo;
  final DateTime createdAt;
  final DateTime updatedAt;

  Department({
    required this.id,
    required this.name,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Department.fromJson(Map<String, dynamic> json) => Department(
    id: json["id"],
    name: json["name"],
    photo: json["photo"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "photo": photo,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}