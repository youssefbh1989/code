import 'dart:convert';

class ServiceFilterModel {
  ServiceFilterModel({
    this.id,
    this.name,
    this.nameAr,
    this.description,
    this.descriptionAr,
    this.price,
    this.duration,
    this.status,
    this.slug,
    this.ordered,
    this.categoryId,
    this.salonId,
    this.createdAt,
    this.updatedAt,
    this.images,
    this.salon,
    this.category,

    //this.special,
  });

  int id;
  String name;
  String nameAr;
  dynamic description;
  dynamic descriptionAr;
  String price;
  String duration;
  String status;
  String slug;
  String ordered;
  String categoryId;
  String salonId;
  DateTime createdAt;
  DateTime updatedAt;
  List<Images> images;
  Category salon;
  Category category;

  //Special special;

  factory ServiceFilterModel.fromJson(Map<String, dynamic> json) => ServiceFilterModel(
    id: json["id"],
    name: json["name"],

    nameAr: json["name_ar"],
    description: json["description"],
    descriptionAr: json["description_ar"],
    price: json["price"],
    duration: json["duration"],
    status: json["status"],
    slug: json["slug"],
    ordered: json["ordered"],
    categoryId: json["category_id"],
    salonId: json["salon_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    images: List<Images>.from(
        json["images"].map((x) => Images.fromJson(x))),
    salon: Category.fromJson(json["salon"]),
    category: Category.fromJson(json["category"]),
    //special: Special.fromJson(json["special"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "name_ar": nameAr,
    "description": description,
    "description_ar": descriptionAr,
    "price": price,
    "duration": duration,
    "status": status,
    "slug": slug,
    "ordered": ordered,
    "category_id": categoryId,
    "salon_id": salonId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "images": jsonEncode(images),
    "salon": salon.toJson(),
    "category": category.toJson(),
    //"special": special.toJson(),
  };
}

class Images {
  Images({
    this.image,
  });

  String image;

  factory Images.fromJson(Map<String, dynamic> json) {
    return json == null
        ? null
        : Images(
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
    "image": image,
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.nameAr,
    this.image,
    this.address,
    this.address_ar,
    this.type
  });

  int id;
  String name;
  String nameAr;
  String image;
  String address;
  String address_ar;
  String type;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    nameAr: json["name_ar"],
    image: json["image"],
    address: json["address"],
    address_ar: json["address_ar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    'type':type,
    "name_ar": nameAr,
    "image": image,
    "address": address,
    "address_ar":address_ar
  };
}

// class Special {
//   Special({
//     this.specialPrice,
//     this.expiryDate,
//     this.serviceId,
//   });
//
//   String specialPrice;
//   DateTime expiryDate;
//   String serviceId;
//
//   factory Special.fromJson(Map<String, dynamic> json) => Special(
//     specialPrice: json["special_price"],
//     expiryDate: DateTime.parse(json["expiry_date"]),
//     serviceId: json["service_id"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "special_price": specialPrice,
//     "expiry_date": "${expiryDate.year.toString().padLeft(4, '0')}-${expiryDate.month.toString().padLeft(2, '0')}-${expiryDate.day.toString().padLeft(2, '0')}",
//     "service_id": serviceId,
//   };
// }
