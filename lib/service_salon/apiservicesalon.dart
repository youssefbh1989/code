import 'package:dio/dio.dart';
import 'package:salonat/service_salon/base.dart';
import '../models/RevenueModel.dart';
import '../models/SalonappointementsModel.dart';
class WebSalon extends BaseWebService {
  Future<List<Salonappointementsmodel>> getsalonappointements(int page,
      {String query}) async {
    Map<String, dynamic> data = {'page': page};
    if (query != null) {
      data['search'] = query;
    }
    try {
      final response =
          (await dio.get('appointments', queryParameters: data)).data;
      List<Salonappointementsmodel> appointements = [];
      for (final salon in List.of(response['appointments'])) {
        if (salon != null) {
          appointements.add(Salonappointementsmodel.fromJson(salon));
        }
      }
      return appointements;
    } on DioError {
      return [];
    }
  }

  Future<List<RevenueModel>> getrevenue( {String start,String end}) async {
    final data = {
      'start': start,
      'end': end,
    };

      final response = (await dio.get('revenue?start=$start&end=$end', queryParameters: data)).data;
      List<RevenueModel> revenues = [];
      for (final revenue in List.of(response['revenue'])) {
        if (revenue != null) {
          revenues.add(RevenueModel.fromJson(revenue));

        }
      }
      return revenues;

  }

}
