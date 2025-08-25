class NotificationsModel {
  final String message;
  final List<Notification>? notifications;

  NotificationsModel({
    required this.message,
    required this.notifications,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
    message: json["message"],
    notifications: List<Notification>.from(json["notifications"].map((x) => Notification.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "notifications": List<dynamic>.from(notifications!.map((x) => x.toJson())),
  };
}

class Notification {
  final int id;
  final String notifiableType;
  final int notifiableId;
  final String title;
  final String body;
  final int isRead;
  final DateTime createdAt;
  final DateTime updatedAt;

  Notification({
    required this.id,
    required this.notifiableType,
    required this.notifiableId,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["id"],
    notifiableType: json["notifiable_type"],
    notifiableId: json["notifiable_id"],
    title: json["title"],
    body: json["body"],
    isRead: json["is_read"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "notifiable_type": notifiableType,
    "notifiable_id": notifiableId,
    "title": title,
    "body": body,
    "is_read": isRead,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}