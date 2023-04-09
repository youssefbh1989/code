




class FavoriteModel {
  int id;
  String name;
  String name_ar;
  String image;
  String address;
  String address_ar;

  FavoriteModel(
      {this.id,
        this.name,
        this.name_ar,
        this.image,
        this.address,
        this.address_ar});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    name_ar = json['name_ar'];
    image = json['image'];
    address = json['address'];
    address_ar = json['address_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.name_ar;
    data['image'] = this.image;
    data['address'] = this.address;
    data['address_ar'] = this.address_ar;
    return data;
  }
}