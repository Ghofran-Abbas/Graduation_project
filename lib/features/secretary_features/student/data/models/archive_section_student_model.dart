class ArchiveSectionStudentModel {
  final String message;
  final List<CourseElement>? courses;

  ArchiveSectionStudentModel({
    required this.message,
    required this.courses,
  });

  factory ArchiveSectionStudentModel.fromJson(Map<String, dynamic> json) => ArchiveSectionStudentModel(
    message: json["message"],
    courses: List<CourseElement>.from(json["courses"].map((x) => CourseElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "courses": List<dynamic>.from(courses!.map((x) => x.toJson())),
  };
}

class CourseElement {
  final int id;
  final String name;
  final int seatsOfNumber;
  final int reservedSeats;
  final String state;
  final DateTime startDate;
  final DateTime endDate;
  final int courseId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int totalSessions;
  final CourseCourse course;
  final List<WeekDay> weekDays;

  CourseElement({
    required this.id,
    required this.name,
    required this.seatsOfNumber,
    required this.reservedSeats,
    required this.state,
    required this.startDate,
    required this.endDate,
    required this.courseId,
    required this.createdAt,
    required this.updatedAt,
    required this.totalSessions,
    required this.course,
    required this.weekDays,
  });

  factory CourseElement.fromJson(Map<String, dynamic> json) => CourseElement(
    id: json["id"],
    name: json["name"],
    seatsOfNumber: json["seatsOfNumber"],
    reservedSeats: json["reservedSeats"],
    state: json["state"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    courseId: json["courseId"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    totalSessions: json["total_sessions"],
    course: CourseCourse.fromJson(json["course"]),
    weekDays: List<WeekDay>.from(json["week_days"].map((x) => WeekDay.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "seatsOfNumber": seatsOfNumber,
    "reservedSeats": reservedSeats,
    "state": state,
    "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "endDate": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "courseId": courseId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "total_sessions": totalSessions,
    "course": course.toJson(),
    "week_days": List<dynamic>.from(weekDays.map((x) => x.toJson())),
  };
}

class CourseCourse {
  final int id;
  final String name;
  final String description;
  final String photo;
  final int departmentId;
  final DateTime createdAt;
  final DateTime updatedAt;

  CourseCourse({
    required this.id,
    required this.name,
    required this.description,
    required this.photo,
    required this.departmentId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CourseCourse.fromJson(Map<String, dynamic> json) => CourseCourse(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    photo: json["photo"],
    departmentId: json["department_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "photo": photo,
    "department_id": departmentId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class WeekDay {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Pivot pivot;

  WeekDay({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory WeekDay.fromJson(Map<String, dynamic> json) => WeekDay(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pivot": pivot.toJson(),
  };
}

class Pivot {
  final int courseSectionId;
  final int weekDayId;
  final String startTime;
  final String endTime;
  final DateTime createdAt;
  final DateTime updatedAt;

  Pivot({
    required this.courseSectionId,
    required this.weekDayId,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    courseSectionId: json["course_section_id"],
    weekDayId: json["week_day_id"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "course_section_id": courseSectionId,
    "week_day_id": weekDayId,
    "start_time": startTime,
    "end_time": endTime,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
