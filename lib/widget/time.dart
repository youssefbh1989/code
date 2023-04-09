import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';
import '../localisation/language/language.dart';
import '../models/salonmodels.dart';

class Time_widget extends StatelessWidget {
  final SalonModel salon;
  const Time_widget({Key key, this.salon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
      child: salon.saturday_opening != null &&
          salon.sunday_closing != null &&
          salon.sunday_opening != null &&
          salon.friday_opening != null &&
          salon.thursday_closing != null &&
          salon.wednesday_closing != null &&
          salon.thursday_opening != null &&
          salon.wednesday_opening != null &&
          salon.tuesday_closing != null &&
          salon.tuesday_opening != null &&
          salon.monday_closing != null &&
          salon.monday_opening != null
          ? Container(
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
          padding:
          EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 1.h, vertical: 1.w),
                child: Text(
                  Languages.of(context).openinghours,
                  style: black15MediumTextStyle,
                ),
              ),
              heightSpace,
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 1.h, vertical: 1.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Languages.of(context).Monday + ' :',
                          style: greyRegularTextStyle,
                        ),
                        Row(
                          children: [
                            Text(
                              salon.monday_opening,
                              style: white13RegularTextStyle,
                            ),
                            widthSpace,
                            Text(
                              salon.monday_closing,
                              style: white13RegularTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 1.h, vertical: 1.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Languages.of(context).Tuesday + ' :',
                          style: greyRegularTextStyle,
                        ),
                        Row(
                          children: [
                            Text(
                              salon.tuesday_opening,
                              style: white13RegularTextStyle,
                            ),
                            widthSpace,
                            Text(
                              salon.tuesday_closing,
                              style: white13RegularTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 1.h, vertical: 1.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Languages.of(context).Wednesday + ' :',
                          style: greyRegularTextStyle,
                        ),
                        Row(
                          children: [
                            Text(
                              salon.wednesday_opening,
                              style: white13RegularTextStyle,
                            ),
                            widthSpace,
                            Text(
                              salon.wednesday_closing,
                              style: white13RegularTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 1.h, vertical: 1.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Languages.of(context).Thursday + ' :',
                          style: greyRegularTextStyle,
                        ),
                        Row(
                          children: [
                            Text(
                              salon.thursday_opening,
                              style: white13RegularTextStyle,
                            ),
                            widthSpace,
                            Text(
                              salon.thursday_closing,
                              style: white13RegularTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 1.h, vertical: 1.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Languages.of(context).Friday + ' :',
                          style: greyRegularTextStyle,
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Text(
                              salon.friday_opening,
                              style: white13RegularTextStyle,
                            ),
                            widthSpace,
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 1.h, vertical: 1.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Languages.of(context).Saturday + ' :',
                          style: greyRegularTextStyle,
                        ),
                        Row(
                          children: [
                            Text(
                              salon.saturday_opening,
                              style: white13RegularTextStyle,
                            ),
                            widthSpace,
                            Text(
                              salon.saturday_closing,
                              style: white13RegularTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 1.h, vertical: 1.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Languages.of(context).Sunday + ' :',
                          style: greyRegularTextStyle,
                        ),
                        Row(
                          children: [
                            Text(
                              salon.sunday_opening,
                              style: white13RegularTextStyle,
                            ),
                            widthSpace,
                            Text(
                              salon.sunday_closing,
                              style: white13RegularTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
          : Container(),
    );
  }
}
