class TrainerRatingModel {
  final List<Rating>? ratings;
  final String? averageRating;

  TrainerRatingModel({
    required this.ratings,
    required this.averageRating,
  });

  factory TrainerRatingModel.fromJson(Map<String, dynamic> json) => TrainerRatingModel(
    ratings: List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
    averageRating: json["average_rating"],
  );

  Map<String, dynamic> toJson() => {
    "ratings": List<dynamic>.from(ratings!.map((x) => x.toJson())),
    "average_rating": averageRating,
  };
}

class Rating {
  final int id;
  final int studentId;
  final int trainerId;
  final int courseSectionId;
  final int rating;
  final String comment;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Student student;

  Rating({
    required this.id,
    required this.studentId,
    required this.trainerId,
    required this.courseSectionId,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    required this.student,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    id: json["id"],
    studentId: json["student_id"],
    trainerId: json["trainer_id"],
    courseSectionId: json["course_section_id"],
    rating: json["rating"],
    comment: json["comment"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    student: Student.fromJson(json["student"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "student_id": studentId,
    "trainer_id": trainerId,
    "course_section_id": courseSectionId,
    "rating": rating,
    "comment": comment,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "student": student.toJson(),
  };
}

class Student {
  final int id;
  final String name;
  final String photo;

  Student({
    required this.id,
    required this.name,
    required this.photo,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json["id"],
    name: json["name"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "photo": photo,
  };
}