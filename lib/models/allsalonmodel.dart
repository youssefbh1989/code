import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class allsalonmodel extends Equatable {
  int id;
  String name;
  String name_ar;
  String image;
  double lat;
  double lng;
  LatLng latlng;

  allsalonmodel({
    this.id,
    this.name,
    this.name_ar,
    this.image,
    this.lat,
    this.lng,
    this.latlng,
  });

  factory allsalonmodel.fromJson(Map<String, dynamic> json) {
    return json == null
        ? null
        : allsalonmodel(
            id: json["id"],
            name: json["name"],
            name_ar: json["name_ar"],
            image: json["image"],
            lat: json['lat'] != null ? double.parse(json['lat']) : 0,
            lng: json['lng'] != null ? double.parse(json['lng']) : 0,
          );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "name_ar": name_ar,
      "image": image,
      "latlng": latlng,
    };
  }

  Map<String, dynamic> _toRequest() {
    return {
      "id": id,
      "name": name,
      "name_ar": name_ar,
      "image": image,
      "latlng": latlng,
    };
  }

  @override

  List<Object> get props => throw UnimplementedError();
}



