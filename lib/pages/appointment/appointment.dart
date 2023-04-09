import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salonat/column/Columnbuilder.dart';
import 'package:salonat/localisation/language/language.dart';
import 'package:salonat/models/appointments.dart';
import 'package:salonat/models/usermodel.dart';
import 'package:salonat/services/api.dart';
import 'package:salonat/services/apiservice.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants.dart';
import '../../localisation/locale_constant.dart';
import '../../services/user.dart';
import '../../widget/redirection_auth.dart';
import '../auth/signin.dart';
import '../bottom_bar.dart';
import 'appointements_detail.dart';

class Appointment extends StatefulWidget {
  String formatDAteTime() {
    var dateTime;
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  const Appointment(
      {Key key, this.appointements, UserModel profile, String token})
      : super(key: key);

  final AppointmentsModel appointements;

  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  double height;
  double width;
  String formattedDate;
  List<AppointmentsModel> _items = [];
  List<AppointmentsModel> _appointements = [];
  List<AppointmentsModel> _past = [];
  List<AppointmentsModel> _upcoming = [];
  TextEditingController _cancecontroller = TextEditingController();
  TextEditingController _confirmed = TextEditingController();
  bool _isloading = true;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  void dispose() {
    _appointements;

    super.dispose();
  }

  Future getdata() async {
    WebService().getappointements().then((value) {
      if (mounted) {
        setState(() {
          _appointements = value;

          _items
            ..clear()
            ..addAll(_appointements);

          _upcoming = _items
              .where((element) =>
                  element.status == 'Pending' || element.status == 'Confirmed')
              .toList();
          print('youssefcoming is${_upcoming}');
          _past = _items
              .where((element) =>
                  element.status == 'Completed' ||
                  element.status == 'Cancelled')
              .toList();
          print('youssef past is${_past}');

          _isloading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: API.USER != null
            ? Scaffold(
                backgroundColor: Color(0xfff6e3e3),
                extendBodyBehindAppBar: false,
                appBar: AppBar(

                  backgroundColor: primaryColor,
                  automaticallyImplyLeading: false,
                  bottom: TabBar(
                    indicatorWeight: 2,
                    indicatorColor: whiteColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: fixPadding * 2.0),
                    unselectedLabelColor: greyColor,
                    labelColor: const Color(0xFFFFFFFF),
                    labelStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Calibri-bold',
                    ),
                    tabs: <Widget>[
                      Tab(
                        text: Languages.of(context).upcoming,
                      ),
                      Tab(
                        text: Languages.of(context).past,
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    _upcoming.isEmpty ? upcomingBookingListEmpty() : upcoming(),
                    _past.isEmpty ? upcomingBookingListEmpty() : past()
                  ],
                ))
            : Redirection_auth());
  }

  upcomingBookingListEmpty() {
    return _isloading
        ? const Center(
            child: CircularProgressIndicator(
              backgroundColor: primaryColor,
              color: primaryColor,
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/icons/appointment.png',
                  height: 50,
                  width: 50,
                  color: primaryColor,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(Languages.of(context).appointementsempty,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: primaryColor))
            ],
          );
  }

  past() {
    return RefreshIndicator(
      color: primaryColor,
      onRefresh: () async {
        await getdata();
      },
      child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: _past.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Appointements_detail(appointement: _past[index]),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.w),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  Container(
                                    width:  API.isPhone ? 100.0 : 200.0,
                                    height:   API.isPhone ? 100.0 : 200.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(60),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              'https://salonat.qa/' +
                                                  _past[index].image,
                                            ),
                                            fit: BoxFit.cover)),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      Languages.of(context)
                                                  .labelSelectLanguage ==
                                              'English'
                                          ? _past[index].salon_name
                                          : _past[index].salon_name_ar,
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontSize:  API.isPhone ? 20.0 : 30.0,
                                          fontFamily: 'Calibri_bold'),
                                      maxLines: 3,
                                      overflow: TextOverflow.clip),
                                  Row(
                                    children: [
                                      if ((Languages.of(context).labelSelectLanguage == 'English'
                                          ? _past[index].address ?? ''
                                          : _past[index].address_ar ?? '')
                                          .isNotEmpty)

                                      Flexible(
                                        child: Text(
                                            Languages.of(context)
                                                        .labelSelectLanguage ==
                                                    'English'
                                                ? _past[index]
                                                    .address
                                                    .toString()
                                                : _past[index].address_ar,
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontFamily: 'Calibri',
                                                fontSize:  API.isPhone ? 20.0 : 30.0),
                                            maxLines: 1,
                                            overflow: TextOverflow.clip),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 1.h,
                            ),
                            Divider(
                              color: primaryColor,
                              thickness: 1,
                              height: 1.h,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: primaryColor,
                                  size:API.isPhone ? 20.0 : 35.0,
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Text(
                                  _past[index].name,
                                  style: TextStyle(
                                      color: primaryColor, fontSize: API.isPhone ? 20.0 : 30.0),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            ColumnBuilder(
                                itemCount:
                                    _past[index].appointmentservices.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            _past[0]
                                                .appointmentservices[0]
                                                .name,
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 10.sp),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            _past[0]
                                                    .appointmentservices[0]
                                                    .price +
                                                ' QAR',
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontSize: API.isPhone ? 20.0 : 35.0,
                                                fontWeight: FontWeight.bold),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                            SizedBox(
                              height: 1.h,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _past[index].status == 'Completed'
                                ? MaterialButton(
                                    color: Colors.green,
                                    onPressed: () {},
                              height:  API.isPhone ? 40.0 : 800.0,
                              minWidth:  API.isPhone ? 30.0 : 250.0,
                                    child: Text(
                                      'Completed',
                                      style: TextStyle(
                                          color: whiteColor,
                                          fontWeight: FontWeight.bold,
                                         fontSize: API.isPhone ? 10.0 : 20.0),
                                    ),
                                  )
                                : MaterialButton(
                                    color: primaryColor,
                              height:  API.isPhone ? 40.0 : 800.0,
                              minWidth:  API.isPhone ? 30.0 : 250.0,
                                    onPressed: () {},
                                    child: Text(
                                      'Completed',
                                      style: TextStyle(
                                          color: whiteColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: API.isPhone ? 10.0 : 20.0),
                                    ),
                                  ),
                            _past[index].status == 'Cancelled'
                                ? MaterialButton(
                                    color: primaryColor.withOpacity(.6),
                                    onPressed: () {},
                              height:  API.isPhone ? 40.0 : 800.0,
                              minWidth:  API.isPhone ? 30.0 : 250.0,
                                    child: Text(
                                      'Cancelled',
                                      style: TextStyle(
                                          color: whiteColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: API.isPhone ? 10.0 : 20.0),
                                    ),
                                  )
                                : MaterialButton(
                                    color: primaryColor,
                                    onPressed: () {},
                              height:  API.isPhone ? 40.0 : 800.0,
                              minWidth:  API.isPhone ? 30.0 : 250.0,
                                    child: Text(
                                      'Cancelled',
                                      style: TextStyle(
                                          color: whiteColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: API.isPhone ? 10.0 : 20.0),
                                    ),
                                  ),
                            /*     _upcoming[0].status=='Cancelled'?MaterialButton(
                                      color: primaryColor.withOpacity(.6),
                                      onPressed: (){}, child: Text(
                                      'Rejected',style: TextStyle(
                                        color: whiteColor,fontWeight: FontWeight.bold
                                    ),
                                    ), ):MaterialButton(
                                      color: primaryColor,
                                      onPressed: (){}, child: Text(
                                        'Rejected',style: TextStyle(
                                      color: whiteColor,fontWeight: FontWeight.bold
                                    ),
                                    ), ),*/
                          ],
                        ),
                      ]),
                ),
              ),
            );
          }),
    );
  }

  upcoming() {
    return RefreshIndicator(
      color: primaryColor,
      onRefresh: () async {
        await getdata();
      },
      child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: _upcoming.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Appointements_detail(appointement: _upcoming[index]),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.w),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order N :',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: API.isPhone ? 15.0 : 30.0,
                                ),
                              ),
                              Text(
                                _upcoming[index].referenceId.toString(),
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                fontSize:  API.isPhone ? 15.0 : 25.0),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  Container(
                                    width:  API.isPhone ? 100.0 : 200.0,
                                    height:   API.isPhone ? 100.0 : 200.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(1000),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              'https://salonat.qa/' +
                                                  _upcoming[index].image,
                                            ),
                                            fit: BoxFit.cover)),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      Languages.of(context)
                                                  .labelSelectLanguage ==
                                              'English'
                                          ? _upcoming[index].salon_name
                                          : _upcoming[index].salon_name_ar,
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontSize:  API.isPhone ? 20.0 : 30.0,
                                          fontFamily: 'Calibri_bold'),
                                      maxLines: 3,
                                      overflow: TextOverflow.clip),
                                  _upcoming[index].address == null
                                      ? Row()
                                      : Row(
                                          children: [


                                            Flexible(
                                              child: Text(
                                                  Languages.of(context)
                                                              .labelSelectLanguage ==
                                                          'English'
                                                      ? _upcoming[index]
                                                          .address
                                                          .toString()
                                                      : _upcoming[index]
                                                          .address_ar,
                                                  style: TextStyle(
                                                      color: primaryColor,
                                                      fontFamily: 'Calibri',
                                                      fontSize:  API.isPhone ? 20.0 : 25.0),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.clip),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 2.h,
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Divider(
                              height: 2.h,
                              color: primaryColor,
                              thickness: 1,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: primaryColor,
                                  size:  API.isPhone ? 20.0 : 35.0,
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Text(
                                  _upcoming[index].name,
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize:  API.isPhone ? 20.0 : 30.0),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            ColumnBuilder(
                                itemCount:
                                    _upcoming[index].appointmentservices.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            _upcoming[0]
                                                .appointmentservices[0]
                                                .name,
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontSize:  API.isPhone ? 20.0 : 30.0),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            _upcoming[0]
                                                    .appointmentservices[0]
                                                    .price +
                                                ' QAR',
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontSize:  API.isPhone ? 20.0 : 30.0,
                                                fontWeight: FontWeight.bold),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _upcoming[index].status == 'Confirmed'
                                    ? MaterialButton(
                                        color: Colors.green,
                                        onPressed: () {},
                                  height:  API.isPhone ? 40.0 : 800.0,
                                  minWidth:  API.isPhone ? 30.0 : 250.0,
                                        child: Text(
                                          'Confirmed',
                                          style: TextStyle(
                                              color: whiteColor,
                                              fontWeight: FontWeight.bold,
                                          fontSize: API.isPhone ? 10.0 : 20.0),
                                        ),
                                      )
                                    : MaterialButton(
                                        color: primaryColor,
                                        onPressed: () {},
                                  height:  API.isPhone ? 40.0 : 800.0,
                                  minWidth:  API.isPhone ? 30.0 : 250.0,
                                        child: Text(
                                          'Confirmed',
                                          style: TextStyle(
                                              color: whiteColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: API.isPhone ? 10.0 : 20.0),
                                        ),
                                      ),
                                _upcoming[index].status == 'Pending'
                                    ? MaterialButton(
                                        color: primaryColor.withOpacity(.6),
                                        onPressed: () {},
                                  height:  API.isPhone ? 40.0 : 800.0,
                                  minWidth:  API.isPhone ? 30.0 : 250.0,
                                        child: Text(
                                          'Pending',
                                          style: TextStyle(
                                              color: whiteColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: API.isPhone ? 10.0 : 20.0),
                                        ),
                                      )
                                    : MaterialButton(
                                        color: primaryColor,
                                        onPressed: () {},
                                  height:  API.isPhone ? 40.0 : 800.0,
                                  minWidth:  API.isPhone ? 30.0 : 250.0,
                                        child: Text(
                                          'Pending',
                                          style: TextStyle(
                                              color: whiteColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: API.isPhone ? 10.0 : 20.0),
                                        ),
                                      ),
                                /*     _upcoming[0].status=='Cancelled'?MaterialButton(
                                      color: primaryColor.withOpacity(.6),
                                      onPressed: (){}, child: Text(
                                      'Rejected',style: TextStyle(
                                        color: whiteColor,fontWeight: FontWeight.bold
                                    ),
                                    ), ):MaterialButton(
                                      color: primaryColor,
                                      onPressed: (){}, child: Text(
                                        'Rejected',style: TextStyle(
                                      color: whiteColor,fontWeight: FontWeight.bold
                                    ),
                                    ), ),*/
                              ],
                            ),


                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MaterialButton(
                                  splashColor: whiteColor,
                                  highlightColor: whiteColor,
                                  focusColor: primaryColor,
                                   onPressed: () {


                                    setState(() {
                                      _cancecontroller.text = _upcoming[index].id.toString();
                                      _confirmed.text=_upcoming[index].status.toString();
                                      _confirmed.text == 'Confirmed'?
                                      Get.snackbar('Error :', 'When the appointement is Confirmed you can not cancelled'
                                          '  Thanks ',
                                          backgroundColor: backgroundcolor,
                                          snackPosition: SnackPosition.BOTTOM,
                                          colorText: primaryColor):

                                      _cancel('Do you want to cancel this appointement ?');
                                    });
                                  },
                                  child: Text(
                                    'Cancel Appointement',
                                    style: TextStyle(color: Colors.red,
                                        fontSize:  API.isPhone ? 20.0 : 30.0),
                                  ),
                                  minWidth: 80.w,
                                  height: 5.h,
                                ),
                              ],
                            )
                          ],
                        ),
                      ]),
                ),
              ),
            );
          }),
    );
  }

  services(service) {
    return ListView.builder(
      itemCount: _appointements.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _appointements[index].appointmentservices[index].name,
                style: grey13RegularTextStyle,
              ),
              Text(
                '\$${_appointements[index].appointmentservices[index].price.toString()}',
                style: grey13RegularTextStyle,
              ),
            ],
          ),
        );
      },
    );
  }

  _cancel(String textcontent) {

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              elevation: 2,
              backgroundColor: whiteColor,
              title: Text(
                'Cancel Appointement',
                style:
                    TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
              ),
              content: Text(
                textcontent,
                style: TextStyle(
                  color: primaryColor,
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'No',
                      style: TextStyle(color: primaryColor),
                    )),
                TextButton(
                    onPressed: () {
                      appointementcancel();
                    },
                    child: Text(
                      'Yes',
                      style: TextStyle(color: primaryColor),
                    )),
              ],
            ));
  }

  appointementcancel() async {
    await UsersWebService().cancelappointement(_cancecontroller.text);
    setState(() {
      Navigator.pop(context);
      getdata();
    });
  }
}
