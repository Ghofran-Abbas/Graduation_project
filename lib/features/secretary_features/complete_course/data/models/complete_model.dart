class CompleteModel {
  final int currentPage;
  final List<DatumComplete>? data;
  final String firstPageUrl;
  final int? from;
  final int lastPage;
  final String lastPageUrl;
  final List<Link> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int? to;
  final int total;

  CompleteModel({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory CompleteModel.fromJson(Map<String, dynamic> json) => CompleteModel(
    currentPage: json["current_page"],
    data: List<DatumComplete>.from(json["data"].map((x) => DatumComplete.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class DatumComplete {
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
  final List<dynamic> weekDays;
  final List<Trainer>? trainers;

  DatumComplete({
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
    required this.weekDays,
    required this.trainers,
  });

  factory DatumComplete.fromJson(Map<String, dynamic> json) => DatumComplete(
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
    weekDays: List<dynamic>.from(json["week_days"].map((x) => x)),
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
    "week_days": List<dynamic>.from(weekDays.map((x) => x)),
    "trainers": List<dynamic>.from(trainers!.map((x) => x)),
  };
}

class Trainer {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? photo;
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
    gender: json["gender"],
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

class WeekDay {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final WeekDayPivot pivot;

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
    pivot: WeekDayPivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pivot": pivot.toJson(),
  };
}

class WeekDayPivot {
  final int courseSectionId;
  final int weekDayId;
  final String startTime;
  final String endTime;
  final DateTime createdAt;
  final DateTime updatedAt;

  WeekDayPivot({
    required this.courseSectionId,
    required this.weekDayId,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WeekDayPivot.fromJson(Map<String, dynamic> json) => WeekDayPivot(
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

class Link {
  final String? url;
  final String label;
  final bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}