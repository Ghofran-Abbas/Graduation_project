class DetailsSectionModel {
  final String message;
  final Section section;

  DetailsSectionModel({
    required this.message,
    required this.section,
  });

  factory DetailsSectionModel.fromJson(Map<String, dynamic> json) => DetailsSectionModel(
    message: json["message"],
    section: Section.fromJson(json["section"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "section": section.toJson(),
  };
}

class Section {
  final int id;
  final String name;
  final int seatsOfNumber;
  final DateTime startDate;
  final int reservedSeats;
  final DateTime endDate;
  final String state;
  final int courseId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<WeekDay> weekDays;

  Section({
    required this.id,
    required this.name,
    required this.seatsOfNumber,
    required this.startDate,
    required this.reservedSeats,
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
    reservedSeats: json["reservedSeats"],
    endDate: DateTime.parse(json["endDate"]),
    state: json["state"],
    courseId: json["courseId"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    weekDays: List<WeekDay>.from(json["week_days"].map((x) => WeekDay.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "seatsOfNumber": seatsOfNumber,
    "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "reservedSeats": reservedSeats,
    "endDate": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "state": state,
    "courseId": courseId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "week_days": List<dynamic>.from(weekDays.map((x) => x.toJson())),
  };
}

class WeekDay {
  final String name;
  final String startTime;
  final String endTime;

  WeekDay({
    required this.name,
    required this.startTime,
    required this.endTime,
  });

  factory WeekDay.fromJson(Map<String, dynamic> json) => WeekDay(
    name: json["name"],
    startTime: json["start_time"],
    endTime: json["end_time"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "start_time": startTime,
    "end_time": endTime,
  };
}