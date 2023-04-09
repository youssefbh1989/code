import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:salonat/pages/bottom_bar.dart';
import 'package:salonat/pages/home/home.dart';
import 'package:salonat/services/api.dart';
import 'package:update_checker/update_checker.dart';
import '../intro_screen.dart';
import '../services/data_repository.dart';
import '../update_screen.dart';
import 'language.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light
        )
    );
    //_checkForUpdate();
    super.initState();
    initData();
    /*   Timer(
        const Duration(seconds: 20),
       () => Navigator.pushReplacement(
           context, MaterialPageRoute(builder: (context) =>  const Language())),
     );*/
  }

  void initData() async {

    final dataProvider = Provider.of<DataReposotory>(context, listen: false);
    await dataProvider.initData();
    final box = Hive.box('global');
    API.token = box.get('token');
    API.USER = box.get('user');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return API.token == null ? Language() : BottomBar();
    }));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exit(0),
      child: Container(
          child: Image.asset(
        'assets/salon/salon.gif',
        fit: BoxFit.fill,
      )),
    );
  }

  Future<void> _checkForUpdate() async {
    try {
      final update = await UpdateChecker().checkForUpdates(Platform.isIOS
          ? 'https://apps.apple.com/tt/app/salonat/1636304913'
          : 'https://play.google.com/store/apps/details?id=com.smarttech.salon');

      if (update)
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => UpdateScreen()),
            (route) => false);
      else
        initData();
    } catch (e) {
      log('error isssssssssss:    $e');
      initData();
    }
  }
}
