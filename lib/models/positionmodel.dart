import 'package:equatable/equatable.dart';

class PositionModel extends Equatable{
  double lat;
  double lng;

  PositionModel({this.lat, this.lng});

  factory PositionModel.fromJson(Map<String, dynamic> json) {
    return json == null
        ? null
        : PositionModel(
            lat: double.tryParse(json["lat"].toString()),
            lng: double.tryParse(json["lng"].toString()),
          );
  }

  Map<String, dynamic> toJson() {
    return {
      "lat": lat,
      "lng": lng,
    };
  }

  @override
  List<Object> get props => [lat, lng];
}
