


import 'package:equatable/equatable.dart';

class StaffModel extends Equatable {
  StaffModel({
    this.id,
    this.name,
    this.image,
    this.skills,
  });

  int id;
  String name;
  String image;
  String skills;

  factory StaffModel.fromJson(Map<String, dynamic> json) => StaffModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    skills: json["skills"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "skills": skills,
  };

  @override
  List<Object> get props => [id];
}