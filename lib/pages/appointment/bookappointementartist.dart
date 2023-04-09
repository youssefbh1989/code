import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salonat/models/artistmodel.dart';
import 'package:salonat/models/cartemodel.dart';
import 'package:salonat/models/category.dart';
import 'package:salonat/models/clinicsmodel.dart';
import 'package:salonat/models/salonmodels.dart';
import 'package:salonat/models/staffmodel.dart';
import 'package:salonat/models/usermodel.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants.dart';
import '../../localisation/language/language.dart';
import '../../localisation/locale_constant.dart';
import '../../models/servicesfiltermodels.dart';
import '../../services/apiservice.dart';
import '../appointmentDetails/appointment_details.dart';
import '../bottom_bar.dart';
import 'appointement_detail_artist.dart';
import 'appointement_detail_clinic.dart';

class BookAppointementArtist extends StatefulWidget {
  const BookAppointementArtist({
    Key key,
    this.salon,
    this.categories,
    this.service,
    String namesalon,
    String addressesalon,
    this.staff,
    this.date,
    this.time,
    this.profile, this.clinics, this.artists,
  }) : super(key: key);
  final Services service;
  final SalonModel salon;
  final StaffModel staff;
  final ClinicModel clinics;
  final ArtistModel artists;
  final String date;
  final String time;
  final CategoryModel categories;
  final UserModel profile;

  @override
  State<BookAppointementArtist> createState() => _BookAppointementArtistState();
}

class _BookAppointementArtistState extends State<BookAppointementArtist> {
  TextEditingController promocontroller = TextEditingController();
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
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/new/back.png"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            Languages.of(context).sheduleappointements,
            style: black16SemiBoldTextStyle,
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: whiteColor,
              size: 15.sp,
            ),
          ),

        ),
        body: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _carte.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                child: Column(
                  children: [
                    Container(
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.h, vertical: 1.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 15.h,
                                  width: 32.w,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(60)),
                                    image: DecorationImage(
                                      image: NetworkImage('http://salonat.qa/' +
                                          widget.artists.image),
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
                                            ? widget.artists.name
                                            : widget.artists.nameAr,
                                        style: black14MediumTextStyle,
                                      ),
                                      SizedBox(height: 1.h),
                                      widget.artists.address==null?Center():Text(
                                          Languages.of(context)
                                              .labelSelectLanguage ==
                                              'English'
                                              ? widget.artists.address
                                              : widget.artists.addressAr,
                                          style: grey12RegularTextStyle,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Text(
                                      'Services :',style: TextStyle(
                                        fontFamily: 'Calibri',fontSize:
                                    15.sp,color: blackColor
                                    ),
                                    )
                                  ],),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        Languages.of(context)
                                            .labelSelectLanguage ==
                                            'English'
                                            ? _carte[index].service.name
                                            : _carte[index].service.nameAr,
                                        style: black15MediumTextStyle,
                                      ),
                                      // Text(
                                      //     '(${_carte[index].basketQuantity})' +
                                      //         Languages.of(context).personne,
                                      //     style: black15MediumTextStyle)
                                    ],
                                  ),
                                  widget.staff == null
                                      ? Text('')
                                      : Row(
                                    children: [
                                      Image.asset('assets/profilepic/pro.png'),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      Text(
                                        widget.staff.name,
                                        style: grey12RegularTextStyle,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.date_range_outlined,color: blackColor,size: 15.sp),
                                          SizedBox(
                                            width: 1.w,
                                          ),
                                          Text(
                                            widget.date,
                                            style: black15MediumTextStyle,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.watch_later_outlined,size: 15.sp,color: blackColor),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            widget.time,
                                            style: black15MediumTextStyle,
                                          ),
                                        ],
                                      ),
                                      // Padding(
                                      //   padding: EdgeInsets.symmetric(
                                      //       horizontal: 1.h, vertical: 1.w),
                                      //   child: Row(
                                      //     mainAxisAlignment:
                                      //     MainAxisAlignment.end,
                                      //     children: [
                                      //       InkWell(
                                      //         child: Text(
                                      //           'Add coupon ',
                                      //           style: TextStyle(
                                      //               color: primaryColor,
                                      //               fontSize: 12.sp,
                                      //               textBaseline: TextBaseline
                                      //                   .ideographic),
                                      //         ),
                                      //         onTap: () {},
                                      //       ),
                                      //     ],
                                      //   ),
                                      // )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 0.h, vertical: 1.w),
                      child: Container(
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
                        child: _carte[index].finalPrice.toString()=='0.0000'?Container():Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.h, vertical: 3.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    Languages.of(context).totalepay,
                                    style: grey13RegularTextStyle,
                                  ),
                                  Text(
                                    '${_carte[index].finalPrice.toString()} QAR',
                                    style: grey13RegularTextStyle,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                  ],
                ),
              );
            }),
        bottomNavigationBar: continueButton(),
      ),
    );
  }

  continueButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 3.w),
          child: InkWell(
            onTap: () => widget.staff == null
                ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AppointmentDetailsArtist(
                      artists: widget.artists,

                      date: widget.date,
                      time: widget.time,
                      profile: widget.profile)
              ),
            )
                : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AppointmentDetailsArtist(

                      clinics: widget.clinics,
                      staff: widget.staff.name,
                      date: widget.date,
                      time: widget.time,
                      profile: widget.profile)),
            ),
            child: Container(
              height: 5.h,
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
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
                'Chekout',
                style: white18SemiBoldTextStyle,
              ),
            ),
          ),
        ),
      ],
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
            height: 38.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white10.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
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
                  padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
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
                          style: TextStyle(color: blackColor,fontSize: 15.sp,fontFamily: 'Calibri'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.h),
                        child: Text(
                          Languages.of(context).booked,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: const Color(0xFF2E3A59),fontSize: 12.sp,fontFamily: 'Calibri'),
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
                            height: 5.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.h, vertical: 1.w),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              border: Border.all(color: primaryColor),
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
                              Languages.of(context).continuebooking,
                              style: TextStyle(color: whiteColor,fontSize: 12.sp,fontFamily: 'Calibri'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.h),
                        child: InkWell(
                          onTap: () {
                            //currentIndex = 0;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BottomBar()),
                            );
                          },
                          child: Container(
                            height: 5.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.h, vertical: 1.w),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              border: Border.all(color: primaryColor),
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
                              Languages.of(context).gotoappoin,
                              style: primaryColor18SemiBoldTextStyle,
                            ),
                          ),
                        ),
                      ),
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
}
