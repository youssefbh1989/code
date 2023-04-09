



class RevenueModel {
  RevenueModel({
    this.start,
    this.end,
    this.revenue,
  });

  String revenue;
  DateTime start;
  DateTime end;

  factory RevenueModel.fromJson(Map<String, dynamic> json) {
    return json == null
        ? null
        : RevenueModel(
      revenue: json["revenue"].toString(),
    );
  }

    Map<String, dynamic> toJson() => {
      "revenue": revenue,
    };
  }
