import 'package:hive/hive.dart';
import 'package:salonat/models/service.dart';

class CarteModel {
  CarteModel({
    this.id,
    this.userId,
    this.serviceId,
    this.basketQuantity,
    this.price,
    this.finalPrice,
    this.ordered,
    this.createdAt,
    this.updatedAt,
    this.service,
  });

  int id;
  String userId;
  String serviceId;
  String basketQuantity;
  String price;
  String finalPrice;
  String ordered;
  DateTime createdAt;
  DateTime updatedAt;
  ServiceModel service;

  factory CarteModel.fromJson(Map<String, dynamic> json) => CarteModel(
    id: json["id"],
    userId: json["user_id"],
    serviceId: json["service_id"],
    basketQuantity: json["basket_quantity"],
    price: json["price"],
    finalPrice: json["final_price"],
    ordered: json["ordered"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    service: ServiceModel.fromJson(json["service"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "service_id": serviceId,
    "basket_quantity": basketQuantity,
    "price": price,
    "final_price": finalPrice,
    "ordered": ordered,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "service": service.toJson(),
  };
}

