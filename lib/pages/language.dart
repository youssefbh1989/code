import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';
import '../intro_screen.dart';
import '../localisation/locale_constant.dart';
import '../service_salon/api.dart';
import 'auth/onboarding.dart';
import 'bordingscreen/onBording_screen.dart';
import 'bottom_bar.dart';

class Language extends StatefulWidget {
  const Language({Key key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {

  void selectLang(String lang) async {

    changeLanguage(context, lang);

    setState(() {});
    await Hive.box('global').put('isBoadrdingScreen', 'done');
    API.token == null ?Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BottomBar())
    ):Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) =>  IntroScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6e3e3),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: Container(
        color: Colors.white10.withOpacity(0.8),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
             Container(
               child: Image.asset(
                 'assets/specialists/logo-01.png',
                 height: 30.h,
                width: 100.w,
                 color: primaryColor,
               ),
             ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  height: 5.h,
                  color: whiteColor,
                  onPressed: () {
                    selectLang('en');
                  },
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              ClipOval(child: Image.asset('assets/new/england.png')),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text('English',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                     color: primaryColor,

                                     fontFamily: 'Calibri_bold')),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  height: 5.h,
                  minWidth: 20.w,
                  color: whiteColor,
                  onPressed: () {
                    selectLang('ar');
                  },
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              ClipOval(child: Image.asset('assets/new/qatar.png')),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text('العربية',
                                  style: TextStyle(
                                    color: primaryColor,
                                      fontSize: 15.sp,
                                      fontFamily: 'Calibri_bold')),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
