
import 'package:salonat/models/salonmodels.dart';
import 'package:salonat/models/service_filter.dart';

class FilterModel {
  final List<SalonModel> salon;
  final List<ServiceFilterModel> service;


  FilterModel({ this.salon,  this.service,  });

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
      salon: List.of(json["salons"])
          .map((i) => SalonModel.fromJson(i))
          .toList(),
      service: List.of(json["services"])
          .map((i) => ServiceFilterModel.fromJson(i))
          .toList(),

    );
  }


  int _length() {
    int ln = 0;
    if (salon.isNotEmpty) {
      ln++;
    }
    if (service.isNotEmpty) {
      ln++;
    }


    return ln;
  }

  int get length => _length();
//

}