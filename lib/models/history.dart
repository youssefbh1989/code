


class History {
  History({
    this.status,
    this.comments,
    this.createdAt,
  });

  String status;
  dynamic comments;
  DateTime createdAt;

  factory History.fromJson(Map<String, dynamic> json) => History(
    status: json["status"],
    comments: json["comments"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "comments": comments,
    "created_at": createdAt.toIso8601String(),
  };
}