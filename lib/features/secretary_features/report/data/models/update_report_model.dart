class UpdateReportModel {
  final String message;
  final Report report;

  UpdateReportModel({
    required this.message,
    required this.report,
  });

  factory UpdateReportModel.fromJson(Map<String, dynamic> json) => UpdateReportModel(
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

  Report({
    required this.id,
    required this.name,
    required this.description,
    required this.file,
    required this.secretaryId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    file: json["file"],
    secretaryId: json["secretary_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "file": file,
    "secretary_id": secretaryId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}