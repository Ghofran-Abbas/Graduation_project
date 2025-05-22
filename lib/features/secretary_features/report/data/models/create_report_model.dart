class CreateReportModel {
  final String message;
  final Report report;

  CreateReportModel({
    required this.message,
    required this.report,
  });

  factory CreateReportModel.fromJson(Map<String, dynamic> json) => CreateReportModel(
    message: json["message"],
    report: Report.fromJson(json["report"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "report": report.toJson(),
  };
}

class Report {
  final String name;
  final String description;
  final String file;
  final int secretaryId;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  Report({
    required this.name,
    required this.description,
    required this.file,
    required this.secretaryId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    name: json["name"],
    description: json["description"],
    file: json["file"],
    secretaryId: json["secretary_id"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "file": file,
    "secretary_id": secretaryId,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}