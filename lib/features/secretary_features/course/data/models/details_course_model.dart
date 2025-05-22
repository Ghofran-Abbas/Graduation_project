class DetailsCourseModel {
  final String message;
  final Course course;

  DetailsCourseModel({
    required this.message,
    required this.course,
  });

  factory DetailsCourseModel.fromJson(Map<String, dynamic> json) => DetailsCourseModel(
    message: json["message"],
    course: Course.fromJson(json["course"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "course": course.toJson(),
  };
}

class Course {
  final int id;
  final String name;
  final String description;
  final String photo;
  final int departmentId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Department department;

  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.photo,
    required this.departmentId,
    required this.createdAt,
    required this.updatedAt,
    required this.department,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    photo: json["photo"],
    departmentId: json["department_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    department: Department.fromJson(json["department"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "photo": photo,
    "department_id": departmentId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
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