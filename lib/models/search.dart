
import 'package:salonat/models/salonmodels.dart';
import 'package:salonat/models/service_filter.dart';

class SearchModel {
  final List<SalonModel> salon;







  SearchModel({ this.salon,    });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      salon: List.of(json["salons"])
          .map((i) => SalonModel.fromJson(i))
          .toList(),










    );
  }


  int _length() {
    int ln = 0;
    if (salon.isNotEmpty) {
      ln++;
    }



    return ln;
  }

  int get length => _length();
//

}