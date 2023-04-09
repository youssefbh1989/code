


class ReviewModel {
  ReviewModel({
    this.review,
    this.rating,
    this.salon_id,

  });

  String review;
  String rating;
  String salon_id;


  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      review: json["review"],
      rating: json["rating"],
      salon_id: json["salon_id"],

    );
  }

  Map<String ,dynamic> toJson() {
    return {
      "review": review,
      "rating": rating,
      "salon_id": salon_id,

    };
  }
}