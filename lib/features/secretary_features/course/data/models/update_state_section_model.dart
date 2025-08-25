class UpdateStateSectionModel {
  final String message;
  final CourseSection courseSection;

  UpdateStateSectionModel({
    required this.message,
    required this.courseSection,
  });

  factory UpdateStateSectionModel.fromJson(Map<String, dynamic> json) => UpdateStateSectionModel(
    message: json["message"],
    courseSection: CourseSection.fromJson(json["Course Section"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "Course Section": courseSection.toJson(),
  };
}

class CourseSection {
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
  final List<Student>? students;
  final List<Trainer>? trainers;

  CourseSection({
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
    required this.students,
    required this.trainers,
  });

  factory CourseSection.fromJson(Map<String, dynamic> json) => CourseSection(
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
    students: List<Student>.from(json["students"].map((x) => Student.fromJson(x))),
    trainers: List<Trainer>.from(json["trainers"].map((x) => Trainer.fromJson(x))),
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
    "students": List<dynamic>.from(students!.map((x) => x.toJson())),
    "trainers": List<dynamic>.from(trainers!.map((x) => x.toJson())),
  };
}

class Student {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? photo;
  final DateTime birthday;
  final String gender;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int points;
  final int? referrerId;
  final StudentPivot pivot;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photo,
    required this.birthday,
    required this.gender,
    required this.createdAt,
    required this.updatedAt,
    required this.points,
    required this.referrerId,
    required this.pivot,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    photo: json["photo"],
    birthday: DateTime.parse(json["birthday"]),
    gender: json["gender"]!,
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    points: json["points"],
    referrerId: json["referrer_id"],
    pivot: StudentPivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "photo": photo,
    "birthday": "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "points": points,
    "referrer_id": referrerId,
    "pivot": pivot.toJson(),
  };
}

class StudentPivot {
  final int courseSectionId;
  final int studentId;
  final int id;
  final int isConfirmed;
  final DateTime createdAt;
  final DateTime updatedAt;

  StudentPivot({
    required this.courseSectionId,
    required this.studentId,
    required this.id,
    required this.isConfirmed,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudentPivot.fromJson(Map<String, dynamic> json) => StudentPivot(
    courseSectionId: json["course_section_id"],
    studentId: json["student_id"],
    id: json["id"],
    isConfirmed: json["is_confirmed"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "course_section_id": courseSectionId,
    "student_id": studentId,
    "id": id,
    "is_confirmed": isConfirmed,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Trainer {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String photo;
  final DateTime birthday;
  final String gender;
  final String specialization;
  final String experience;
  final DateTime createdAt;
  final DateTime updatedAt;
  final TrainerPivot pivot;

  Trainer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photo,
    required this.birthday,
    required this.gender,
    required this.specialization,
    required this.experience,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory Trainer.fromJson(Map<String, dynamic> json) => Trainer(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    photo: json["photo"],
    birthday: DateTime.parse(json["birthday"]),
    gender: json["gender"]!,
    specialization: json["specialization"],
    experience: json["experience"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pivot: TrainerPivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "photo": photo,
    "birthday": "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "specialization": specialization,
    "experience": experience,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pivot": pivot.toJson(),
  };
}

class TrainerPivot {
  final int courseSectionId;
  final int trainerId;
  final DateTime createdAt;
  final DateTime updatedAt;

  TrainerPivot({
    required this.courseSectionId,
    required this.trainerId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TrainerPivot.fromJson(Map<String, dynamic> json) => TrainerPivot(
    courseSectionId: json["course_section_id"],
    trainerId: json["trainer_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "course_section_id": courseSectionId,
    "trainer_id": trainerId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}