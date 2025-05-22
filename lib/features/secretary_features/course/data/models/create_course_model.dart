class CreateCourseModel {
  final String message;
  final Course course;

  CreateCourseModel({
    required this.message,
    required this.course,
  });

  factory CreateCourseModel.fromJson(Map<String, dynamic> json) => CreateCourseModel(
    message: json["message"],
    course: Course.fromJson(json["course"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "course": course.toJson(),
  };
}

class Course {
  final String name;
  final String description;
  final String photo;
  final String departmentId;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  Course({
    required this.name,
    required this.description,
    required this.photo,
    required this.departmentId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    name: json["name"],
    description: json["description"],
    photo: json["photo"],
    departmentId: json["department_id"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "photo": photo,
    "department_id": departmentId,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}