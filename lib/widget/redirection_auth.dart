import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';
import '../localisation/language/language.dart';
import '../pages/auth/signin.dart';

class Redirection_auth extends StatefulWidget {
  const Redirection_auth({Key key}) : super(key: key);

  @override
  State<Redirection_auth> createState() => _Redirection_authState();
}

class _Redirection_authState extends State<Redirection_auth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo- white.png',
              width: 40.w,
              height: 25.h,
              color: primaryColor,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(Languages.of(context).youneedtologin,
                style: TextStyle(
                    fontSize: 15.sp,
                    color: primaryColor,
                    fontFamily: 'Calibri')),
            SizedBox(
              height: 3.h,
            ),
            MaterialButton(
              padding: EdgeInsets.symmetric(horizontal: 3.h),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              height: 5.h,
              color: Color(0xffED3D7B),
              mouseCursor: MouseCursor.defer,
              textColor: Colors.white,
              minWidth: 85.w,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Signin()),
              ),
              child: Text(Languages.of(context).login,
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: whiteColor,
                      fontFamily: 'Calibri',
                  fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
