import 'package:hive/hive.dart';

class SharedPref {
  static Future<String> SaveToken(String token) async {
    await Hive.box('global').put('token', token);
  }
}
