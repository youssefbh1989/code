class Services {
  Services({
    this.id,
    this.name,
    this.nameAr,
    this.description,
    this.descriptionAr,
    this.price,
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
    this.special,
    this.salons
  });

  int id;
  String name;
  String nameAr;
  String description;
  String descriptionAr;
  String price;
  String status;
  String slug;
  String ordered;
  String categoryId;
  String salonId;
  DateTime createdAt;
  DateTime updatedAt;
  List<ImageModel> images;
  Category salon;
  Category category;
  Special special;
  Salon salons;

  factory Services.fromJson(Map<String, dynamic> json) {
    return json == null
        ? null
        : Services(
            id: json["id"],
            name: json["name"],
            nameAr: json["name_ar"],
            description: json["description"],
            descriptionAr: json["description_ar"],
            price: json["price"],
            status: json["status"],
            slug: json["slug"],
            ordered: json["ordered"],
            categoryId: json["category_id"],
            salonId: json["salon_id"],
            createdAt: DateTime.parse(json["created_at"]),
            updatedAt: DateTime.parse(json["updated_at"]),
            images: List<ImageModel>.from(
                json["images"].map((x) => ImageModel.fromJson(x))),
            salon: Category.fromJson(json["salon"]),
            category: Category.fromJson(json["category"]),
            salons: Salon.fromJson(json["salons"]),
            special: Special.fromJson(json["special"]),
          );
  }
  Map<String, dynamic> toJson() {
    return {

      "id": id,
      "name": name,
      "name_ar": nameAr,
      "description": description,
      "description_ar": descriptionAr,
      "price": price,
      "status": status,
      "slug": slug,
      "ordered": ordered,
      "category_id": categoryId,
      "salon_id": salonId,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
      "images": List<dynamic>.from(images.map((x) => x.toJson())),
      "salon": salon.toJson(),
      "category": category.toJson(),
      "special": special.toJson(),
    };
  }
}

class Category {
  Category({
    this.id,
    this.name,
    this.nameAr,
    this.image,
    this.address,
  });

  int id;
  String name;
  String nameAr;
  String image;
  String address;

  factory Category.fromJson(Map<String, dynamic> json) {
    return json == null
        ? null
        : Category(
            id: json["id"],
            name: json["name"],
            nameAr: json["name_ar"],
            image: json["image"],
            address: json["address"],
          );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name_ar": nameAr,
        "image": image,
        "address": address,
      };
}
class Salon {
  Salon({
    this.id,
    this.name,
    this.type,
    this.nameAr,
    this.image,
    this.address,
    this.address_ar
  });

  int id;
  String name;
  String nameAr;
  String image;
  String address;
  String type;
  String address_ar;

  factory Salon.fromJson(Map<String, dynamic> json) {
    return json == null
        ? null
        : Salon(
      id: json["id"],
      name: json["name"],
      nameAr: json["name_ar"],
      image: json["image"],
      address: json["address"],
      address_ar:json['address_ar']

    );
  }
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "name_ar": nameAr,
    "image": image,
    "address": address,
    'address_ar':address_ar

  };
}

class ImageModel {
  ImageModel({
    this.image,
    this.serviceId,
  });

  String image;
  String serviceId;

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return json == null
        ? null
        : ImageModel(
            image: json["image"],
            serviceId: json["service_id"],
          );
  }
  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "service_id": serviceId,
    };
  }
}

class Special {
  Special({this.specialPrice, this.serviceId, this.expirydate});

  String specialPrice;
  String serviceId;
  String expirydate;

  factory Special.fromJson(Map<String, dynamic> json) {
    return json == null
        ? null
        : Special(
            specialPrice: json["special_price"].toString(),
            serviceId: json["service_id"],
            expirydate: json["expiry_date"],
          );
  }
  Map<String, dynamic> toJson() => {
        "special_price": specialPrice,
        "service_id": serviceId,
      };
}
