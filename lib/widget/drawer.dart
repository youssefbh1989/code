import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:salonat/constants/constants.dart';
import 'package:salonat/joinus/joinus.dart';
import 'package:salonat/localisation/language/language.dart';
import 'package:salonat/pages/about/about.dart';
import 'package:salonat/pages/auth/signin.dart';
import 'package:salonat/pages/policy/policy.dart';
import 'package:salonat/pages/policy/privacy.dart';
import 'package:salonat/services/api.dart';
import 'package:sizer/sizer.dart';

import '../add_salon/Add_Salon.dart';
import '../pages/addb.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return API.USER != null
        ? SizedBox(
      width:  API.isPhone ? 250.0 : 400.0,
      child: Drawer(
          backgroundColor: Colors.white,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: SizedBox(
                    height: 30.h,
                    width: double.infinity,
                    child: DrawerHeader(

                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Image.asset('assets/specialists/logo-01.png',
                            color: primaryColor, height: 15.h,),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        title: Text(
                          Languages.of(context).about,
                          style: TextStyle(
                              color: primaryColor,
                              fontSize:  API.isPhone ? 20.0 : 40.0,
                              fontFamily: 'Calibri'),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: primaryColor,
                            size: API.isPhone ? 15.0 : 30.0,),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const About()),
                          );
                        },
                      ),
                      ListTile(
                        title: Text(
                          Languages.of(context).terms,
                          style: TextStyle(
                              color: primaryColor,
                              fontSize:  API.isPhone ? 20.0 : 40.0,
                              fontFamily: 'Calibri'),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: primaryColor,
                            size: API.isPhone ? 15.0 : 30.0,),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Policy()),
                          );
                        },
                      ),
                      ListTile(
                        title: Text(
                          Languages.of(context).privacy,
                          style: TextStyle(
                              color: primaryColor,
                              fontSize:  API.isPhone ? 20.0 : 40.0,
                              fontFamily: 'Calibri'),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: primaryColor,
                            size: API.isPhone ? 15.0 : 30.0,),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Privacy()),
                          );
                        },
                      ),
                      ListTile(
                        title: Text(
                          Languages.of(context).JoinUs,
                          style: TextStyle(
                              color: primaryColor,
                              fontSize:  API.isPhone ? 20.0 : 40.0,
                              fontFamily: 'Calibri'),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: primaryColor,
                            size:  API.isPhone ? 15.0 : 30.0,),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  PlaceFormPage()),
                          );
                        },
                      ),

                    ],
                  ),
                )
              ])),
    )
        : SizedBox(
      width:  API.isPhone ? 250.0 : 400.0,
      child: Drawer(
          backgroundColor: Colors.white,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child:  SizedBox(
                    height: 30.h,
                    width: double.infinity,
                    child: DrawerHeader(

                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Image.asset('assets/specialists/logo-01.png',
                            color: primaryColor, height: 15.h,),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        title: Text(
                          Languages.of(context).Login_and_Signup,
                          style: TextStyle(
                              color: primaryColor,
                              fontSize:  API.isPhone ? 20.0 : 40.0,
                              fontFamily: 'Calibri'),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: primaryColor,
                          size: API.isPhone ? 15.0 : 30.0,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Signin()),
                          );
                        },
                      ),
                      ListTile(
                        title: Text(
                          Languages.of(context).about,
                          style: TextStyle(
                              color: primaryColor,
                              fontSize:  API.isPhone ? 20.0 : 40.0,
                              fontFamily: 'Calibri'),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: primaryColor,
                          size: API.isPhone ? 15.0 : 30.0,),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const About()),
                          );
                        },
                      ),
                      ListTile(
                        title: Text(
                          Languages.of(context).terms,
                          style: TextStyle(
                              color: primaryColor,
                              fontSize:  API.isPhone ? 20.0 : 40.0,
                              fontFamily: 'Calibri'),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: primaryColor,
                          size: API.isPhone ? 15.0 : 30.0,),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Policy()),
                          );
                        },
                      ),
                      ListTile(
                        title: Text(
                          Languages.of(context).privacy,
                          style: TextStyle(
                              color: primaryColor,
                              fontSize:  API.isPhone ? 20.0 : 40.0,
                              fontFamily: 'Calibri'),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: primaryColor,
                          size: API.isPhone ? 15.0 : 30.0,),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Privacy()),
                          );
                        },
                      ),
                      ListTile(
                        title: Text(
                          Languages.of(context).JoinUs,
                          style: TextStyle(
                              color: primaryColor,
                              fontSize:  API.isPhone ? 20.0 : 40.0,
                              fontFamily: 'Calibri'),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: primaryColor,
                          size: API.isPhone ? 15.0 : 30.0,),
                        onTap: () {
                          Get.to(()=>PlaceFormPage());
                        },
                      ),
                    ],
                  ),
                )
              ])),
    );
  }
}
