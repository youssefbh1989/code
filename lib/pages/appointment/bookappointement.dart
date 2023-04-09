import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salonat/models/cartemodel.dart';
import 'package:salonat/models/category.dart';
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

class BookAppointement extends StatefulWidget {
  const BookAppointement({
    Key key,
    this.salons,
    this.categories,
    this.service,
    String namesalon,
    String addressesalon,
    this.staff,
    this.date,
    this.time,
    this.profile, this.singlesalon,
  }) : super(key: key);
  final Services service;
  final SalonModel salons;
  final StaffModel staff;
  final String date;
  final String time;
  final CategoryModel categories;
  final UserModel profile;
  final List<SalonModel> singlesalon;

  @override
  State<BookAppointement> createState() => _BookAppointementState();
}

class _BookAppointementState extends State<BookAppointement> {
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
        resizeToAvoidBottomInset: true,
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
          actions: [


          ],
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
                                          widget.salons.image),
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
                                            ? widget.salons.name
                                            : widget.salons.nameAr,
                                        style: black14MediumTextStyle,
                                      ),
                                      SizedBox(height: 1.h),
                                      Text(
                                          Languages.of(context)
                                                      .labelSelectLanguage ==
                                                  'English'
                                              ? widget.salons.address
                                              : widget.salons.addressAr,
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
                                  SizedBox(height: 1.h,),
                                  // Divider(
                                  //   thickness: 2,
                                  //   height: 2.h,
                                  //   color: Colors.grey,
                                  // ),
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
                                      Text(
                                          '${_carte[index].price} QAR',
                                          style: black15MediumTextStyle)
                                    ],
                                  ),
                                  // Divider(
                                  //   thickness: 2,
                                  //   height: 2.h,
                                  //   color: Colors.grey,
                                  // ),
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
                                          Text(
                                            Languages.of(context).date,
                                            style: grey12RegularTextStyle,
                                          ),
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
                                          Text(
                                            Languages.of(context).time,
                                            style: grey12RegularTextStyle,
                                          ),
                                           SizedBox(
                                            width: 2.w,
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
                                      //         MainAxisAlignment.end,
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
                          borderRadius: BorderRadius.circular(6),
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
                        builder: (context) => AppointmentDetails(
                            salon: widget.salons,

                            date: widget.date,
                            time: widget.time,
                            profile: widget.profile)),
                  )
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AppointmentDetails(
                            salon: widget.salons,
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
                Languages.of(context).Next,
                style: white18SemiBoldTextStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
