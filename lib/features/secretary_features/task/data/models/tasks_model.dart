class TasksModel {
  final String message;
  final Tasks tasks;

  TasksModel({
    required this.message,
    required this.tasks,
  });

  factory TasksModel.fromJson(Map<String, dynamic> json) => TasksModel(
    message: json["Message"],
    tasks: Tasks.fromJson(json["Tasks"]),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Tasks": tasks.toJson(),
  };
}

class Tasks {
  final int currentPage;
  final List<DatumTask>? data;
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

  Tasks({
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

  factory Tasks.fromJson(Map<String, dynamic> json) => Tasks(
    currentPage: json["current_page"],
    data: List<DatumTask>.from(json["data"].map((x) => DatumTask.fromJson(x))),
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

class DatumTask {
  final int id;
  final String title;
  final String description;
  final String status;
  final int secretaryId;
  final DateTime createdAt;
  final DateTime updatedAt;

  DatumTask({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.secretaryId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DatumTask.fromJson(Map<String, dynamic> json) => DatumTask(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    status: json["status"],
    secretaryId: json["secretary_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "status": status,
    "secretary_id": secretaryId,
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