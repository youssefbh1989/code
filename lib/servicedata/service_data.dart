




import 'package:dio/dio.dart';

import '../models/slider_model.dart';
import '../service_salon/base.dart';

class WebService extends BaseWebService {

  Future<List<SliderModel>> fetchData(String type, ) async {
    try {
      final params = {
        'type': 'Clinic',
      };
      final response =
          (await dio.get('sliders?type=Clinic', queryParameters: params)).data;

      return List.of(response['sliders'])
          .map((banner) => SliderModel.fromJson(banner))
          .toList();
    } on DioError catch (e) {
      if (e.response != null) print(e.response.statusCode);

      print('dio error:   $e');
      return null;
    }
  }


}