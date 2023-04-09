import 'package:get/get.dart';
import 'package:salonat/controller/filtercontroller.dart';
import 'package:salonat/controller/home_controller.dart';
import 'package:salonat/controller/user_controllet.dart';

import '../controller/search_controller.dart';


class ControllersBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => SearchController(), fenix: true);
    Get.lazyPut(() => FilterController(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);

  }

}