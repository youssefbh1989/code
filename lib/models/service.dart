import 'package:hive/hive.dart';

part 'service.g.dart';

@HiveType(typeId: 3)
class ServiceModel extends HiveObject {
  ServiceModel({
    this.id,
    this.name,
    this.nameAr,
    this.images,
    this.qty = 1,
    this.entity,
    this.entityType,
    this.price
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String nameAr;
  @HiveField(3)
  List<ImageCart> images;
  @HiveField(4)
  int qty;
  @HiveField(5)
  Map<String, dynamic> entity;
  @HiveField(6)
  String entityType;
  @HiveField(7)
  double price;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
      id: json["id"],
      name: json["name"],
      nameAr: json["name_ar"],
      price: json.containsKey('price') ? double.tryParse(json['price'])??0 : 0,
      images: List<ImageCart>.from(
          json["images"].map((x) => ImageCart.fromJson(x))),
      entity: !json.containsKey('entity')
          ? null
          :  json['entity']?.toJson(),
    entityType: json['entity_type'].toString()
            );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name_ar": nameAr,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "entity": entity,
        "entity_type": entityType,
    'price': price,
      };
}

@HiveType(typeId: 4)
class ImageCart extends HiveObject {
  ImageCart({
    this.id,
    this.image,
    this.serviceId,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  String image;
  @HiveField(2)
  String serviceId;

  factory ImageCart.fromJson(Map<String, dynamic> json) => ImageCart(
        id: json["id"],
        image: json["image"],
        serviceId: json["service_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "service_id": serviceId,
      };
}
