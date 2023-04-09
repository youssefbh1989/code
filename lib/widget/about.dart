import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salonat/models/salonmodels.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';
import '../localisation/language/language.dart';

class About_widget extends StatelessWidget {
  final SalonModel salon;
  const About_widget({Key key, this.salon}) : super(key: key);

  @override
  Widget build(BuildContext context) {


          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white10.withOpacity(0.80),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: blackColor.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                      child: Text(
                        Languages.of(context).about,
                        style: black15MediumTextStyle,
                      ),
                    ),
                    heightSpace,
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                      child: ExpandableText(
                        _removeAllHtmlTags(
                            Languages.of(context).labelSelectLanguage ==
                                'English'
                                ? salon.about
                                : salon.aboutAr),
                        expandText: Languages.of(context).showmore,
                        collapseText: Languages.of(context).showless,
                        maxLines: 5,
                        linkColor: const Color(0xFF9B16A1),
                        linkStyle: primaryColor13BoldTextStyle,
                        style: grey13RegularTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
    }






  String _removeAllHtmlTags(String htmlText) {
    if (htmlText == null) return 'N/A';
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }
}
