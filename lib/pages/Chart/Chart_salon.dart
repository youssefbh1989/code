import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salonat/models/clinicsmodel.dart';
import 'package:salonat/models/salonmodels.dart';
import 'package:salonat/services/api.dart';
import 'package:sizer/sizer.dart';

import '../../column/Columnbuilder.dart';
import '../../constants/constants.dart';
import '../../localisation/language/language.dart';
import '../../models/cartemodel.dart';
import '../../services/apiservice.dart';
import '../../services/data_repository.dart';
import '../bottom_bar.dart';



class Chart_salon extends StatefulWidget {
  final ClinicModel clinics;
  final SalonModel salons;
  final String servicedata;
  const Chart_salon({Key key, this.clinics, this.salons, this.servicedata}) : super(key: key);

  @override
  State<Chart_salon> createState() => _Chart_salonState();
}

class _Chart_salonState extends State<Chart_salon> {
  List<CarteModel> _carte = [];
  double height;
  double width;
  bool _isloading = true;
  bool isSelected;
  TextEditingController servicesubcontroller = TextEditingController();
  int selectedsubservice = 0;

  @override
  void initState() {
    super.initState();
    getcart();

  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      getcart();
    });
  }

  void getcart() async{
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
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: whiteColor,
              size: 15.sp,
            ),
          ),
          title: Text(
            'Your Order',
            style: TextStyle(color: whiteColor),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
              itemCount: _carte.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white10.withOpacity(0.80),
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 2),
                              color: blackColor.withOpacity(0.1),
                              spreadRadius: 1.5,
                              blurRadius: 1.5,
                            ),
                          ],
                        ),
                        child: Container(
                          decoration: BoxDecoration(),
                          child: ListTile(
                            title: Text(
                                Languages.of(context).labelSelectLanguage ==
                                        'English'
                                    ? _carte[index].service.name
                                    : _carte[index].service.nameAr,
                                style: TextStyle(
                                    color: blackColor,
                                    fontFamily: 'Calibri',
                                    fontSize: 12.sp),
                                maxLines: 1,
                                overflow: TextOverflow.clip),
                            trailing: Text(_carte[index].price + ' QAR ',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontFamily: 'Calibri',
                                    fontSize: 12.sp),
                                maxLines: 1,
                                overflow: TextOverflow.clip),
                          ),
                        ),
                      ),
                    ),
                    // Positioned(
                    //     top: 0.h,
                    //     right: -0.1.w,
                    //
                    //     child: GestureDetector(
                    //       onTap:(){
                    //         selectedsubservice = index;
                    //         selectedsubservice =
                    //             _carte[index].id;
                    //         servicesubcontroller.text =
                    //             selectedsubservice.toString();
                    //         _addtocart();
                    //
                    //
                    //
                    //
                    //
                    //
                    //       },
                    //
                    //         child: Container(
                    //             decoration: BoxDecoration(
                    //               color: Colors.white.withOpacity(0.80),
                    //               borderRadius: BorderRadius.circular(100),
                    //               boxShadow: [
                    //                 BoxShadow(
                    //                   offset: const Offset(0, 2),
                    //                   color: blackColor.withOpacity(0.1),
                    //                   spreadRadius: 1.5,
                    //                   blurRadius: 1.5,
                    //                 ),
                    //               ],
                    //             ),
                    //
                    //             child: Icon(Icons.close,color: primaryColor,))))
                  ],
                );
              }),
        ),
        bottomNavigationBar: bookAppointmentButton(),
      ),
    );
  }

  bookAppointmentButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 4.w),
          child: GestureDetector(
 /*           onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ScheduleAppointment(
                        salons: widget.salons,
                        //categories: dataProvider.categories[0],
                        profile: API.USER))),*/
            child: Container(
              height: 5.h,
              padding: EdgeInsets.symmetric(vertical: 1.h),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Languages.of(context).Next,
                      style: white18SemiBoldTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  Future<void> _addtocart() async {
    final dataProvider = Provider.of<DataReposotory>(context, listen: false);
    setState(() {});

    setState(() {});

    final join = await WebService().addtocart(
        service_id: widget.servicedata.toString(), quantity: '1');
    setState(() {});

    _serviceaddtocart();


  }
  void _serviceaddtocart({String text}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: Colors.white.withOpacity(0.15),
          child: Container(
            height: 20.h,
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
                          text ?? 'Service is added to cart',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontFamily: 'Calibri_bold'),
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
                                  height: 5.h,
                                  color: whiteColor,
                                  mouseCursor: MouseCursor.defer,
                                  textColor: Colors.white,
                                  minWidth: double.infinity,
                                  onPressed: () {

                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomBar()));

                                  },
                                  child: Text(
                                    Languages.of(context).ok,
                                    style: TextStyle(
                                        color: primaryColor, fontSize: 15.sp),
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
