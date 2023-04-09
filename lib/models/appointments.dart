import 'package:equatable/equatable.dart';

class AppointmentsModel extends Equatable{
  AppointmentsModel({
    this.id,
    this.userId,
    this.status,
    this.name,
    this.image,
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
    this.address,
    this.appointmentservices,
    this.history,
    this.salon_name,
    this.salon_name_ar,
    this.address_ar
  });

  int id;
  String userId;
  String status;
  String name;
  String phone;
  String email;
  DateTime date;
  String image;
  String time;
  String price;
  String paymentMethod;
  String referenceId;
  dynamic comments;
  DateTime createdAt;
  String salonId;
  String salonName;
  String salonNameAr;
  String address;
  String address_ar;
  List<Appointmentservice> appointmentservices;
  String salon_name;
  String salon_name_ar;
  List<History> history;

  factory AppointmentsModel.fromJson(Map<String, dynamic> json) {
    return json == null
        ? null
        : AppointmentsModel(
      id: json["id"],
      userId: json["user_id"],
      status: json["status"],
      name: json["name"],
      salon_name: json["salon_name"],
      salon_name_ar: json["salon_name_ar"],
      image: json["image"],
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
      address: json["address"],
      address_ar: json["address_ar"],
      appointmentservices: List<Appointmentservice>.from(
          json["appointmentservices"].map((x) =>
              Appointmentservice.fromJson(x))),
      history: List<History>.from(
          json["history"].map((x) => History.fromJson(x))),
    );
  }
  Map<String, dynamic> toJson() {


    return{
    "id": id,
    "user_id": userId,
    "status": status,
    "name": name,
      "salon_name": salon_name,
      "salon_name_ar": salon_name_ar,
    "phone": phone,
      "image": image,
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
    "address": address,
      "address_ar": address_ar,
    "appointmentservices": List<dynamic>.from(appointmentservices.map((x) => x.toJson())),
    "history": List<dynamic>.from(history.map((x) => x.toJson())),
  };
}

  @override

  List<Object> get props => [id];
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

class History {
  History({
    this.status,
    this.comments,
    this.createdAt,
  });

  String status;
  String comments;
  DateTime createdAt;

  factory History.fromJson(Map<String, dynamic> json) => History(
    status: json["status"],
    comments: json["comments"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "comments": comments,
    "created_at": createdAt.toIso8601String(),
  };
}
