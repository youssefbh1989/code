




class PrivacyModel  {
  PrivacyModel({
    this.title,
    this.title_ar,
    this.description,
    this.description_ar

  });


  String title;
  String title_ar;
  String description;
  String description_ar;

  factory PrivacyModel.fromJson(Map<String, dynamic> json) => PrivacyModel(

    title: json["title"],
    title_ar: json["title_ar"],
    description: json["description"],
    description_ar: json["description_ar"],
  );

  Map<String, dynamic> toJson() => {

    "title": title,
    "title_ar": title_ar,
    "description": description,
    "description_ar": description_ar,
  };


}