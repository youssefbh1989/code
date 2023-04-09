import 'package:equatable/equatable.dart';

class  Cat  extends Equatable{
  int id;
  String name;
  String nameAr;
  String image;
  String serviceCount;
  List<Service> services;

  Cat(
      {this.id,
        this.name,
        this.nameAr,
        this.image,
        this.serviceCount,
        this.services});

  factory Cat.fromJson(Map<String, dynamic> json) {
    return json == null
        ? null
        : Cat(
      id: json["id"],
      name: json["name"],
      nameAr: json["name_ar"],
      image: json["image"],
      serviceCount: json["service_count"],
      services: List<Service>.from(json["children"].map((x) => Service.fromJson(Map<String, dynamic>.from(x)))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "name_ar": nameAr,
      "image": image,
      "service_count": serviceCount,
      "services": List<dynamic>.from(services.map((x) => x.toJson())).toList(),
    };
  }

  @override
  List<Object> get props => [id];
}

class Service {
  Service({
    this.id,
    this.name,
    this.nameAr,
    this.price,
    this.description,
    this.descriptionAr,
    this.salonId,
    this.categoryId,
    this.special,
    this.image
  });

  int id;
  String name;
  String nameAr;
  String price;
  dynamic description;
  dynamic descriptionAr;
  String salonId;
  String categoryId;
  dynamic special;
  String image;

  factory Service.fromJson(Map<String, dynamic> json) {
    return json == null
        ? null
        : Service(
      id: json["id"],
      name: json["name"],
      nameAr: json["name_ar"],
      image: json["image"],
      price: json["price"],
      description: json["description"],
      descriptionAr: json["description_ar"],
      salonId: json["salon_id"],
      categoryId: json["category_id"],
      special: json["special"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "name_ar": nameAr,
      "price": price,
      "description": description,
      "description_ar": descriptionAr,
      "salon_id": salonId,
      "category_id": categoryId,
      "special": special,
    };
  }
}
