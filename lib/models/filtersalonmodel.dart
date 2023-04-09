
class SalonfilterModel {
  SalonfilterModel({
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
  });

  int id;
  String name;
  String nameAr;
  String username;
  String designation;
  String email;
  String code;
  String phone;
  String type;
  String gender;
  String status;
  String image;
  String cover;
  DateTime emailVerifiedAt;
  DateTime phoneVerifiedAt;
  String about;
  String address;
  String regionId;
  dynamic city;
  dynamic country;
  dynamic countryCode;
  dynamic region;
  dynamic regionCode;
  dynamic timezone;
  dynamic postalCode;
  String lat;
  String lng;
  dynamic ip;
  dynamic device;
  DateTime createdAt;
  DateTime updatedAt;

  factory SalonfilterModel.fromJson(Map<String, dynamic> json) => SalonfilterModel(
    id: json["id"],
    name: json["name"],
    nameAr: json["name_ar"],
    username: json["username"],
    designation: json["designation"],
    email: json["email"],
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
    "name_ar": nameAr,
    "username": username,
    "designation": designation,
    "email": email,
    "code": code,
    "phone": phone,
    "type": type,
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
