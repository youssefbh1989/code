
class Salonappointementsmodel {
  Salonappointementsmodel({
    this.id,
    this.userId,
    this.status,
    this.name,
    this.phone,
    this.email,
    this.date,
    this.time,
    this.price,
    this.paymentMethod,
    this.referenceId,
    this.comments,
    this.createdAt,
    this.salonId,
    this.salonName,
    this.salonNameAr,
    this.image,
    this.address,
    this.lat,
    this.lng,
    this.appointmentservices,

  });

  int id;
  String userId;
  String status;
  String name;
  String phone;
  String email;
  DateTime date;
  String time;
  String price;
  String paymentMethod;
  String referenceId;
  dynamic comments;
  DateTime createdAt;
  String salonId;
  String salonName;
  String salonNameAr;
  String image;
  String address;
  String lat;
  String lng;
  List<Appointmentservice> appointmentservices;


  factory Salonappointementsmodel.fromJson(Map<String, dynamic> json) {
    return json==null
      ?null
    :Salonappointementsmodel(
      id: json["id"],
      userId: json["user_id"],
      status: json["status"],
      name: json["name"],
      phone: json["phone"],
      email: json["email"],
      date: DateTime.parse(json["date"]),
      time: json["time"],
      price: json["price"],
      paymentMethod: json["payment_method"],
      referenceId: json["reference_id"],
      comments: json["comments"],
      createdAt: DateTime.parse(json["created_at"]),
      salonId: json["salon_id"],
      salonName: json["salon_name"],
      salonNameAr: json["salon_name_ar"],
      image: json["image"],
      address: json["address"],
      lat: json["lat"],
      lng: json["lng"],
      appointmentservices: List<Appointmentservice>.from(
          json["appointmentservices"].map((x) =>
              Appointmentservice.fromJson(x))),

    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "status": status,
    "name": name,
    "phone": phone,
    "email": email,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time": time,
    "price": price,
    "payment_method": paymentMethod,
    "reference_id": referenceId,
    "comments": comments,
    "created_at": createdAt.toIso8601String(),
    "salon_id": salonId,
    "salon_name": salonName,
    "salon_name_ar": salonNameAr,
    "image": image,
    "address": address,
    "lat": lat,
    "lng": lng,
    "appointmentservices": List<dynamic>.from(appointmentservices.map((x) => x.toJson())),

  };
}

class Appointmentservice {
  Appointmentservice({
    this.id,
    this.serviceId,
    this.name,
    this.nameAr,
    this.image,
    this.price,
    this.finalPrice,
    this.comments,
    this.createdAt,
  });

  int id;
  String serviceId;
  String name;
  String nameAr;
  String image;
  String price;
  String finalPrice;
  dynamic comments;
  DateTime createdAt;

  factory Appointmentservice.fromJson(Map<String, dynamic> json) => Appointmentservice(
    id: json["id"],
    serviceId: json["service_id"],
    name: json["name"],
    nameAr: json["name_ar"],
    image: json["image"],
    price: json["price"],
    finalPrice: json["final_price"],
    comments: json["comments"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "service_id": serviceId,
    "name": name,
    "name_ar": nameAr,
    "image": image,
    "price": price,
    "final_price": finalPrice,
    "comments": comments,
    "created_at": createdAt.toIso8601String(),
  };
}


