import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:provider/provider.dart';
import 'package:salonat/localisation/language/language.dart';

import 'package:salonat/services/apiservice.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants.dart';

import '../../models/cat.dart';
import '../../services/api.dart';
import '../../services/data_repository.dart';
import '../common/screens/filter_search.dart';


class Filter extends StatefulWidget {
  const Filter({Key key}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  String isTap = '';
  String gender = '';
  String short = '';
  double rating = 0;
  String selecteditem = "";
  String selecteditem2 = '';
  String selecteditem3 = '';
  double width;
  double height;

  RangeValues _distanceRangeValues = const RangeValues(0, 1000);
  final RangeValues _priceRangeValues = const RangeValues(0, 550);
  List<Cat> _cat = [];
  List<Map<String, dynamic>> _cats = List();

  TextEditingController minpricecontroller = TextEditingController();
  TextEditingController maxpricecontroller = TextEditingController();
  TextEditingController sercontroller = TextEditingController();
  TextEditingController sercontrollername = TextEditingController();
  TextEditingController shortby = TextEditingController();

  @override
  void initState() {
    super.initState();

    WebService().getcategory().then((value) {
      if (mounted)
        setState(() {
          _cat = value;
        });
    });
  }

  @override
  void dispose() {
    sercontroller.dispose();
    maxpricecontroller.dispose();
    minpricecontroller.dispose();

    super.dispose();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    final dataProvider = Provider.of<DataReposotory>(context, listen: false);
    _cats.add({
      'title': 'At Home',
      'titre': Languages.of(context).beautyclinics.toString()
    });
    _cats.add({
      'title': 'At Salon',
      'titre': Languages.of(context).salonspa,
    });
    _cats.add({'title': 'Both', 'titre': Languages.of(context).makeupartist});
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataReposotory>(context, listen: false);

    return Scaffold(
      backgroundColor: backgroundcolor,
      extendBodyBehindAppBar: false,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios,
              color: Colors.white, size:
            API.isPhone ? 20.0 : 30.0,),
        ),
        title: Text(
          Languages.of(context).filter,
          style: TextStyle(
              fontFamily: 'Calibri_bold', fontSize: 15.sp, color: whiteColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    Languages.of(context).price +' :',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: API.isPhone ? 25.0 : 45.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            distance(),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    Languages.of(context).service+' :',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color:primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: API.isPhone ? 25.0 : 45.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            services(),
            SizedBox(
              height: 30.h,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.h),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  height: 5.h,
                  color: primaryColor,
                  minWidth: double.infinity,
                  mouseCursor: MouseCursor.defer,
                  textColor: Colors.white,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Filter_search(
                        minprice: _distanceRangeValues.start.toString(),
                        maxprice: _distanceRangeValues.end.toString(),

                        service: sercontrollername.text,
                      ),
                    ),
                  ),
                  child: Text(
                    Languages.of(context).search,
                    style: TextStyle(
                        color: whiteColor,
                        fontFamily: 'Calibri',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  services() {
    final dataProvider = Provider.of<DataReposotory>(context, listen: false);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Wrap(
            direction: Axis.horizontal,
            children: List.generate(_cats.length, (index) {
              return service(
                service: Languages.of(context).labelSelectLanguage == 'English'
                    ? _cats[index]['title']
                    : dataProvider.categories[index].nameAr,
                serviceid: dataProvider.categories[index].id.toString(),
                ontap: () {
                  setState(() {
                    Languages.of(context).labelSelectLanguage == 'English'
                        ? selecteditem = _cats[index]['title']
                        : selecteditem = _cats[index]['title'];
                    selecteditem2 = selecteditem = _cats[index]['title'];
                    selecteditem = selecteditem = _cats[index]['title'];
                    sercontroller.text = selecteditem2;
                    sercontrollername.text = selecteditem;
                  });
                },
              );
            }),
          ),
        ]));
  }

  service({String service, String serviceid, ontap}) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: InkWell(
        onTap: ontap,
        child: Container(
          height: 8.h,
          width: 29.w,
          padding: EdgeInsets.symmetric(
            horizontal: 2.h,
            vertical: 1.w,
          ),
          decoration: BoxDecoration(
            color: service == selecteditem
                ? primaryColor
                : Colors.transparent,
            border: Border.all(
                color:
                    service == selecteditem ? primaryColor : primaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                service,
                maxLines: 2,
                style: TextStyle(
                  color: service == selecteditem ?whiteColor : primaryColor,
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Rating() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 0.w),
            child: Text(
              Languages.of(context).rating,
              style: TextStyle(
                color: Color(0xffc79a9a),
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 1.w),
              child: RatingBar.builder(
                initialRating: 1,
                minRating: 1,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20.sp,
                ),
                onRatingUpdate: (rating) => setState(() {
                  this.rating = rating;
                }),
              )),
        ],
      ),
    );
  }

  shortBy() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 0.w),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Languages.of(context).shortby,
              style: TextStyle(
                color: Color(0xffc79a9a),
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  short = 'atoz';
                  shortby.text = short.toString();
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  children: [
                    Container(
                      height: 5.h,
                      width: 5.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: short == 'atoz'
                            ? Color(0xffc79a9a)
                            : greyColor.withOpacity(0.3),
                        border: Border.all(
                          color: short == 'atoz'
                              ? Color(0xffc79a9a)
                              : Colors.white,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: short == 'atoz'
                          ? Container(
                              height: 5.h,
                              width: 5.w,
                              decoration: const BoxDecoration(
                                color: Color(0xffc79a9a),
                                shape: BoxShape.circle,
                              ),
                            )
                          : Container(),
                    ),
                    SizedBox(
                      width: 1.h,
                    ),
                    Text(
                      Languages.of(context).fromatoz,
                      style: TextStyle(
                        color:
                            short == 'popular' ? Color(0xffc79a9a) : whiteColor,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  short = 'ztoa';
                  shortby.text = short.toString();
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  children: [
                    Container(
                      height: 5.h,
                      width: 5.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: short == 'ztoa'
                            ? Color(0xffc79a9a)
                            : greyColor.withOpacity(0.3),
                        border: Border.all(
                          color: short == 'ztoa'
                              ? Color(0xffc79a9a)
                              : Colors.white,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: short == 'ztoa'
                          ? Container(
                              height: 5.h,
                              width: 5.w,
                              decoration: const BoxDecoration(
                                color: Color(0xffc79a9a),
                                shape: BoxShape.circle,
                              ),
                            )
                          : Container(),
                    ),
                    SizedBox(
                      width: 1.h,
                    ),
                    Text(
                      Languages.of(context).fromztoa,
                      style: TextStyle(
                        color:
                            short == 'popular' ? Color(0xffc79a9a) : whiteColor,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  short = 'lowtohigh';
                  shortby.text = short.toString();
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  children: [
                    Container(
                      height: 5.h,
                      width: 5.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: short == 'lowtohigh'
                            ? Color(0xffc79a9a)
                            : greyColor.withOpacity(0.3),
                        border: Border.all(
                          color: short == 'lowtohigh'
                              ? Color(0xffc79a9a)
                              : Colors.white,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: short == 'lowtohigh'
                          ? Container(
                              height: 5.h,
                              width: 5.w,
                              decoration: const BoxDecoration(
                                color: Color(0xffc79a9a),
                                shape: BoxShape.circle,
                              ),
                            )
                          : Container(),
                    ),
                    SizedBox(
                      width: 1.h,
                    ),
                    Text(
                      Languages.of(context).costlowtohight,
                      style: TextStyle(
                        color: short == 'lowtohigh'
                            ? Color(0xffc79a9a)
                            : whiteColor,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  short = 'hightolow';
                  shortby.text = short.toString();
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  children: [
                    Container(
                      height: 5.h,
                      width: 5.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: short == 'hightolow'
                            ? Color(0xffc79a9a)
                            : greyColor.withOpacity(0.3),
                        border: Border.all(
                          color: short == 'hightolow'
                              ? Color(0xffc79a9a)
                              : Colors.white,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: short == 'hightolow'
                          ? Container(
                              height: 5.h,
                              width: 5.w,
                              decoration: const BoxDecoration(
                                color: Color(0xffc79a9a),
                                shape: BoxShape.circle,
                              ),
                            )
                          : Container(),
                    ),
                    SizedBox(
                      width: 1.h,
                    ),
                    Text(
                      Languages.of(context).costhightolow,
                      style: TextStyle(
                        color: short == 'hightolow'
                            ? Color(0xffc79a9a)
                            : whiteColor,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  distance() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.h,vertical: 1.h),
            child: Align(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_distanceRangeValues.start.toString()} QAR',
                    style: TextStyle(color: primaryColor,
                    fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${_distanceRangeValues.end.toString()} QAR',
                    style: TextStyle(color: primaryColor,
                    fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
              rangeThumbShape: const RoundRangeSliderThumbShape(
                  enabledThumbRadius: 5, disabledThumbRadius: 5),
              rangeValueIndicatorShape:
                  const PaddleRangeSliderValueIndicatorShape(),
              trackHeight: 20,
              valueIndicatorTextStyle: TextStyle(color: whiteColor),
              valueIndicatorColor: whiteColor,
            ),
            child: RangeSlider(
              min: 0,
              max: 10000,
              divisions: 10,
              activeColor: primaryColor,
              inactiveColor: whiteColor.withOpacity(0.3),
              values: _distanceRangeValues,
              labels: RangeLabels(
                _distanceRangeValues.start.round().toString(),
                _distanceRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _distanceRangeValues = values;


                });
              },

            ),
          )
        ],
      ),
    );
  }

  price() {
    return Languages.of(context).labelSelectLanguage == 'English'
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 0.w),
                  child: Text(
                    Languages.of(context).price,
                    style: TextStyle(
                        color: Color(0xffc79a9a),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          MaterialButton(
                            onPressed: () {},
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            height: 5.h,
                            minWidth: 10.w,
                            color: const Color(0xFFFFFFFF),
                            child: Text(
                              Languages.of(context).min,
                              style: const TextStyle(color: Color(0xffc79a9a)),
                            ),
                          ),
                          Container(
                            height: 5.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                              color: Colors.white10.withOpacity(0.80),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 2),
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1.5,
                                  blurRadius: 1.5,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              cursorColor: Color(0xffc79a9a),
                              style: const TextStyle(color: Color(0xffc79a9a)),
                              controller: minpricecontroller,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Row(
                        children: [
                          MaterialButton(
                            onPressed: () {},
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            height: 5.h,
                            minWidth: 10.w,
                            color: whiteColor,
                            child: Text(
                              Languages.of(context).max,
                              style: TextStyle(color: Color(0xffc79a9a)),
                            ),
                          ),
                          Container(
                            height: 5.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                              color: Colors.white10.withOpacity(0.80),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 2),
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1.5,
                                  blurRadius: 1.5,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              cursorColor: Color(0xffc79a9a),
                              style: const TextStyle(color: Color(0xffc79a9a)),
                              controller: maxpricecontroller,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 0.w),
                  child: Text(
                    Languages.of(context).price,
                    style: black16SemiBoldTextStyle,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          MaterialButton(
                            onPressed: () {},
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                            height: 5.h,
                            minWidth: 10.w,
                            color: const Color(0xFFFFFFFF),
                            child: Text(
                              Languages.of(context).min,
                              style: const TextStyle(color: primaryColor),
                            ),
                          ),
                          Container(
                            height: 5.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                              color: Colors.white10.withOpacity(0.80),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 2),
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1.5,
                                  blurRadius: 1.5,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              cursorColor: primaryColor,
                              style: const TextStyle(color: Colors.white),
                              controller: minpricecontroller,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Row(
                        children: [
                          MaterialButton(
                            onPressed: () {},
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                            height: 5.h,
                            minWidth: 10.w,
                            color: const Color(0xFFFFFFFF),
                            child: Text(
                              Languages.of(context).max,
                              style: const TextStyle(color: primaryColor),
                            ),
                          ),
                          Container(
                            height: 5.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                              color: Colors.white10.withOpacity(0.80),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 2),
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1.5,
                                  blurRadius: 1.5,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              cursorColor: primaryColor,
                              style: const TextStyle(color: Colors.white),
                              controller: maxpricecontroller,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }

  cancelButton() {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Text(
        'Cancel',
        style: black16SemiBoldTextStyle,
      ),
    );
  }
}
