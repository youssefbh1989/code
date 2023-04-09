import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

part 'usermodel.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String email;
  @HiveField(3)
  String photo;
  @HiveField(4)
  String phone;
  @HiveField(5)
  String password;
  @HiveField(6)
  String password_confirmation;
  @HiveField(7)
  String old_password;
  @HiveField(8)
  String verification_code;
  @HiveField(9)
  String token;
  @HiveField(10)
  String phone_verified_at;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.photo,
      this.phone,
      this.old_password,
      this.password,
      this.password_confirmation,
      this.verification_code,
      this.token,
      this.phone_verified_at});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: int.parse(json["id"].toString()),
      name: json["name"],
      photo: json['image'],
      phone: json['phone'],
      email: json["email"],
      verification_code: json["verification_code"].toString(),
      phone_verified_at: json["phone_verified_at"].toString(),
      token: json["token"],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "name": name,
      "email": email,
      "photo": photo,
      'phone': phone,
      'verification_code': verification_code,
      'phone_verified_at': phone_verified_at,
      'token': token,
    };
  }

  Map<String, dynamic> toRequest() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      'password_confirmation': password_confirmation,
      'verification_code': verification_code,
      'phone_verified_at': phone_verified_at,
      "token": token,
    };
  }

  Map<String, dynamic> toUpdateRequest() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
    };
  }

  Map<String, dynamic> toUpdatePasswordRequest() {
    return {
      "password": password,
      "old_password": old_password,
    };
  }
  UserModel clone() {
    return UserModel.fromJson(toJson());
  }

  @override
  List<Object> get props => [id];
}
