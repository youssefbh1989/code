import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salonat/models/clinicsmodel.dart';
import 'package:salonat/models/usermodel.dart';
import 'package:salonat/supplier_detail/productdetail.dart';
import 'package:salonat/supplier_detail/supplier_subcategories.dart';
import 'package:share/share.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/constants.dart';
import '../../localisation/language/language.dart';
import '../../localisation/locale_constant.dart';
import '../../models/category.dart';
import '../../models/service_filter.dart';
import '../../models/servicesfiltermodels.dart';
import '../../services/api.dart';
import '../../services/apiservice.dart';
import '../../services/user.dart';
import '../column/Columnbuilder.dart';
import '../models/cat.dart';
import '../models/vendormodel.dart';

import '../pages/auth/signin.dart';

import '../servicelistcart/service_list.dart';

class Supplier_Detail extends StatefulWidget {
  const Supplier_Detail({Key key, this.vendor, this.profile}) : super(key: key);

  final VendorModel vendor;
  final UserModel profile;

  @override
  State<Supplier_Detail> createState() => _Supplier_DetailState();
}

class _Supplier_DetailState extends State<Supplier_Detail> {
  int numberofserviec = 0;
  TextEditingController servicesubcontroller = TextEditingController();
  final List<CategoryModel> _cat = [];
  List<Services> _service = [];
  List<ServiceFilterModel> _clinics_cat = [];
  List<ServiceFilterModel> _subcategories = [];
  List<Cat> _servicebycat = [];
  int selectedsubservice = 0;

  @override
  void initState() {
    _isloading = false;
    super.initState();
    WebService()
        .getcategoryclinics(
            category_id: '',
            salon_id: widget.vendor.id.toString(),
            max: '',
            min: '',
            search: '',
            type: '')
        .then((value) {
      setState(() {
        _clinics_cat = value;
        print(_clinics_cat);
        _isloading = false;
      });
    });
    WebService().getcategory().then((value) {
      if (mounted) {
        setState(() {
          _servicebycat = value;
          _isloading = false;
        });
      }
    });
  }

  getdata() {
    WebService()
        .getfil(
            category_id: selectedservice.toString(),
            salon_id: widget.vendor.id.toString(),
            max: '',
            min: '',
            search: '',
            type: '')
        .then((value) {
      setState(() {
        if (mounted) _subcategories = value;
        if (kDebugMode) {
          print(_subcategories);
        }
        _isloading = false;
      });
    });
  }

  void openMaps(LatLng ltn) async {
    final lat = widget.vendor.lat != null && widget.vendor.lat != .0
        ? widget.vendor.lat
        : 25.287215;
    final lng = widget.vendor.lng != null && widget.vendor.lng != .0
        ? widget.vendor.lng
        : 51.535910;
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(googleUrl) == null) {
      throw 'Could not open the map.';
    } else {
      await launch(googleUrl);
    }
  }

  double height;
  double width;

  bool isFavorite = false;
  bool _isloading = true;
  String isSelected = 'about';
  GoogleMapController mapController;
  final Set<Marker> marker = {};
  final item = 0;
  String selectedservice = "";

  double rating = 0;
  final TextEditingController _reviewController = TextEditingController();

  double long = 49.5;
  double lat = -0.09;
  var location = [];
  String address1;
  String address2;
  String address3;
  bool details = false;

  final Completer<GoogleMapController> _controller = Completer();

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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: whiteColor,
              size: 15.sp,
            ),
          ),
          // actions: [
          //   PopupMenuButton<String>(
          //     color: whiteColor.withOpacity(0.5),
          //     shape: const RoundedRectangleBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(15.0))),
          //     icon: ClipOval(
          //         child: Languages.of(context).labelSelectLanguage == "English"
          //             ? Image.asset('assets/new/england.png')
          //             : Image.asset('assets/new/qatar.png')),
          //     onSelected: (String result) {
          //       changeLanguage(context, result);
          //     },
          //     itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          //       PopupMenuItem<String>(
          //         value: 'ar',
          //         child: Text('العربية',
          //             style: GoogleFonts.cairo(
          //                 fontWeight: FontWeight.w700, color: whiteColor)),
          //       ),
          //       PopupMenuItem<String>(
          //         value: 'en',
          //         child: Text('English',
          //             style: GoogleFonts.cairo(
          //                 fontWeight: FontWeight.w700, color: whiteColor)),
          //       ),
          //     ],
          //   ),
          // ],
          //title: Text(widget.clinics.id.toString()),
        ),
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: false,
        resizeToAvoidBottomInset: true,
        body: Container(
          child: nestedScrollView(),
        ),
        //bottomNavigationBar: bookAppointmentButton(),
      ),
    );
  }

  nestedScrollView() {
    return NestedScrollView(
      headerSliverBuilder: (context, b) {
        return [
          SliverAppBar(
            pinned: false,
            expandedHeight: 30.h,
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
                image: DecorationImage(
                  image:
                      NetworkImage('http://salonat.qa/' + widget.vendor.cover),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                color: blackColor.withOpacity(0.2),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(10.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipOval(
                                child: widget.vendor.image == null
                                    ? _shimmer()
                                    : CachedNetworkImage(
                                        imageUrl: 'http://salonat.qa/' +
                                            widget.vendor.image,
                                        height: 12.h,
                                        width: 25.w,
                                        errorWidget: (_, __, ___) => Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: Icon(
                                            Icons.broken_image_outlined,
                                            size: 15.sp,
                                          ),
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 0.5.h),
                                          child: Text(
                                            Languages.of(context)
                                                        .labelSelectLanguage ==
                                                    'English'
                                                ? widget.vendor.name
                                                : widget.vendor.nameAr,
                                            style: TextStyle(
                                                color: whiteColor,
                                                fontFamily: 'Calibri_bold',
                                                fontSize: 15.sp),
                                          ),
                                        ),
                                        widget.vendor.total_user_rated.toString()!='0'?Row(
                                          children: [
                                            Icon(
                                              Icons.star_rounded,
                                              color: yellowColor,
                                              size: 20.sp,
                                            ),
                                            widthSpace,
                                            Text(
                                              widget.vendor == null
                                                  ? const Center()
                                                  : '${widget.vendor.rating} (${widget.vendor.total_user_rated}) ' +
                                                      Languages.of(context)
                                                          .Review,
                                              style: TextStyle(
                                                  color: whiteColor,
                                                  fontSize: 12.sp,
                                                  fontFamily: 'Calibri'),
                                            ),
                                          ],
                                        ):Center()
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ];
      },
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          tabBar(),
          isSelected == 'about'
              ? about()
              : isSelected == 'services'
                  ? category()
                  : gallery(),
        ],
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
            onTap: () => API.USER == null
                ? _loginalert()
                : servicesubcontroller.text.isEmpty
                    ? _serviceempty()
                    : _addtocart(),
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "",
                      style: white18SemiBoldTextStyle,
                    ),
                    Text(
                      Languages.of(context).Next,
                      style: white18SemiBoldTextStyle,
                    ),
                    Text(
                      numberofserviec.toString(),
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

  tabBar() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.h),
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            color: Colors.transparent,
            spreadRadius: 1.5,
            blurRadius: 1.5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isSelected = 'about';
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 2.w,
                vertical: 2.h,
              ),
              child: Text(
                Languages.of(context).about,
                style: TextStyle(
                    color: isSelected == 'about' ? primaryColor : whiteColor,
                    fontSize: 15.sp,
                    fontFamily: 'SFRProRegular'),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                isSelected = 'services';
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 2.w,
                vertical: 2.h,
              ),
              child: Text(
                Languages.of(context).product,
                style: TextStyle(
                    color: isSelected == 'services' ? primaryColor : whiteColor,
                    fontSize: 15.sp,
                    fontFamily: 'SFRProRegular'),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                isSelected = 'gallery';
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 2.h,
                vertical: 2.w,
              ),
              child: Text(
                Languages.of(context).gallery,
                style: TextStyle(
                    color: isSelected == 'gallery' ? primaryColor : whiteColor,
                    fontSize: 15.sp,
                    fontFamily: 'SFRProRegular'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  about() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
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
                        Languages.of(context).about,
                        style: black15MediumTextStyle,
                      ),
                    ),
                    heightSpace,
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                      child: ExpandableText(
                        _removeAllHtmlTags(
                            Languages.of(context).labelSelectLanguage ==
                                    'English'
                                ? widget.vendor.about
                                : widget.vendor.aboutAr),
                        expandText: Languages.of(context).showmore,
                        collapseText: Languages.of(context).showless,
                        maxLines: 5,
                        linkColor: primaryColor,
                        linkStyle: primaryColor13BoldTextStyle,
                        style: grey13RegularTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Padding(
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
                            child: GestureDetector(
                              onTap: () {
                                launchUrl(Uri.parse(
                                    'tel:${widget.vendor.phone.toString() ?? widget.vendor.phone.toString() ?? ''}'));
                              },
                              child: Text(
                                widget.vendor.phone.toString(),
                                style: greyRegularTextStyle,
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
                              launchUrl(Uri.parse(
                                  'mailto:${widget.vendor.email.toString()}'));
                            },
                            child: Text(
                              widget.vendor.email.toString(),
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
          ),
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
            child: widget.vendor.saturday_opening != null &&
                    widget.vendor.sunday_closing != null &&
                    widget.vendor.sunday_opening != null &&
                    widget.vendor.friday_opening != null &&
                    widget.vendor.thursday_closing != null &&
                    widget.vendor.wednesday_closing != null &&
                    widget.vendor.thursday_opening != null &&
                    widget.vendor.wednesday_opening != null &&
                    widget.vendor.tuesday_closing != null &&
                    widget.vendor.tuesday_opening != null &&
                    widget.vendor.monday_closing != null &&
                    widget.vendor.monday_opening != null
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
                                          widget.vendor.monday_opening,
                                          style: white13RegularTextStyle,
                                        ),
                                        widthSpace,
                                        Text(
                                          widget.vendor.monday_closing,
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
                                          widget.vendor.tuesday_opening,
                                          style: white13RegularTextStyle,
                                        ),
                                        widthSpace,
                                        Text(
                                          widget.vendor.tuesday_closing,
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
                                          widget.vendor.wednesday_opening,
                                          style: white13RegularTextStyle,
                                        ),
                                        widthSpace,
                                        Text(
                                          widget.vendor.wednesday_closing,
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
                                          widget.vendor.thursday_opening,
                                          style: white13RegularTextStyle,
                                        ),
                                        widthSpace,
                                        Text(
                                          widget.vendor.thursday_closing,
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
                                          widget.vendor.friday_opening,
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
                                          widget.vendor.saturday_opening,
                                          style: white13RegularTextStyle,
                                        ),
                                        widthSpace,
                                        Text(
                                          widget.vendor.saturday_closing,
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
                                          widget.vendor.sunday_opening,
                                          style: white13RegularTextStyle,
                                        ),
                                        widthSpace,
                                        Text(
                                          widget.vendor.sunday_closing,
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
          ),
          SizedBox(
            height: 1.h,
          ),
          Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                  child: widget.vendor.lng != 0
                      ? Row(
                          children: [
                            heightSpace,
                            Expanded(
                              child: Container(
                                height: 18.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: ClipPath(
                                  clipper: ShapeBorderClipper(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6)),
                                  ),
                                  child: GoogleMap(
                                    mapType: MapType.normal,
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                          widget.vendor.lat ?? 25.287215,
                                          widget.vendor.lng ?? 51.535910),
                                      zoom: 14.4746,
                                    ),
                                    markers: widget.vendor.lat != null &&
                                            widget.vendor.lat != .0
                                        ? {
                                            Marker(
                                              position: LatLng(
                                                  widget.vendor.lat,
                                                  widget.vendor.lng),
                                              markerId: const MarkerId('pos'),
                                            )
                                          }
                                        : (<Marker>{}),
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      _controller.complete(controller);
                                    },
                                    onTap: openMaps,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container())
            ],
          ),
        ],
      ),
    );
  }

  category() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColumnBuilder(
              itemCount: widget.vendor.categories.length,
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
                    child: Container(decoration: BoxDecoration(

                    ),
                      child: ListTile(
                        leading: widget.vendor.categories[index].image == null
                            ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.broken_image_outlined,
                                color: blackColor),
                          ],
                        )
                            : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              'http://salonat.qa/' +
                                  widget.vendor.categories[index].image,
                              color: Color(0xffB2628E),
                              height: 4.h,
                              width: 12.w,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Subcategories_Services(
                                      salonid: widget.vendor.id.toString(),
                                      categories: widget
                                          .vendor.categories[index].id
                                          .toString(),
                                      categorie_name:
                                      widget.vendor.categories[index].name),
                                ));
                          },
                          child: Text('View',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontFamily: 'Calibri',
                                  fontSize: 10.sp)),
                        ),
                        title: Text(
                            Languages.of(context).labelSelectLanguage == 'English'
                                ? widget.vendor.categories[index].name
                                : widget.vendor.categories[index].nameAr,
                            style: TextStyle(
                                color: blackColor,
                                fontFamily: 'Calibri',
                                fontSize: 12.sp),
                            maxLines: 1,
                            overflow: TextOverflow.clip),
                        // subtitle:
                        // widget.vendor.categories[index].servicesCount == null
                        //     ? const Center()
                        //     : Text(widget
                        //     .vendor.categories[index].servicesCount
                        //     .toString()),
                      ),
                    ),
                  ),
                );
              }),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
            child: Container(
                child: selectedservice.isEmpty
                    ? Container()
                    : ColumnBuilder(
                        itemCount: _subcategories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: whiteColor.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(0),
                                border: Border.all(
                                  color: selectedservice == item
                                      ? primaryColor
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Product_Detail(
                                              product: _subcategories[index],

                                            )),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.h, vertical: 0.w),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide()),
                                    ),
                                    padding: EdgeInsets.all(0.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    children: [],
                                                  )),
                                              Expanded(
                                                  flex: 6,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              _subcategories[
                                                                      index]
                                                                  .name,
                                                              style: TextStyle(
                                                                  color: isSelected ==
                                                                          true
                                                                      ? primaryColor
                                                                      : blackColor,
                                                                  fontFamily:
                                                                      'Calibri',
                                                                  fontSize:
                                                                      12.sp),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 1.5.h,
                                                      ),
                                                      Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                '${_subcategories[index].price.toString()} QAR',
                                                                style: TextStyle(
                                                                    color:
                                                                        blackColor,
                                                                    fontFamily:
                                                                        'Calibri',
                                                                    fontSize:
                                                                        10.sp),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        )

                                        // Padding(
                                        //   padding: EdgeInsets.symmetric(
                                        //       horizontal: 1.h,
                                        //       vertical: 0.w),
                                        //   child: ListTile(
                                        //     leading: isSelected == true
                                        //         ? Icon(
                                        //             Icons.add,
                                        //             color: primaryColor,
                                        //           )
                                        //         : Icon(
                                        //             Icons.add,
                                        //             color: greyColor,
                                        //           ),
                                        //     title: Text(
                                        //       _subcategories[index].name,
                                        //       style: TextStyle(
                                        //           color: isSelected == true
                                        //               ? primaryColor
                                        //               : blackColor,
                                        //           fontFamily: 'Calibri',
                                        //           fontSize: 12.sp),
                                        //       maxLines: 1,
                                        //       overflow:
                                        //           TextOverflow.ellipsis,
                                        //     ),
                                        //     trailing: Text(
                                        //       '${_subcategories[index].price.toString()} QAR',
                                        //       style: TextStyle(
                                        //         color: isSelected == true
                                        //             ? primaryColor
                                        //             : blackColor,
                                        //         fontSize: 6.sp,
                                        //         fontWeight: FontWeight.w700,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // )

                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.spaceBetween,
                                        //   children: [
                                        //     Expanded(
                                        //         flex: 1,
                                        //       child:Icon(Icons.add,
                                        //                 color: primaryColor)
                                        //         ),
                                        //     Expanded(
                                        //       flex: 3,
                                        //       child: Text(
                                        //         Languages.of(context)
                                        //                     .labelSelectLanguage ==
                                        //                 'English'
                                        //             ? _subcategories[index]
                                        //                 .name
                                        //             : _subcategories[index]
                                        //                 .nameAr,
                                        //         textAlign: TextAlign.center,
                                        //         style: TextStyle(
                                        //             color: blackColor,
                                        //             fontFamily: 'Calibri',
                                        //             fontSize: 12.sp),
                                        //         maxLines: 1,
                                        //         overflow:
                                        //             TextOverflow.ellipsis,
                                        //       ),
                                        //     ),
                                        //     SizedBox(
                                        //       width: 1.w,
                                        //     ),
                                        //     Expanded(
                                        //       flex: 2,
                                        //       child: Row(
                                        //         children: [
                                        //           Text(
                                        //             Languages.of(context)
                                        //                         .labelSelectLanguage ==
                                        //                     'English'
                                        //                 ? '${_subcategories[index].price.toString()} QAR'
                                        //                 : ' ${_subcategories[index].price.toString()} رق ',
                                        //             style: TextStyle(
                                        //               color:
                                        //                   selectedsubservice ==
                                        //                           index
                                        //                       ? primaryColor
                                        //                       : blackColor,
                                        //               fontSize: 8.sp,
                                        //               fontWeight:
                                        //                   FontWeight.w700,
                                        //             ),
                                        //           ),
                                        //           SizedBox(
                                        //             width: 1.w,
                                        //           ),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        // Padding(
                                        //   padding:
                                        //       EdgeInsets.only(left: 60.w),
                                        //   child: Row(
                                        //     children: [
                                        //       Expanded(
                                        //         flex: 1,
                                        //         child: Text(
                                        //           'See More >>',
                                        //           style: TextStyle(
                                        //             color: blackColor,
                                        //             fontSize: 8.sp,
                                        //             fontWeight:
                                        //                 FontWeight.w500,
                                        //           ),
                                        //         ),
                                        //       )
                                        //     ],
                                        //   ),
                                        // ),
                                        // Divider(
                                        //   color: blackColor,
                                        //   height: 2.h,
                                        //   thickness: 2,
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )),
          )
        ],
      ),
    );
  }

  gallery() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StaggeredGridView.countBuilder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            staggeredTileBuilder: (index) => index % 7 == 0
                ? StaggeredTile.count(2, 2)
                : StaggeredTile.count(1, 1),
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            itemCount: (widget.vendor != 0 ?? false)
                ? widget.vendor.gallery.length
                : widget.vendor.gallery.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    image: NetworkImage('http://salonat.qa/' +
                        widget.vendor.gallery[index]),
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  review() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
            child: Container(
              height: 25.h,
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
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.h, vertical: 2.w),
                        child: Text(Languages.of(context).review,
                            style: grey13RegularTextStyle),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.h, vertical: 2.w),
                        child: Text(
                            Languages.of(context).feeling_about_salon + " ?",
                            style: grey13RegularTextStyle),
                      ),
                    ],
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                      child: RatingBar.builder(
                        initialRating: 1,
                        minRating: 1,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) => setState(() {
                          this.rating = rating;
                        }),
                      )),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            height: 6.h,
                            decoration: BoxDecoration(
                              color: Colors.white10.withOpacity(0.20),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextFormField(
                              controller: _reviewController,
                              cursorColor: primaryColor,
                              style: white13RegularTextStyle,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 2.h),
                                hintText: Languages.of(context).say_somthings,
                                hintStyle: grey13RegularTextStyle,
                                border: const UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1.h,
                        ),
                        Languages.of(context).labelSelectLanguage == 'English'
                            ? Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: API.USER == null
                                        ? _loginalert
                                        : _review,
                                    child: Container(
                                        height: 6.h,
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                            child: Image.asset(
                                          'assets/icons/review.png',
                                        ))),
                                  ),
                                ),
                              )
                            : Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: API.USER == null
                                        ? _loginalert
                                        : _review,
                                    child: Container(
                                        height: 6.h,
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                            child: Image.asset(
                                                'assets/specialists/Group 76.png'))),
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          allReview(),
        ],
      ),
    );
  }

  allReview() {
    return widget.vendor.reviewedUsers.isNotEmpty
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.w),
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.vendor.reviewedUsers.length,
                      itemBuilder: (context, index) {
                        final item = widget.vendor.reviewedUsers[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.h, vertical: 1.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.vendor.reviewedUsers[index]
                                            .userName,
                                        style: black15MediumTextStyle,
                                      ),
                                      SizedBox(height: 2.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star_rounded,
                                                color: yellowColor,
                                                size: 15.sp,
                                              ),
                                              widthSpace,
                                              Text(
                                                widget.vendor.rating,
                                                style: white12RegularTextStyle,
                                              ),
                                              widthSpace,
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              heightSpace,
                              Text(
                                widget.vendor.reviewedUsers[index].review,
                                style: grey13RegularTextStyle,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        : Container();
  }

  void _loginalert({String text}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          backgroundColor: Colors.white.withOpacity(0.15),
          child: Container(
            height: 18.h,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white10.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
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
                          text ?? Languages.of(context).pleaselogin,
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
                                  borderRadius: BorderRadius.circular(25)),
                              height: 5.h,
                              color: whiteColor,
                              mouseCursor: MouseCursor.defer,
                              textColor: Colors.white,
                              minWidth: double.infinity,
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => const Signin()))),
                              child: Text(
                                Languages.of(context).ok,
                                style: TextStyle(
                                    color: const Color(0xFF9B16A1),
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
                          text ?? Languages.of(context).pleasepickservice,
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
                              onPressed: () => Navigator.pop(context),
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

  Future<void> _addtocart() async {
    setState(() {});

    setState(() {});

    final join = await WebService().addtocart(
        service_id: servicesubcontroller.text.toString(),
        quantity: numberofserviec.toString());
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => ScheduleAppointmentClinics(
    //           vendor: _vendor,
    //           //categories: _categories,
    //           profile: API.USER)),
    // );
  }

  Future<void> _review() async {
    setState(() {});

    setState(() {});

    final join = await UsersWebService().addreview(
        review: _reviewController.text,
        rating: rating.toString(),
        salon_id: widget.vendor.id.toString());

    _logoutDialog();
  }

  void _logoutDialog({String text}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.w),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          backgroundColor: Colors.white.withOpacity(0.15),
          child: Container(
            height: 20.h,
            width: 65.w,
            decoration: BoxDecoration(
              color: Colors.white10.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
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
                  padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 3.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.h, vertical: 3.w),
                        child: Text(
                          text ?? Languages.of(context).thanksforyoursupport,
                          textAlign: TextAlign.center,
                          style: black15SemiBoldTextStyle,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.h, vertical: 3.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () => [
                                  Navigator.pop(context),
                                  _reviewController.clear(),
                                ],
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 1.h, vertical: 1.w),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    border: Border.all(color: primaryColor),
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primaryColor.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    Languages.of(context).ok,
                                    style: primaryColor18SemiBoldTextStyle,
                                  ),
                                ),
                              ),
                            ),
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

  String _removeAllHtmlTags(String htmlText) {
    if (htmlText == null) return 'N/A';
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  Widget _shimmer() {
    return Shimmer.fromColors(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.red,
        ),
        baseColor: Colors.transparent,
        highlightColor: Colors.white);
  }
}
