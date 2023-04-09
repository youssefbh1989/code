import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:salonat/localisation/language/language.dart';
import 'package:salonat/models/artistmodel.dart';
import 'package:salonat/models/category.dart';
import 'package:salonat/models/clinicsmodel.dart';
import 'package:salonat/models/salonmodels.dart';
import 'package:salonat/models/service_filter.dart';
import 'package:salonat/models/servicesfiltermodels.dart';
import 'package:salonat/models/staffmodel.dart';
import 'package:salonat/models/usermodel.dart';
import 'package:salonat/services/apiservice.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants.dart';
import '../../localisation/locale_constant.dart';
import '../appointment/bookappointement.dart';
import '../appointment/bookappointementartist.dart';
import '../appointment/bookappointementclinic.dart';

class ScheduleAppointmentArtist extends StatefulWidget {
  final Services service;
  final ClinicModel clinics;
  final CategoryModel categories;
  final ArtistModel artists;
  final UserModel profile;
  final ServiceFilterModel product;
  final int artistid;

  const ScheduleAppointmentArtist({
    Key key,
    this.service,
    this.clinics,
    this.categories,
    this.profile, this.product,this.artists, this.artistid
  }) : super(key: key);

  @override
  _ScheduleAppointmentArtistState createState() =>
      _ScheduleAppointmentArtistState();
}

class _ScheduleAppointmentArtistState
    extends State<ScheduleAppointmentArtist> {
  List<StaffModel> _staff = [];
  final List<SalonModel> _salon = [];

  ClinicModel _clinics;
  ArtistModel _artists;
  CategoryModel _cat;
  StaffModel _staffs;

  double height;
  int isSelected = 0;
  String selectedTime = '';
  final DatePickerController _controllerdate = DatePickerController();

  DateTime _selectedValue = DateTime.now();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();

  @override
  void initState() {
    _artists = widget.artists;
    _cat = widget.categories;


    WebService().getstaff(id: widget.artistid).then((value) {
      setState(() {
        _staff = value;
        print(_staff);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final slotList = [
    {'time': '08:00 '},
    {'time': '09:00 '},
    {'time': '10:00 '},
    {'time': '11:00 '},
    {'time': '12:00 '},
    {'time': '13:00 '},
    {'time': '14:00 '},
    {'time': '15:00 '},
    {'time': '16:00 '},
    {'time': '17:00 '},
    {'time': '18:00 '},
    {'time': '19:00 '},
    {'time': '20:30 '},
    {'time': '21:00 '},
    {'time': '22:00 '},
    {'time': '23:00 '},
  ];

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
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: whiteColor,
              size: 15.sp,
            ),
          ),
          actions: [
            // PopupMenuButton<String>(
            //   color: whiteColor.withOpacity(0.5),
            //   shape: const RoundedRectangleBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(15.0))),
            //   icon: ClipOval(
            //       child: Languages.of(context).labelSelectLanguage == "English"?
            //       Image.asset('assets/new/england.png')
            //           :Image.asset('assets/new/qatar.png')
            //   ),
            //   onSelected: (String result) {
            //     changeLanguage(context, result);
            //   },
            //   itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            //     PopupMenuItem<String>(
            //       value: 'ar',
            //       child: Text('العربية',
            //           style: GoogleFonts.cairo(
            //               fontWeight: FontWeight.w700, color: whiteColor)),
            //     ),
            //     PopupMenuItem<String>(
            //       value: 'en',
            //       child: Text('English',
            //           style: GoogleFonts.cairo(
            //               fontWeight: FontWeight.w700, color: whiteColor)),
            //     ),
            //   ],
            // ),
          ],
          title: Text(
            Languages.of(context).sheduleappointements,
            style: TextStyle(
                color: whiteColor, fontFamily: 'Calibri_bold', fontSize: 15.sp),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
              child: Container(
                height: 20.h,
                width: 25.w,
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
                      Center(
                        child: Text(
                          Languages.of(context).selectdate,
                          style: black15SemiBoldTextStyle,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        height: 12.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.h, vertical: 1.w),
                        child: DatePicker(
                          DateTime.now(),
                          width: 15.w,
                          height: 12.h,
                          controller: _controllerdate,
                          initialSelectedDate: DateTime.now(),
                          selectionColor: primaryColor,
                          selectedTextColor: Colors.white,
                          onDateChange: (date) {
                            String formattedDate =
                            DateFormat('yyyy-MM-dd').format(date);
                            print(formattedDate);
                            setState(() {
                              _selectedValue = date;
                              datecontroller.text = formattedDate.toString();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
           Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.w),
              child:  _staff.isEmpty
                  ? Container()
                  :Container(
                height: 30.h,
                width: 25.w,
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
                child:  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            Languages.of(context).selectspecialist,
                            style: black15SemiBoldTextStyle,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      SizedBox(
                        height: 20.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: _staff.length,
                          itemBuilder: (context, index) {
                            final item = _staff[index];
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isSelected = index;
                                  });
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 20.w,
                                      height: 12.h,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: isSelected == index
                                              ? primaryColor
                                              : whiteColor,
                                          width: 1.3,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "http://salonat.qa/" +
                                                  item.image),
                                          fit: BoxFit.fill,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: blackColor.withOpacity(0.1),
                                            spreadRadius: 1.5,
                                            blurRadius: 1.5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      item.name,
                                      style: isSelected == index
                                          ? primaryColor13MediumTextStyle
                                          : black13MediumTextStyle,
                                    ),
                                    Text(
                                      item.skills,
                                      style: isSelected == index
                                          ? primaryColor13MediumTextStyle
                                          : black13MediumTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
              child: Container(
                height: 30.h,
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
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            Languages.of(context).available,
                            style: black15SemiBoldTextStyle,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Center(
                        child: Wrap(
                          children: slotList
                              .map(
                                (e) => Padding(
                              padding: const EdgeInsets.only(
                                bottom: 7,
                                right: 7,
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedTime = e['time'];
                                    timecontroller.text =
                                        selectedTime.toString();
                                  });
                                },
                                child: Container(
                                  width: 20.w,
                                  height: 4.h,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 1.w, horizontal: 1.h),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: e['time'] == selectedTime
                                        ? primaryColor
                                        : Colors.white10.withOpacity(0.10),
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                    border: Border.all(
                                        color: e['time'] == selectedTime
                                            ? primaryColor
                                            : whiteColor),
                                  ),
                                  child: Text(e['time'],
                                      style: (e['time'] == selectedTime)
                                          ? TextStyle(
                                          color: whiteColor,
                                          fontSize: 18,
                                          fontFamily: 'Calibri')
                                          : TextStyle(
                                          color: whiteColor,
                                          fontSize: 18,
                                          fontFamily: 'Calibri')),
                                ),
                              ),
                            ),
                          )
                              .toList()
                              .cast<Widget>(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: continueButton(),
      ),
    );
  }

  serviceDetail({String service, titleStyle, String price, priceStyle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            service,
            style: titleStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            price,
            style: priceStyle,
          ),
        ),
      ],
    );
  }

  continueButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.w),
          child: InkWell(
            onTap: () => datecontroller.text.isEmpty &&
                _staff.isEmpty &&
                timecontroller.text.isEmpty
                ? _serviceempty(
                text:
                'To continue please pick the date ,the time and the specialist')
                : datecontroller.text.isEmpty
                ? _serviceempty(text: 'Please Shoose a date')
                : timecontroller.text.isEmpty
                ? _serviceempty(text: 'Please Shoose The time')
                : _staff.isNotEmpty
                ? _serviceempty(text: 'Please Shoose a staff')
                : _staff.isNotEmpty?Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BookAppointementArtist(
                        artists:widget.artists,
                          clinics: _clinics,
                          staff: _staff[isSelected],
                          date: datecontroller.text,

                          time: timecontroller.text,
                          profile: widget.profile)),
            ):Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BookAppointementArtist(
                          artists:widget.artists,
                          clinics: _clinics,

                          date: datecontroller.text,

                          time: timecontroller.text,
                          profile: widget.profile)),
            ),
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
                Languages.of(context).Next,
                style: white18SemiBoldTextStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _serviceempty({String text}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: Colors.white.withOpacity(0.15),
          child: Container(
            height: 22.h,
            width: MediaQuery.of(context).size.width,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.h, vertical: 1.w),
                        child: Text(
                          text ?? Languages.of(context).pleasepickservice,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontFamily: 'SFProDisplay-Bold'),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.h, vertical: 1.w),
                        child: Row(
                          children: [
                            Expanded(
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 6.h,
                                  color: whiteColor,
                                  mouseCursor: MouseCursor.defer,
                                  textColor: Colors.white,
                                  minWidth: double.infinity,
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    Languages.of(context).ok,
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 15.sp),
                                  ),
                                ))
                          ],
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
