
import 'package:hive/hive.dart';

part 'SalonModel.g.dart';

@HiveType(typeId: 1)
class SalonM extends HiveObject{

  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String nameAr;
  @HiveField(3)
  String username;
  @HiveField(4)
  String designation;
  @HiveField(5)
  String email;
  @HiveField(6)
  String code;
  @HiveField(7)
  String phone;
  @HiveField(8)
  String type;
  @HiveField(9)
  String service_available;
  @HiveField(9)
  String gender;
  @HiveField(10)
  String status;
  @HiveField(11)
  String image;
  @HiveField(12)
  String cover;
  @HiveField(13)
  DateTime emailVerifiedAt;
  @HiveField(14)
  DateTime phoneVerifiedAt;
  @HiveField(15)
  String about;
  @HiveField(16)
  String address;
  @HiveField(17)
  String regionId;
  @HiveField(18)
  dynamic city;
  @HiveField(19)
  dynamic country;
  @HiveField(20)
  dynamic countryCode;
  @HiveField(21)
  dynamic region;
  @HiveField(22)
  dynamic regionCode;
  @HiveField(23)
  dynamic timezone;
  @HiveField(24)
  dynamic postalCode;
  @HiveField(25)
  String lat;
  @HiveField(26)
  String lng;
  @HiveField(27)
  dynamic ip;
  @HiveField(28)
  dynamic device;
  @HiveField(29)
  DateTime createdAt;
  @HiveField(30)
  DateTime updatedAt;
  @HiveField(31)
  String open_close;


  SalonM({
    this.id,
    this.name,
    this.nameAr,
    this.username,
    this.designation,
    this.email,
    this.code,
    this.phone,
    this.type,
    this.gender,
    this.status,
    this.image,
    this.cover,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    this.about,
    this.address,
    this.regionId,
    this.city,
    this.country,
    this.countryCode,
    this.region,
    this.regionCode,
    this.timezone,
    this.postalCode,
    this.lat,
    this.lng,
    this.ip,
    this.device,
    this.createdAt,
    this.updatedAt,
    this.open_close,
    this.service_available
  });

  factory SalonM.fromJson(Map<String, dynamic> json) => SalonM(
    id: json["id"],
    open_close: json["open_close"],
    name: json["name"],
    nameAr: json["name_ar"],
    username: json["username"],
    designation: json["designation"],
    email: json["email"],
    service_available: json["service_available"],
    code: json["code"],
    phone: json["phone"],
    type: json["type"],
    gender: json["gender"],
    status: json["status"],
    image: json["image"],
    cover: json["cover"],
    emailVerifiedAt:json['email_verified_at'] == null ? null: DateTime.parse(json["email_verified_at"]as String),
    phoneVerifiedAt: json['phone_verified_at'] == null ? null:DateTime.parse(json["phone_verified_at"]as String),
    about: json["about"],
    address: json["address"],
    regionId: json["region_id"],
    city: json["city"],
    country: json["country"],
    countryCode: json["country_code"],
    region: json["region"],
    regionCode: json["region_code"],
    timezone: json["timezone"],
    postalCode: json["postal_code"],
    lat: json["lat"],
    lng: json["lng"],
    ip: json["ip"],
    device: json["device"],
    createdAt:json['created_at'] == null ? null:  DateTime.parse(json["created_at"]as String),
    updatedAt: json['updated_at'] == null ? null:DateTime.parse(json["updated_at"]as String),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "open_close": open_close,
    "name_ar": nameAr,
    "username": username,
    "designation": designation,
    "email": email,
    "code": code,
    "phone": phone,
    "type": type,
    "service_available": service_available,
    "gender": gender,
    "status": status,
    "image": image,
    "cover": cover,
    "email_verified_at": emailVerifiedAt.toString(),
    "phone_verified_at": phoneVerifiedAt.toString(),
    "about": about,
    "address": address,
    "region_id": regionId,
    "city": city,
    "country": country,
    "country_code": countryCode,
    "region": region,
    "region_code": regionCode,
    "timezone": timezone,
    "postal_code": postalCode,
    "lat": lat,
    "lng": lng,
    "ip": ip,
    "device": device,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
