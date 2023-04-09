import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salonat/models/artistmodel.dart';
import 'package:salonat/models/category.dart';
import 'package:salonat/models/clinicsmodel.dart';
import 'package:salonat/models/salonmodels.dart';

abstract class EntityModel {
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
  List<CategoryModel> categories;
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


  factory EntityModel.fromJson(String type, Map<String, dynamic> json) {
    return type == 'SalonModel'
        ? SalonModel.fromJson(json)
        : type == 'ArtistModel'
        ? ArtistModel.fromJson(json)
        : ClinicModel.fromJson(json);
  }

  EntityModel clone();

  Map<String, dynamic> toJson();
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
        : ReviewedUser(
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

class service {
  int id;
  String name;
  String nameAr;
  String price;
  String description;
  String descriptionAr;
  String salonId;
  String categoryId;
  String special;

  service(
      {this.id,
        this.name,
        this.nameAr,
        this.price,
        this.description,
        this.descriptionAr,
        this.salonId,
        this.categoryId,
        this.special});

  service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    price = json['price'];
    description = json['description'];
    descriptionAr = json['description_ar'];
    salonId = json['salon_id'];
    categoryId = json['category_id'];
    special = json['special'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['price'] = this.price;
    data['description'] = this.description;
    data['description_ar'] = this.descriptionAr;
    data['salon_id'] = this.salonId;
    data['category_id'] = this.categoryId;
    data['special'] = this.special;
    return data;
  }
}