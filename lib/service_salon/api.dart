import 'dart:async';
import 'package:flutter/material.dart';
import '../models/SalonModel.dart';

class API {
  static String baseurl = 'https://salonat.qa/salonapi/';
  static BuildContext mainContext;
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static final titleStream = StreamController.broadcast();
  static final bottomNavBarAnimStream = StreamController<bool>.broadcast();
  static final selectedPageStream = StreamController<int>.broadcast();

  static String token = '';
  static SalonM SALON;
}
