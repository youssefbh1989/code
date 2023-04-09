import 'dart:async';
import 'package:flutter/material.dart';
import 'package:salonat/models/usermodel.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class API {
  static String baseurl = 'https://salonat.qa/api/';
  static BuildContext mainContext;
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static final titleStream = StreamController.broadcast();
  static final bottomNavBarAnimStream = StreamController<bool>.broadcast();
  static final selectedPageStream = StreamController<int>.broadcast();
  static bool isPhone = Device.get().isPhone;
  static String token = '';
  static UserModel USER;
}
