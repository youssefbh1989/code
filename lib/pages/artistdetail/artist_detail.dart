import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:salonat/column/Columnbuilder.dart';
import 'package:salonat/localisation/language/language.dart';
import 'package:salonat/models/artistmodel.dart';
import 'package:salonat/models/category.dart';
import 'package:salonat/models/clinicsmodel.dart';
import 'package:salonat/models/salonmodels.dart';
import 'package:salonat/models/service_filter.dart';
import 'package:salonat/models/servicesfiltermodels.dart';
import 'package:salonat/models/usermodel.dart';
import 'package:salonat/services/apiservice.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import '../../constants/constants.dart';
import '../../localisation/locale_constant.dart';
import '../../models/cartemodel.dart';
import '../../servicelistcart/service_list.dart';
import '../../servicelistcart/servicelistartist.dart';
import '../../services/api.dart';
import '../../services/user.dart';
import '../Chart/Chart.dart';
import '../auth/signin.dart';
import '../bottom_bar.dart';


class ArtistDetail extends StatefulWidget {
  const ArtistDetail({
    Key key,
    this.salons,
    this.services,
    this.categories,
    this.profile,
    this.clinics,
    String id,
    this.salon_id,
    this.artist,
    String artistid,
  }) : super(key: key);

  final SalonModel salons;
  final Service services;
  final CategoryModel categories;
  final UserModel profile;
  final ClinicModel clinics;
  final int salon_id;
  final ArtistModel artist;

  @override
  _ArtistDetailState createState() => _ArtistDetailState();
}

class _ArtistDetailState extends State<ArtistDetail> {
  double height;
  double width;

  bool isFavorite = false;
  bool _isloading = true;
  String isSelected = 'about';
  GoogleMapController mapController;
  final Set<Marker> marker = {};
  ArtistModel _artist;
  CategoryModel _categories;
  final List<CategoryModel> _cat = [];
  List<Services> _service = [];
  List<ArtistModel> _artists = [];
  List<ServiceFilterModel> _servicebycat = [];
  List<ServiceFilterModel> _subcategories = [];
  List<CarteModel> _carte = [];
  int selectedsubservice = 0;
  TextEditingController servicesubcontroller = TextEditingController();
  int numberofserviec = 0;

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
  void initState() {
    super.initState();

    _artist = widget.artist;

    _categories = widget.categories;

    WebService()
        .getfilter(
            category_id: '',
            salon_id: widget.artist.id.toString(),
            max: '',
            min: '',
            search: '',
            type: '')
        .then((value) {
      setState(() {
        //_servicebycat = value;
        _isloading = false;
      });
    });

    WebService().getoffersservices().then((value) {
      if (mounted)
        setState(() {
          _service = value;
          _isloading = false;
        });
    });
  }

  getdata() {
    WebService()
        .getfil(
            category_id: selectedservice.toString(),
            salon_id: widget.salon_id.toString(),
            max: '',
            min: '',
            search: '',
            type: '')
        .then((value) {
      setState(() {
        _subcategories = value;
        _isloading = false;
      });
    });
  }

  getcart() {
    WebService().getcart(0).then((value) {
      setState(() {
        _carte = value;
        _isloading = false;
      });
    });
  }

  @override
  void dispose() {
    _artist;
    _categories;
    _servicebycat;
    _service;
    _subcategories;
    super.dispose();
  }

  void openMaps(LatLng ltn) async {
    final lat =
        _artist.lat != null && _artist.lat != .0 ? _artist.lat : 25.287215;
    final lng =
        _artist.lng != null && _artist.lng != .0 ? _artist.lng : 51.535910;
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(googleUrl) == null) {
      throw 'Could not open the map.';
    } else {
      await launch(googleUrl);
    }
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
          actions: [
            // GestureDetector(
            //     onTap: () {
            //       getcart();
            //       _carte.isNotEmpty
            //           ? Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => Chart(),
            //           ))
            //           : Text('');
            //     },
            //     child: Stack(
            //       children: [
            //         Padding(
            //           padding:
            //           EdgeInsets.symmetric(horizontal: 2.h, vertical: 4.w),
            //           child: Image.asset('assets/icons/Group 369.png'),
            //         ),
            //       ],
            //     )
            // )
          ],

        ),
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: false,
        resizeToAvoidBottomInset: true,
        body: Container(
          child: nestedScrollView(),
        ),
        // bottomNavigationBar: isSelected == 'services' ? bookAppointmentButton() : Text(''),
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
                  image: NetworkImage('http://salonat.qa/' + _artist.cover),
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
                            ClipOval(
                              child: widget.artist.image == null
                                  ? _shimmer()
                                  : CachedNetworkImage(
                                      imageUrl: 'http://salonat.qa/' +
                                          widget.artist.image,
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
                                                ? _artist.name
                                                : _artist.nameAr,
                                            style: TextStyle(
                                                fontFamily: 'Calibri_bold',
                                                fontSize: 15.sp,
                                                color: whiteColor),
                                          ),
                                        ),
                                        _artist.totalUserRated != '0'
                                            ? Row(
                                                children: [
                                                  Icon(
                                                    Icons.star_rounded,
                                                    color: yellowColor,
                                                    size: 20.sp,
                                                  ),
                                                  widthSpace,
                                                  Text(
                                                    _artist == null
                                                        ? const Center()
                                                        : '${_artist.rating} (${_artist.totalUserRated}) ' +
                                                            Languages.of(
                                                                    context)
                                                                .Review,
                                                    style: TextStyle(
                                                        color: whiteColor,
                                                        fontSize: 12.sp,
                                                        fontFamily: 'Calibri'),
                                                  ),
                                                ],
                                              )
                                            : Center()
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     return Share.share('www.google.com');
                        //   },
                        //   child: Padding(
                        //     padding: EdgeInsets.symmetric(
                        //         horizontal: 0.h, vertical: 1.w),
                        //     child: Container(
                        //         padding: EdgeInsets.symmetric(
                        //             horizontal: 1.h, vertical: 1.w),
                        //         decoration: const BoxDecoration(
                        //           // border: Border.all(color: whiteColor),
                        //           // borderRadius: BorderRadius.circular(7),
                        //         ),
                        //         child: Image.asset(
                        //           'assets/profilepic/share2.png',
                        //           height: 2.h,
                        //           width: 4.w,
                        //         )),
                        //   ),
                        // ),
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
                  : isSelected == 'gallery'
                      ? gallery()
                      : review(),
        ],
      ),
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
                Languages.of(context).service,
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
          InkWell(
            onTap: () {
              setState(() {
                isSelected = 'review';
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
              child: Text(
                Languages.of(context).review,
                style: TextStyle(
                    color: isSelected == 'review' ? primaryColor : whiteColor,
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
            child: _artist.about == null
                ? Container()
                : Container(
                    width: double.infinity,
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 1.h, vertical: 1.w),
                            child: Text(
                              Languages.of(context).about,
                              style: black15MediumTextStyle,
                            ),
                          ),
                          heightSpace,
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 1.h, vertical: 1.w),
                            child: ExpandableText(
                              _removeAllHtmlTags(
                                  Languages.of(context).labelSelectLanguage ==
                                          'English'
                                      ? _artist.about
                                      : _artist.aboutAr),
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
                                    'tel:${_artist.phone.toString() ?? _artist.phone.toString() ?? ''}'));
                              },
                              child: Text(
                                _artist.phone.toString(),
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
                                  'mailto:${_artist.email.toString()}'));
                            },
                            child: Text(
                              _artist.email.toString(),
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
            child: _artist.saturday_opening != null &&
                    _artist.sunday_closing != null &&
                    _artist.sunday_opening != null &&
                    _artist.friday_opening != null &&
                    _artist.thursday_closing != null &&
                    _artist.wednesday_closing != null &&
                    _artist.thursday_opening != null &&
                    _artist.wednesday_opening != null &&
                    _artist.tuesday_closing != null &&
                    _artist.tuesday_opening != null &&
                    _artist.monday_closing != null &&
                    _artist.monday_opening != null
                ? Container(
                    width: double.infinity,
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
                                          _artist.monday_opening,
                                          style: white13RegularTextStyle,
                                        ),
                                        widthSpace,
                                        Text(
                                          _artist.monday_closing,
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
                                          _artist.tuesday_opening,
                                          style: white13RegularTextStyle,
                                        ),
                                        widthSpace,
                                        Text(
                                          _artist.tuesday_closing,
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
                                          _artist.wednesday_opening,
                                          style: white13RegularTextStyle,
                                        ),
                                        widthSpace,
                                        Text(
                                          _artist.wednesday_closing,
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
                                          _artist.thursday_opening,
                                          style: white13RegularTextStyle,
                                        ),
                                        widthSpace,
                                        Text(
                                          _artist.thursday_closing,
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
                                          _artist.friday_opening,
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
                                          _artist.saturday_opening,
                                          style: white13RegularTextStyle,
                                        ),
                                        widthSpace,
                                        Text(
                                          _artist.saturday_closing,
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
                                          _artist.sunday_opening,
                                          style: white13RegularTextStyle,
                                        ),
                                        widthSpace,
                                        Text(
                                          _artist.sunday_closing,
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
                : Center(),
          ),
          SizedBox(
            height: 2.h,
          ),
          Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                  child: widget.artist.lng != 0
                      ? Row(
                          children: [
                            heightSpace,
                            Expanded(
                              child: Container(
                                height: 18.h,
                                decoration: BoxDecoration(
                                  color: greyColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: ClipPath(
                                  clipper: ShapeBorderClipper(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  child: GoogleMap(
                                    mapType: MapType.normal,
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(_artist.lat ?? 25.287215,
                                          _artist.lng ?? 51.535910),
                                      zoom: 14.4746,
                                    ),
                                    markers: _artist.lat != null &&
                                            _artist.lat != .0
                                        ? {
                                            Marker(
                                              position: LatLng(
                                                  _artist.lat, _artist.lng),
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

  locationinfo() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
          child: Text(
            'Location :  ',
            style: black15MediumTextStyle,
          ),
        ),
      ],
    );
  }

  packageAndOffer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Current Package & Offers',
          style: black16SemiBoldTextStyle,
        ),
        ListView.builder(
          itemCount: _service.length,
          itemBuilder: (context, index) {
            final item = _service[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white10.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage("assets/offer/offer1.png"),

                    // NetworkImage('http://salonat.qa/images/categories/' +
                    //     _service[index].category.image),
                    fit: BoxFit.cover,
                  ),
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
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _service[index].name,
                            style: black18BoldTextStyle,
                          ),
                          heightSpace,
                          heightSpace,
                          heightSpace,
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 1.h, vertical: 1.w),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  ' 25 % OFF ',
                                  style: white14MediumTextStyle,
                                ),
                              ),
                              widthSpace,
                              widthSpace,
                              Text(
                                _service[index].special != null
                                    ? _service[index].special.specialPrice +
                                        ' QAR'
                                    : 'N/A',
                                style: primaryColor12BoldTextStyle,
                              ),
                            ],
                          ),
                          heightSpace,
                          Text(
                            _service[index].special != null
                                ? 'Completed package offer till ${_service[index].special.expirydate.toString()}'
                                : "N/A",
                            style: black12RegularTextStyle,
                          ),
                          heightSpace,
                          heightSpace,
                          InkWell(
                            onTap: () {
                              () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Signin(),
                                    ),
                                  );
                            },
                            child: Text(
                              'Book Now',
                              style: primaryColor13BoldTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
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
                padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Languages.of(context).addcart,
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

  services() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _isloading
              ? const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    color: primaryColor,
                  ),
                )
              : ListView.builder(
                  itemCount: _servicebycat.length,
                  itemBuilder: (context, index) {
                    final item = _cat[index];
                    Color color = const Color(0xffef9a9a);
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.h, vertical: 1.w),
                        child: ExpandablePanel(
                          theme: const ExpandableThemeData(
                            iconColor: whiteColor,
                            iconPadding: EdgeInsets.all(10.0),
                          ),
                          header: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  widthSpace,
                                  widthSpace,
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 1.h, vertical: 1.w),
                                    child: Text(
                                      _servicebycat[index].name,
                                      style: whiteBoldTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
                  itemCount: (_artist != 0 ?? false)
                      ? _artist.gallery.length
                      : _artist.gallery.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage('http://salonat.qa/' +
                              _artist.gallery[index]),
                          fit: BoxFit.cover,
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
                borderRadius: BorderRadius.circular(6),
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
    return _artist.reviewedUsers.isNotEmpty
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
                    ColumnBuilder(
                      itemCount: _artist.reviewedUsers.length,
                      itemBuilder: (context, index) {
                        final item = _artist.reviewedUsers[index];
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
                                        _artist.reviewedUsers[index].userName,
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
                                                _artist.rating,
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
                                _artist.reviewedUsers[index].review,
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

  divider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
      color: Colors.grey,
      height: 1,
      width: double.infinity,
    );
  }

  String _removeAllHtmlTags(String htmlText) {
    if (htmlText == null) return 'N/A';
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  Future<void> _review() async {
    setState(() {});

    setState(() {});

    final join = await UsersWebService().addreview(
        review: _reviewController.text,
        rating: rating.toString(),
        salon_id: widget.artist.id.toString());

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
                              height: 5.h,
                              color: whiteColor,
                              mouseCursor: MouseCursor.defer,
                              textColor: Colors.white,
                              minWidth: double.infinity,
                              onPressed: () => Navigator.pop(context),
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

  category() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColumnBuilder(
              itemCount: widget.artist.categories.length,
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
                        leading: widget.artist.categories[index].image == null
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
                                        widget.artist.categories[index].image,
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
                                  builder: (context) => Service_list_artist(
                                      artists: widget.artist,
                                      salonid: widget.artist.id,
                                      categories: widget.artist.categories[index].id.toString(),
                                      categorie_name: widget.artist.categories[index].name),
                                ));
                          },
                          child: Text('View',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontFamily: 'Calibri',
                                  fontSize: 10.sp)),
                        ),
                        title: Text(
                            Languages.of(context).labelSelectLanguage ==
                                    'English'
                                ? widget.artist.categories[index].name
                                : widget.artist.categories[index].nameAr,
                            style: TextStyle(
                                color: blackColor,
                                fontFamily: 'Calibri',
                                fontSize: 12.sp),
                            maxLines: 1,
                            overflow: TextOverflow.clip),
                        // subtitle: widget
                        //             .artist.categories[index].servicesCount ==
                        //         null
                        //     ? const Center()
                        //     : Text(widget.artist.categories[index].servicesCount
                        //         .toString()),
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
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0.h, vertical: 0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _isloading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.grey,
                                    color: primaryColor,
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemCount: _subcategories.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedsubservice = index;
                                          selectedsubservice =
                                              _subcategories[index].id;
                                          servicesubcontroller.text =
                                              selectedsubservice.toString();
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.h, vertical: 1.w),
                                        child: Container(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 1.h,
                                                    vertical: 1.w),
                                                child: Text(
                                                  Languages.of(context)
                                                              .labelSelectLanguage ==
                                                          'English'
                                                      ? _subcategories[index]
                                                          .name
                                                      : _subcategories[index]
                                                          .nameAr,
                                                  style: whiteBoldTextStyle,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 3.h,
                                                    width: 3.w,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          selectedsubservice ==
                                                                  _subcategories[
                                                                          index]
                                                                      .id
                                                              ? whiteColor
                                                              : greyColor
                                                                  .withOpacity(
                                                                      0.3),
                                                      border: Border.all(
                                                        color: selectedsubservice ==
                                                                _subcategories[
                                                                        index]
                                                                    .id
                                                            ? primaryColor
                                                            : Colors.white,
                                                      ),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: selectedsubservice ==
                                                            _subcategories[
                                                                    index]
                                                                .id
                                                        ? Container(
                                                            height: 5.h,
                                                            width: 5.w,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  primaryColor,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                          )
                                                        : Container(),
                                                  ),
                                                  SizedBox(
                                                    width: 1.h,
                                                  ),
                                                  Text(
                                                    Languages.of(context)
                                                                .labelSelectLanguage ==
                                                            'English'
                                                        ? '${_subcategories[index].price.toString()} QAR'
                                                        : 'QAR ${_subcategories[index].price.toString()} ',
                                                    style: TextStyle(
                                                      color:
                                                          selectedsubservice ==
                                                                  index
                                                              ? primaryColor
                                                              : whiteColor,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 1.w,
                                                  ),
                                                  // RawMaterialButton(
                                                  //   constraints:
                                                  //   BoxConstraints.tightFor(
                                                  //       width: 6.w,
                                                  //       height: 3.h),
                                                  //   elevation: 6.0,
                                                  //   onPressed: () {
                                                  //     setState(() {
                                                  //       numberofserviec--;
                                                  //     });
                                                  //   },
                                                  //   shape:
                                                  //   RoundedRectangleBorder(
                                                  //       borderRadius:
                                                  //       BorderRadius
                                                  //           .circular(
                                                  //           2.0)),
                                                  //   fillColor: primaryColor,
                                                  //   child: Icon(
                                                  //     Icons.remove,
                                                  //     color: Colors.white,
                                                  //     size: 10.sp,
                                                  //   ),
                                                  // ),
                                                  SizedBox(
                                                    width: 2.w,
                                                    child: servicesubcontroller
                                                            .toString()
                                                            .isNotEmpty
                                                        ? Text(
                                                            numberofserviec
                                                                .toString(),
                                                            style: TextStyle(
                                                              color: whiteColor,
                                                              fontSize: 10.sp,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          )
                                                        : Container(),
                                                  ),
                                                  // RawMaterialButton(
                                                  //   constraints:
                                                  //   BoxConstraints.tightFor(
                                                  //       width: 6.w,
                                                  //       height: 3.h),
                                                  //   elevation: 6.0,
                                                  //   onPressed: () {
                                                  //     setState(() {
                                                  //       numberofserviec++;
                                                  //     });
                                                  //   },
                                                  //   shape:
                                                  //   RoundedRectangleBorder(
                                                  //       borderRadius:
                                                  //       BorderRadius
                                                  //           .circular(
                                                  //           2.0)),
                                                  //   fillColor: primaryColor,
                                                  //   child: Icon(
                                                  //     Icons.add,
                                                  //     color: Colors.white,
                                                  //     size: 10.sp,
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }

  getservicebycategory() {
    WebService()
        .getservice(category_id: selectedservice.toString())
        .then((value) {
      setState(() {
        _servicebycat = value;
        _isloading = false;
      });
    });
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
    //       builder: (context) => ScheduleAppointment(
    //           salon: _salon, categories: _categories, profile: API.USER)),
    // );
  }

  waitDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (contxet) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          backgroundColor: Colors.white.withOpacity(0.15),
          child: Container(
            height: 20.h,
            width: 30.w,
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
              alignment: WrapAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                      child: const SpinKitRing(
                        color: primaryColor,
                        lineWidth: 5,
                        size: 50.0,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                      child: Text(
                        Languages.of(context).pleasewait,
                        textAlign: TextAlign.center,
                        style: grey13RegularTextStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    Timer(
      const Duration(seconds: 3),
      () {
        currentIndex = 0;
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => ScheduleAppointment(
        //           salon: _salon, categories: _categories, profile: API.USER)),
        // );
      },
    );
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
