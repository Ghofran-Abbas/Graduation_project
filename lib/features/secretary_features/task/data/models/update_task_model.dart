class UpdateTaskModel {
  final String message;
  final Task task;

  UpdateTaskModel({
    required this.message,
    required this.task,
  });

  factory UpdateTaskModel.fromJson(Map<String, dynamic> json) => UpdateTaskModel(
    message: json["message"],
    task: Task.fromJson(json["task"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "task": task.toJson(),
  };
}

class Task {
  final int id;
  final String title;
  final String description;
  final String status;
  final int secretaryId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.secretaryId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    status: json["status"],
    secretaryId: json["secretary_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "status": status,
    "secretary_id": secretaryId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}