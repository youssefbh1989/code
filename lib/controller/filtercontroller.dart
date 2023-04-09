

import 'package:get/get.dart';
import '../models/search.dart';
import '../services/apiservice.dart';


class FilterController extends GetxController {
  SearchModel result;
  filter(String min,String max,String service_available, int page ) async {
    result = await WebService().filter(min,max,service_available);
    update();
  }
  removeFilter() {
    result = null;
  }
}