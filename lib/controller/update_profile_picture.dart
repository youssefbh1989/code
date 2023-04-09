
import 'dart:io';

import 'package:get/get.dart';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';


class UpdateProfileController extends GetxController {
  File profilePicture;

  void updateProfilePicture(File newProfilePicture) {
    profilePicture = newProfilePicture;
    update();
  }
}
