import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salonat/localisation/language/language.dart';
import 'package:salonat/models/salonmodels.dart';
import 'package:salonat/models/usermodel.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants.dart';
import '../../localisation/locale_constant.dart';
import '../../models/cartemodel.dart';
import '../../services/apiservice.dart';
import '../bottom_bar.dart';

class AppointmentDetails extends StatefulWidget {
  final Object tag;
  final String image;
  final String name;
  final String address;
  final String rating;
  final String services;
  final String specialiste;
  final String appointementdatetime;
  final SalonModel salon;
  final String staff;
  final String date;
  final String time;
  final UserModel profile;

  const AppointmentDetails(
      {Key key,
      this.tag,
      this.image,
      this.name,
      this.address,
      this.rating,
      this.services,
      this.appointementdatetime,
      this.specialiste,
      this.salon,
      this.staff,
      this.date,
      this.time,
      this.profile})
      : super(key: key);

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  double height;
  double width;

  List<CarteModel> _carte = [];
  bool _isloading = true;
  @override
  void initState() {
    super.initState();
    WebService().getcart(0).then((value) {
      setState(() {
        _carte = value;
        _isloading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/new/back.png"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 15.sp,
            ),
          ),
          actions: [


          ],
          title: Text(
            Languages.of(context).appointementsdetails,
            style: TextStyle(color: whiteColor,fontSize: 15.sp,fontFamily: 'Calibri_bold'),
          ),
        ),
        body:    _isloading
            ? const Center(
          child: CircularProgressIndicator(

            color: primaryColor,
          ),
        )
            :ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 1.h),
          children: [
            SizedBox(
              height: 20.h,
            ),
          details(),
          ],
        ),
        bottomNavigationBar: bookNowButton(context),
      ),
    );
  }

  details() {
    return Container(
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
              padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
              child:       Row(
                children: [
                  Container(
                    height: 15.h,
                    width: 32.w,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(60)),
                      image: DecorationImage(
                        image: NetworkImage('http://salonat.qa/' +
                            widget.salon.image),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w,),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          Languages.of(context)
                              .labelSelectLanguage ==
                              'English'
                              ? widget.salon.name
                              : widget.salon.nameAr,
                          style: black14MediumTextStyle,
                        ),
                        SizedBox(height: 1.h),
                        Text(
                            Languages.of(context)
                                .labelSelectLanguage ==
                                'English'
                                ? widget.salon.address
                                : widget.salon.addressAr,
                            style: grey12RegularTextStyle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: 1.w,
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 1.h,vertical: 1.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.place,size: 15.sp,color: blackColor,),
                          SizedBox(width: 2.w,),
                          Text(
                              Languages.of(context).labelSelectLanguage == 'English'
                                  ? widget.salon.address
                                  : widget.salon.addressAr,
                              style: TextStyle(color:blackColor,fontSize: 15.sp,fontFamily: 'Calibri_bold' ),
                              maxLines: 2,
                              overflow: TextOverflow.clip),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 2,
              height: 2.h,
              color: Colors.grey,
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Expanded(
            //         flex: 2,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           children: [
            //             Padding(
            //               padding: EdgeInsets.symmetric(
            //                   horizontal: 1.h, vertical: 1.w),
            //               child: Row(
            //                 children: [
            //                   Text(
            //                     Languages.of(context).labelSelectLanguage ==
            //                         'English'
            //                         ? _carte[0].service.name
            //                         : _carte[0].service.nameAr,
            //                     style: TextStyle(color: const Color(0xFF2E3A59),fontSize: 15.sp,fontFamily: 'Calibri'),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             SizedBox(
            //               height: 1.h,
            //             ),
            //             Padding(
            //               padding: EdgeInsets.symmetric(
            //                   horizontal: 1.h, vertical: 1.w),
            //               child: widget.staff==null?Center():Row(
            //                 children: [
            //                   Icon(
            //                     Icons.person,
            //                     color: blackColor,
            //                     size: 20.sp,
            //                   ),
            //                   SizedBox(
            //                     width: 2.w,
            //                   ),
            //                   Text(
            //                    widget.staff,
            //                     style: TextStyle(
            //                         color: const Color(0xFF2E3A59),
            //                         fontFamily: 'Calibri_bold',
            //                         fontSize: 15.sp),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             Padding(
            //               padding: EdgeInsets.symmetric(
            //                   horizontal: 1.h, vertical: 1.w),
            //               child: Row(
            //                 children: [
            //                   Icon(
            //                     Icons.date_range_outlined,
            //                     color: blackColor,
            //                     size: 20.sp,
            //                   ),
            //                   SizedBox(
            //                     width: 2.w,
            //                   ),
            //                   Text(
            //                     widget.date,
            //                     style: TextStyle(color: const Color(0xFF2E3A59),fontSize: 12.sp,fontFamily: 'Calibri'),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             Padding(
            //               padding: EdgeInsets.symmetric(
            //                   horizontal: 1.h, vertical: 1.w),
            //               child: Row(
            //                 children: [
            //                   Icon(
            //                     Icons.access_time,
            //                     color: blackColor,
            //                     size: 20.sp,
            //                   ),
            //                   SizedBox(
            //                     width: 2.w,
            //                   ),
            //                   Text(
            //                     widget.time,
            //                     style: TextStyle(color: const Color(0xFF2E3A59),fontSize: 12.sp,fontFamily: 'Calibri'),
            //                   ),
            //                 ],
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Divider(
            //   thickness: 2,
            //   height: 2.h,
            //   color: Colors.grey,
            // ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 10.h,
                  width: 80.w,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.zero,
                      image: DecorationImage(
                          image: AssetImage('assets/profilepic/Barcode.png'),
                          fit: BoxFit.contain)),
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
          ],
        ),
      ),
    );
  }

  bookNowButton(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 3.w),
          child: InkWell(
            onTap: _newappointement,
            child: Container(
              height: 5.h,
              padding: EdgeInsets.symmetric(vertical: 1.h),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Text(
                'Finish',
                style: white18SemiBoldTextStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  bookingSuccessfulDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 1.h),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: Colors.white.withOpacity(0.15),
          child: Container(
            height: 32.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white10.withOpacity(0.5),
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: blackColor.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 2,
                ),
              ],
            ),
            child: Wrap(
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 1.h,vertical: 1.w),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/new/ok.png',
                        height: 10.h,
                        width: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.h),
                        child: Text(
                          Languages.of(context).bookedsucces,
                          textAlign: TextAlign.center,
                          style: black15SemiBoldTextStyle,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.h),
                        child: Text(
                          Languages.of(context).booked,
                          textAlign: TextAlign.center,
                          style: grey13RegularTextStyle,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.h),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BottomBar()),
                            );
                          },
                          child: Container(
                            height: 6.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.h, vertical: 1.w),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(

                              color: whiteColor,
                              border: Border.all(color: whiteColor),
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: Text(
                              Languages.of(context).continuebooking,
                              style: TextStyle(
                                color: primaryColor,fontFamily: 'Calibri',fontSize: 15.sp
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 1.h),
                      //   child: InkWell(
                      //     onTap: () {
                      //       //currentIndex = 0;
                      //       Navigator.pushReplacement(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => const BottomBar()),
                      //       );
                      //     },
                      //     child: Container(
                      //       height: 6.h,
                      //       padding: EdgeInsets.symmetric(
                      //           horizontal: 2.h, vertical: 1.w),
                      //       alignment: Alignment.center,
                      //       decoration: BoxDecoration(
                      //         color: whiteColor,
                      //         border: Border.all(color: primaryColor),
                      //         borderRadius: BorderRadius.circular(10),
                      //         boxShadow: [
                      //           BoxShadow(
                      //             color: primaryColor.withOpacity(0.2),
                      //             spreadRadius: 2,
                      //             blurRadius: 2,
                      //           ),
                      //         ],
                      //       ),
                      //       child: Text(
                      //         Languages.of(context).gotoappoin,
                      //         style: primaryColor18SemiBoldTextStyle,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _newappointement() async {
    setState(() {});

    setState(() {});

    final join = await WebService().new_appointement(
        date: widget.date,
        time: widget.time,
        name: widget.profile.name,
        email: widget.profile.email,
        phone: widget.profile.phone);

    bookingSuccessfulDialog();
  }
}
