class SectionsModel {
  final int currentPage;
  final List<DatumSection>? data;
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

  SectionsModel({
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

  factory SectionsModel.fromJson(Map<String, dynamic> json) => SectionsModel(
    currentPage: json["current_page"],
    data: List<DatumSection>.from(json["data"].map((x) => DatumSection.fromJson(x))),
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

class DatumSection {
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

  DatumSection({
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

  factory DatumSection.fromJson(Map<String, dynamic> json) => DatumSection(
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