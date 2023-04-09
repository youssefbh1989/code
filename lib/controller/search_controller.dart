import 'package:get/get.dart';
import '../models/salonmodels.dart';
import '../models/search.dart';
import '../services/apiservice.dart';


class SearchController extends GetxController {
  SearchModel result;
  List<SalonModel> salons = [];
  List<SalonModel> artist = [];
  List<SalonModel> clinics = [];
  List<SalonModel> supplier = [];
  search(String keyword) async {
    result = await WebService().search(keyword);
    salons = result.salon.where((element)
        => element.type == 'Salon').toList();
    clinics = result.salon.where((element)
    => element.type == 'Clinic').toList();
    artist = result.salon.where((element)
    => element.type == 'Artist').toList();
    supplier = result.salon.where((element)
    => element.type == 'Vendor').toList();
    update();
  }
  searchsalonhome(String keyword, String text) async {
    result = await WebService().searchsalonhome(keyword,text);
    salons=result.salon;

    update();
  }
  removeSearch() {
    result = null;
  }
}