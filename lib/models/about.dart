




class AboutModel  {
  AboutModel({
    this.title,
    this.title_ar,
    this.description,
    this.description_ar

  });


  String title;
  String title_ar;
  String description;
  String description_ar;

  factory AboutModel.fromJson(Map<String, dynamic> json) => AboutModel(

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