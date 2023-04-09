


class SliderModel {
  String title;
  String title_ar;
  String image;
  String salon_id;
  String type;

  SliderModel({this.title, this.title_ar, this.image, this.salon_id, this.type});

  SliderModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    title_ar = json['title_ar'];
    image = json['image'];
    salon_id = json['salon_id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['title_ar'] = this.title_ar;
    data['image'] = this.image;
    data['salon_id'] = this.salon_id;
    data['type'] = this.type;
    return data;
  }
}