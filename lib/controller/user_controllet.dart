import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';
import '../models/usermodel.dart';
import '../services/user.dart';

class UserController extends GetxController {
   UserModel user;
   Box _box;
   UserModel get getUser => user;
   Future<void> setUser(UserModel user) async {
    this.user = user;
    update();
    await _box.clear();
    await _box.add(user.toJson());
  }
  @override
  void onInit(){
    _box = Hive.box('user');
    super.onInit();
  }
  Future<String> updatePasswd({ String old,  String passwd}) async {
    return await UsersWebService().updatePasswd(old, passwd);
  }
}