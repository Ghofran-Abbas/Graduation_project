class SectionsModel {
  final String message;
  final List<Section> sections;

  SectionsModel({
    required this.message,
    required this.sections,
  });

  factory SectionsModel.fromJson(Map<String, dynamic> json) => SectionsModel(
    message: json["message"],
    sections: List<Section>.from(json["sections"].map((x) => Section.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "sections": List<dynamic>.from(sections.map((x) => x.toJson())),
  };
}

class Section {
  final int id;
  final String name;
  final int seatsOfNumber;
  final DateTime startDate;
  final DateTime endDate;
  final String state;
  final int courseId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<dynamic> weekDays;

  Section({
    required this.id,
    required this.name,
    required this.seatsOfNumber,
    required this.startDate,
    required this.endDate,
    required this.state,
    required this.courseId,
    required this.createdAt,
    required this.updatedAt,
    required this.weekDays,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    id: json["id"],
    name: json["name"],
    seatsOfNumber: json["seatsOfNumber"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    state: json["state"],
    courseId: json["courseId"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    weekDays: List<dynamic>.from(json["week_days"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "seatsOfNumber": seatsOfNumber,
    "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "endDate": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "state": state,
    "courseId": courseId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "week_days": List<dynamic>.from(weekDays.map((x) => x)),
  };
}