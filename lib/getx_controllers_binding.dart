import 'package:get/get.dart';


import 'controller/addbusiness_controller.dart';
import 'controller/profile_controller.dart';
import 'controller/update_profile_picture.dart';

class ControllersBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => PlaceFormController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => UpdateProfileController(), fenix: true);

  }

}