import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salonat/models/category.dart';
import 'package:salonat/models/entity.dart';

class ClinicModel extends Equatable implements EntityModel{
  int id;
  String name;
  String cover;
  String nameAr;
  String image;
  String phone;
  String email;
  String rating;
  String address;
  String addressAr;
  String totalUserRated;
  List<String> gallery;
  List<ReviewedUser> reviewedUsers;
  List<CategoryModel>categories;
  double lat;
  double lng;
  LatLng latlng;
  String saturday_opening;
  String sunday_opening;
  String monday_opening;
  String tuesday_opening;
  String wednesday_opening;
  String thursday_opening;
  String friday_opening;
  String saturday_closing;
  String sunday_closing;
  String monday_closing;
  String tuesday_closing;
  String wednesday_closing;
  String thursday_closing;
  String friday_closing;
  String about;
  String aboutAr;
  String openClose;
  String type;
  String service_available;


  ClinicModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.nameAr,
    this.image,
    this.rating,
    this.address,
    this.totalUserRated,
    this.gallery,
    this.lat,
    this.lng,
    //this.latlng,
    this.friday_closing,
    this.friday_opening,
    this.monday_closing,
    this.monday_opening,
    this.saturday_closing,
    this.saturday_opening,
    this.sunday_closing,
    this.sunday_opening,
    this.thursday_closing,
    this.thursday_opening,
    this.tuesday_closing,
    this.tuesday_opening,
    this.wednesday_closing,
    this.wednesday_opening,
    this.about,
    this.aboutAr,
    this.reviewedUsers,
    this.categories,
    this.addressAr,
    this.cover,
    this.openClose,
    this.type,
    this.service_available


  });

  factory ClinicModel.fromJson(Map<String, dynamic> json) {
    return json == null
        ? null
        : ClinicModel(
      id: json["id"],
      name: json["name"],
      openClose: json["open_close"],
      nameAr: json["name_ar"],
      image: json["image"],
      cover: json["cover"],
      service_available:json['service_available'],
      type:json['type'],
      email: json["email"],
      phone: json["phone"].toString(),
      address: json["address"],
      addressAr: json["address_ar"],
      rating: json["rating"].toString(),
      totalUserRated: json["total_user_rated"].toString(),
      lat: json['lat'] != null ? double.parse(json['lat']) : 0,
      lng: json['lng'] != null ? double.parse(json['lng']) : 0,
      //latlng: json['latlng'] ,
      sunday_opening: json["sunday_opening"],
      sunday_closing: json["sunday_closing"],
      friday_opening: json["friday_opening"],
      friday_closing: json["friday_closing"],
      thursday_closing: json["thursday_closing"],
      tuesday_closing: json["tuesday_closing"],
      wednesday_closing: json["wednesday_closing"],
      wednesday_opening: json["wednesday_opening"],
      monday_closing: json["monday_closing"],
      monday_opening: json["monday_opening"],
      saturday_closing: json["saturday_closing"],
      saturday_opening: json["saturday_opening"],
      thursday_opening: json["thursday_opening"],
      tuesday_opening: json["thursday_opening"],
      about: json["about"],
      aboutAr: json["about_ar"],
      reviewedUsers:
          json["reviewed_users"].map((x) => ReviewedUser.fromJson(Map<String, dynamic>.from(x))).toList().cast<ReviewedUser>(),
      categories: json["categories"].map((x) => CategoryModel.fromJson(Map<String, dynamic>.from(x))).toList().cast<CategoryModel>(),
      gallery:
          json["gallery"].map((x) => x['image']).toList().cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "open_close": openClose,
      "name_ar": nameAr,
      "image": image,
      "cover": cover,
      "phone": phone,
      "email": email,
      "gallery": jsonEncode(gallery),
      'categories':jsonEncode(categories),
      "rating": rating,
      "address": address,
      "address_ar": addressAr,
      "total_user_rated": totalUserRated,
      "latlng": latlng,
      "saturday_opening": saturday_opening,
      "sunday_opening": sunday_opening,
      "monday_opening": monday_opening,
      "tuesday_opening": tuesday_opening,
      "wednesday_opening": wednesday_opening,
      "thursday_opening": thursday_opening,
      "friday_opening": friday_opening,
      "saturday_closing": saturday_closing,
      "sunday_closing": sunday_closing,
      "monday_closing": monday_closing,
      "tuesday_closing": tuesday_closing,
      "wednesday_closing": wednesday_closing,
      "thursday_closing": thursday_closing,
      "friday_closing": friday_closing,
      "about": about,
      "about_ar": aboutAr,
      "reviewed_users": reviewedUsers.map((x) => x.toJson()).toList(),
      'categories': categories.map((x) => x.toJson()).toList(),
      "gallery": gallery.map((e) => {'image': e}).toList(),
    };
  }
  Map<String, dynamic> _toRequest() {
    return {
      "id": id,
      "name": name,
      "name_ar": nameAr,
      "image": image,
      "cover": cover,
      "phone": phone,
      "email": email,
      "gallery": jsonEncode(gallery),
      "rating": rating,
      "address": address,
      "address_ar": addressAr,
      "total_user_rated": totalUserRated,
      "latlng": latlng,
      "saturday_opening": saturday_opening,
      "sunday_opening": sunday_opening,
      "monday_opening": monday_opening,
      "tuesday_opening": tuesday_opening,
      "wednesday_opening": wednesday_opening,
      "thursday_opening": thursday_opening,
      "friday_opening": friday_opening,
      "saturday_closing": saturday_closing,
      "sunday_closing": sunday_closing,
      "monday_closing": monday_closing,
      "tuesday_closing": tuesday_closing,
      "wednesday_closing": wednesday_closing,
      "thursday_closing": thursday_closing,
      "friday_closing": friday_closing,
      "about": about,
      "about_ar": aboutAr,
      "reviewed_users": List<dynamic>.from(reviewedUsers.map((x) => x.toJson())),
      "gallery": gallery.map((e) => {'image': e}),
    };
  }

  @override
  // TODO: implement props
  List<Object> get props => [id];

  @override
  EntityModel clone() {
    return ClinicModel.fromJson(toJson());
  }

}
/*
class Gallery {
  Gallery({
    this.image,
  });

  String image;

  factory Gallery.fromJson(Map<String, dynamic> json) {
    return json == null
        ? null
        : Gallery(

      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "image": image,

      };
}

class ReviewedUser {
  ReviewedUser({
    this.userName,
    this.rating,
    this.review,
  });

  String userName;
  String rating;
  String review;

  factory ReviewedUser.fromJson(Map<String, dynamic> json) {

    return json == null
        ? null
        :ReviewedUser(
      userName: json["user_name"],
      rating: json["rating"],
      review: json["review"],
    );
  }
  Map<String, dynamic> toJson() => {
    "user_name": userName,
    "rating": rating,
    "review": review,
  };
}

class Cat {
  Cat({
    this.id,
    this.name,
    this.name_ar,
    this.image,
    this.service_count
  });

  int id;
  String name;
  String image;
  String name_ar;
  String service_count;


  factory Cat.fromJson(Map<String, dynamic> json) {

    return json == null
        ? null
        :Cat(
      id: json["id"],
      name: json["name"],
      name_ar: json["name_ar"],
      image: json["image"],
      service_count: json["service_count"],
    );
  }
  Map<String, dynamic> toJson() => {
    "name_ar": name_ar,
    'name':name,
    "image": image,
    "id": id,
    "service_count": service_count,
  };
}*/
