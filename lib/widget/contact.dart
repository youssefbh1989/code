import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/constants.dart';
import '../localisation/language/language.dart';
import '../models/salonmodels.dart';

class Contact_Widget extends StatelessWidget {
  final SalonModel salon;
  const Contact_Widget({Key key, this.salon}) : super(key: key);

  @override
  Widget build(BuildContext context) {

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white10.withOpacity(0.80),
                borderRadius: BorderRadius.circular(6),
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
                        Languages.of(context).Contact,
                        style: black15MediumTextStyle,
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/profilepic/phone.png',
                            height: 20.sp,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 1.h, vertical: 1.w),
                            child: InkWell(
                              onTap: (){},
                              child: GestureDetector(
                                onTap: () {
                                  launchUrl(Uri.parse(
                                      'tel:${salon.phone.toString() ?? salon.phone.toString() ?? ''}'));
                                },
                                child: Text(
                                  salon.phone.toString(),
                                  style: greyRegularTextStyle,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/profilepic/web.png',
                            height: 20.sp,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              launchUrl(Uri.parse('mailto:${ salon.email.toString()}'));
                            },
                            child: Text(
                              salon.email.toString(),
                              style: greyRegularTextStyle,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }





}
