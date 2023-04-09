
import 'package:hive/hive.dart';
import 'package:salonat/models/cartemodel.dart';
import 'package:salonat/models/service.dart';
import 'package:salonat/services/api.dart';

part 'cart.g.dart';

@HiveType(typeId: 2)
class CartModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  DateTime date;
  @HiveField(2)
  List<ServiceModel> services;

  CartModel({this.id, this.date, this.services});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: int.parse(json["id"]),
      date: DateTime.parse(json["date"]),

      services: List.of(json["services"])
          .map((i) => ServiceModel.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "date": this.date.toIso8601String(),


      "services": this.services.map((e) => e.toJson()).toList(),
    };
  }

  Map<String, dynamic> toRequest() {
    return {
      "date": '${this.date.year}-${this.date.month.toString().padLeft(2,'0')}-${date.day}',
      "time": '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}',
      'email': API.USER.email,
      'name': API.USER.name,
      'phone': API.USER.phone,
      "services": this.services.map((e) => {'service_id': e.id, 'quantity': e.qty}).toList(),
    };
  }
}