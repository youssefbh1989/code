import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salonat/constants/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'localisation/language/language.dart';
import 'services/api.dart';




class UpdateScreen extends StatefulWidget {
  UpdateScreen({Key key}) : super(key: key);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Languages.of(context).updateRequired,
                style: GoogleFonts.cairo(color: primaryColor, fontSize:  API.isPhone ? 15.0 : 30.0,),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 6.h,
              ),
              MaterialButton(
                onPressed: () => launch(Platform.isIOS
                    ? 'https://apps.apple.com/tt/app/salonat/id1636304913'
                    : 'https://play.google.com/store/apps/details?id=com.smarttech.salon'),
                child: Text(
                  Languages.of(context).updateNow,
                  style:
                      TextStyle(fontSize:  API.isPhone ? 25.0 : 50.0,
                        fontWeight: FontWeight.w500,),
                ),
                color: primaryColor,
                mouseCursor: MouseCursor.defer,
                textColor: whiteColor,
                minWidth: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
