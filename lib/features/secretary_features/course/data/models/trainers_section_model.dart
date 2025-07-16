class TrainersSectionModel {
  final String message;
  final List<TrainersSectionModelTrainer>? trainers;

  TrainersSectionModel({
    required this.message,
    required this.trainers,
  });

  factory TrainersSectionModel.fromJson(Map<String, dynamic> json) => TrainersSectionModel(
    message: json["message"],
    trainers: List<TrainersSectionModelTrainer>.from(json["trainers"].map((x) => TrainersSectionModelTrainer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "trainers": List<dynamic>.from(trainers!.map((x) => x.toJson())),
  };
}

class TrainersSectionModelTrainer {
  final int id;
  final String name;
  final int seatsOfNumber;
  final String state;
  final DateTime startDate;
  final DateTime endDate;
  final int courseId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<TrainerTrainer>? trainers;

  TrainersSectionModelTrainer({
    required this.id,
    required this.name,
    required this.seatsOfNumber,
    required this.state,
    required this.startDate,
    required this.endDate,
    required this.courseId,
    required this.createdAt,
    required this.updatedAt,
    required this.trainers,
  });

  factory TrainersSectionModelTrainer.fromJson(Map<String, dynamic> json) => TrainersSectionModelTrainer(
    id: json["id"],
    name: json["name"],
    seatsOfNumber: json["seatsOfNumber"],
    state: json["state"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    courseId: json["courseId"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    trainers: List<TrainerTrainer>.from(json["trainers"].map((x) => TrainerTrainer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "seatsOfNumber": seatsOfNumber,
    "state": state,
    "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "endDate": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "courseId": courseId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "trainers": List<dynamic>.from(trainers!.map((x) => x.toJson())),
  };
}

class TrainerTrainer {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? photo;
  final String birthday;
  final String gender;
  final String specialization;
  final String experience;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Pivot pivot;

  TrainerTrainer({
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

  factory TrainerTrainer.fromJson(Map<String, dynamic> json) => TrainerTrainer(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    photo: json["photo"],
    birthday: json["birthday"],
    gender: json["gender"],
    specialization: json["specialization"],
    experience: json["experience"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "photo": photo,
    "birthday": birthday,
    "gender": gender,
    "specialization": specialization,
    "experience": experience,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pivot": pivot.toJson(),
  };
}

class Pivot {
  final int courseSectionId;
  final int trainerId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Pivot({
    required this.courseSectionId,
    required this.trainerId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
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