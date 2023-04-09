import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salonat/joinus/joinus.dart';
import 'package:salonat/localisation/language/language.dart';
import 'package:salonat/models/usermodel.dart';
import 'package:salonat/pages/about/about.dart';
import 'package:salonat/pages/auth/signin.dart';
import 'package:salonat/pages/policy/policy.dart';
import 'package:salonat/pages/policy/privacy.dart';
import 'package:salonat/pages/profile/profile.dart';
import 'package:salonat/widget/background_widget.dart';
import 'package:salonat/widget/drawer.dart';
import 'package:sizer/sizer.dart';
import '../constants/constants.dart';
import '../controller/home_controller.dart';
import '../services/api.dart';
import 'appointment/appointment.dart';
import 'editProfile/edit.dart';
import 'favorites/fav.dart';
import 'home/home.dart';

import 'nearby/nearby.dart';
import 'notifications/notifications.dart';
import 'notifications/notifications_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key key, String token, this.profile}) : super(key: key);

  final UserModel profile;

  @override
  _BottomBarState createState() => _BottomBarState();
}

int currentIndex = 0;

class _BottomBarState extends State<BottomBar> {
  DateTime currentBackPressTime;
  double height;
  double width;

  changeIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFECF2),

      drawer: const DrawerWidget(),
      body: WillPopScope(
          onWillPop: () async {
            bool backStatus = onWillPop();
            if (backStatus) {
              exit(0);
            }
            return false;
          },
          child: (currentIndex == 0)
              ? Home(profile: API.USER, token: API.token)
              : (currentIndex == 1)
                  ? Notifications()
                  : (currentIndex == 2)
                      ? Appointment(profile: API.USER, token: API.token)
                      : (currentIndex == 3)
                          ? Fav(profile: API.USER, token: API.token)
                          : Profile(profile: API.USER, token: API.token)),
      bottomNavigationBar: Container(
        height: 12.h,
        alignment: Alignment.center,
        child: BottomAppBar(
          color: Colors.white,
          child: Container(

            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  //focusColor: primaryColor,
                  onTap: () {
                    changeIndex(0);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/home.png',
                        height: API.isPhone ? 25.0 : 35.0,
                        width: API.isPhone ? 25.0 : 55.0,
                        color: (currentIndex == 0)
                            ? primaryColor.withOpacity(0.4)
                            : primaryColor,
                      ),
                      currentIndex == 0
                          ? Text(
                              Languages.of(context).Home,
                              style: TextStyle(
                                  color: (currentIndex == 0)
                                      ? primaryColor.withOpacity(0.4)
                                      : primaryColor,
                                  fontSize: API.isPhone ? 14.0 : 25.0,
                                  fontFamily: 'Calibri'),
                            )
                          : Text(''),
                    ],
                  ),
                ),

                  GestureDetector(
                    onTap: () {
                      //Get.to(() => Notifications());
                      changeIndex(1);
                    },
                    child: Obx(() {
                      int count = 0;
                      Get.find<HomeController>()
                          .notifications
                          .forEach((key, value) {
                        count += value
                            .where((element) => element.isRead == false)
                            .length;
                      });
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(

                            child: Badge(

                                //badgeColor: Colors.red,
                               // showBadge: count > 0,
                                label: Text(
                                  count < 10 ? count.toString() : '!',
                                  style:  TextStyle(
                                      color: Colors.white,
                                      fontSize: API.isPhone ? 15.0 : 30.0,
                                      fontWeight: FontWeight.w900),
                                ),
                                child: Icon(
                                  Icons.notifications,
                                  color: (currentIndex == 1)
                                      ? primaryColor.withOpacity(0.4)
                                      : primaryColor,
                                  size: API.isPhone ? 30.0 : 50.0,
                                )),
                          ),
                          currentIndex == 1
                              ? Text(
                                  Languages.of(context).notifications,
                                  style: TextStyle(
                                      color: (currentIndex == 1)
                                          ? primaryColor.withOpacity(0.4)
                                          : primaryColor,
                                      fontSize: API.isPhone ? 14.0 : 25.0,
                                      fontFamily: 'Calibri'),
                                )
                              : Text(''),
                        ],
                      );
                    }),
                  ),
                GestureDetector(
                  onTap: () {
                    changeIndex(3);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/favorite.png',
                        height: API.isPhone ? 25.0 : 35.0,
                        width: API.isPhone ? 25.0 : 55.0,
                        color: (currentIndex == 3)
                            ? primaryColor.withOpacity(0.4)
                            : primaryColor,
                      ),
                      currentIndex == 3
                          ? Text(
                              Languages.of(context).Favorites,
                              style: TextStyle(
                                  color: (currentIndex == 3)
                                      ? primaryColor.withOpacity(0.4)
                                      : primaryColor,
                                  fontSize: API.isPhone ? 14.0 : 25.0,
                                  fontFamily: 'Calibri'),
                            )
                          : Text(''),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    changeIndex(4);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/profile.png',
                        height: API.isPhone ? 25.0 : 35.0,
                        width: API.isPhone ? 25.0 : 55.0,
                        color: (currentIndex == 4)
                            ? primaryColor.withOpacity(0.4)
                            : primaryColor,
                      ),
                      currentIndex == 4
                          ? Text(
                              Languages.of(context).Profile,
                              style: TextStyle(
                                  color: (currentIndex == 4)
                                      ? primaryColor.withOpacity(0.4)
                                      : primaryColor,
                                  fontSize: API.isPhone ? 14.0 : 25.0,
                                  fontFamily: 'Calibri'),
                            )
                          : Text(''),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
          ? SizedBox(
              height:  API.isPhone ? 40.0 : 80.0,
              width:  API.isPhone ? 40.0 : 80.0,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: primaryColor,
                child: Image.asset(
                  'assets/profilepic/appo.png',
                  fit: BoxFit.cover,
                  height:  API.isPhone ? 25.0 : 40.0,
                ),
                onPressed: () => setState(() {
                  currentIndex = 2;
                }),
              ),
            )
          : Container(),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: blackColor,
        textColor: whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }
}
