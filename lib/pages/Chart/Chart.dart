import 'package:flutter/material.dart';
import 'package:salonat/models/clinicsmodel.dart';
import 'package:salonat/models/salonmodels.dart';
import 'package:salonat/services/api.dart';
import 'package:sizer/sizer.dart';

import '../../column/Columnbuilder.dart';
import '../../constants/constants.dart';
import '../../localisation/language/language.dart';
import '../../models/cartemodel.dart';
import '../../services/apiservice.dart';


class Chart extends StatefulWidget {
  final ClinicModel clinics;
  final SalonModel salon;
  const Chart({Key key, this.clinics, this.salon}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {

  List<CarteModel> _carte=[];
  double height;
  double width;
  bool _isloading = true;
  bool isSelected;

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
        extendBodyBehindAppBar: true,
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
        body:
        Container(

          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(height: 15.h,),
                Expanded(
                  child:ColumnBuilder(
                      itemCount: _carte.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
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
                                trailing:Text(_carte[index].price + ' QAR ',  style: TextStyle(
                                    color: primaryColor,
                                    fontFamily: 'Calibri',
                                    fontSize: 12.sp),
                                    maxLines: 1,
                                    overflow: TextOverflow.clip) ,

                              ),
                            ),
                          ),
                        );
                      }) ,
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar:  bookAppointmentButton() ,
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
            onTap: () =>{},

          /*      Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => ScheduleAppointmentClinics(
                      clinics: widget.clinics,
                      //categories: dataProvider.categories[0],
                      profile: API.USER
                    )
                )*/

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
}
