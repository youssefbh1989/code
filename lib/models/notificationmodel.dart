class Notificationmodel {
  String id;
  String text;
  DateTime createdAt;
  bool isRead;

  Notificationmodel(
      {this.id, String type, this.text, DateTime createdAt, this.isRead})
      : createdAt = createdAt ?? DateTime.now();

  factory Notificationmodel.fromJson(Map<String, dynamic> json) {
    return Notificationmodel(
      id: json["id"],
      createdAt: DateTime.parse(json['created_at']),
      text: json['data'][0]['title'],
      isRead: json['read_at'] != null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'created_at': createdAt.toIso8601String(),
      'read_at': isRead ? true : null,

    };
  }
}
