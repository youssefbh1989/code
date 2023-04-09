


import 'package:get/get.dart';

import '../models/slider_model.dart';
import '../servicedata/service_data.dart';

class sliders extends GetxController {
  var data = List<SliderModel>.empty(growable: true).obs;
  var isLoading = true.obs;


  @override
  void onInit() {
    super.onInit();
    WebService().fetchData('Clinic').then((result) {
      data.value = result;
      isLoading.value = false;
    }).catchError((error) {
      isLoading.value = false;
      Get.snackbar('Error', error.toString());
    });
  }
}