
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:salonat/localisation/language/language.dart';
import 'package:salonat/models/salonmodels.dart';
import 'package:salonat/models/usermodel.dart';
import 'package:salonat/pages/cart_screen.dart';
import 'package:salonat/pages/common/screens/entity_details.dart';
import 'package:salonat/services/api.dart';
import 'package:salonat/services/apiservice.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants.dart';
import '../../models/positionmodel.dart';
import '../../services/data_repository.dart';
import '../filter/filter.dart';
import 'nearby_map_card.dart';

class Nearby extends StatefulWidget {
  const Nearby({
    Key key,
    lat,
    String token,
    UserModel profile,
  }) : super(key: key);

  @override
  _NearbyState createState() => _NearbyState();
}

class _NearbyState extends State<Nearby> {
  PositionModel _position;
  final TextEditingController _searchController = TextEditingController();
  double _height;
  double width;
  bool mapView = false;
  String query = '';
  bool _isloading = true;
  GoogleMapController _controller;
  PageController _pageController;
  Set<Marker> allMarkers = {};
  int prevPage;
  BitmapDescriptor locatoinIcon;
  BitmapDescriptor location;
  List<SalonModel> _salons = [];
  List<SalonModel> _salonsSearch = [];
  LocationData mycurrentLocation;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    _initData();
    getsalon();
    getlistsalon();

    getIcon();
    getIconposition();

    _pageController = PageController(initialPage: 0, viewportFraction: .8)
      ..addListener(_onScroll);
  }

  void getlistsalon() async {
    final dataProvider = Provider.of<DataReposotory>(context, listen: false);
    await dataProvider.getsalonlist();
    setState(() {
      Set<Marker> tMarkers = <Marker>{};

      for (var element in dataProvider.salonList) {
        Marker marker = Marker(
          markerId: MarkerId('location${element.id}'),
          draggable: false,
          infoWindow: InfoWindow(title: element.name, snippet: element.address),
          position: LatLng(element.lat, element.lng),
          icon: locatoinIcon,
        );
        tMarkers.add(marker);
      }
      setState(() {
        allMarkers = tMarkers;
      });
    });
  }

  getCurrentLocation() async {
    final location = Location();
    mycurrentLocation = await location.getLocation();
    if (mounted) {
      setState(() {
        _position = PositionModel(
            lat: mycurrentLocation.latitude, lng: mycurrentLocation.longitude);
        if (kDebugMode) {
          print('_position ${_position.toJson()}');
        }
      });
    }
  }

  getIcon() async {
    var icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(30, 30)),
      'assets/new/location.png',
    );
    setState(() {
      locatoinIcon = icon;
    });
  }

  getIconposition() async {
    var icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(15, 15)),
      'assets/icons/current_location_marker.png',
    );
    setState(() {
      location = icon;
    });
  }

  _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      moveCamera();
    }
  }

  _searchsalons() {
    final dataProvider = Provider.of<DataReposotory>(context, listen: false);
    _salonsSearch.clear();
    setState(() {
      _salonsSearch = dataProvider.salonList.where((salon) {
        final titleLower = salon.name.toLowerCase();

        return titleLower.contains(query.toLowerCase());
      }).toList();
    });
  }

  getData() async {
    final futures = await Future.wait([WebService().getsalon()]);
  }

  getsalon() {}

  void _initData() {
    if (_salons != null) {
      getCurrentLocation();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _salons;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (mapView) {
          setState(() {
            mapView = false;
            return false;
          });
        }
        return true;
      },
      child: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            "assets/new/back.png",
            fit: BoxFit.cover,
          )),
          Scaffold(
              backgroundColor: Colors.transparent,
              floatingActionButton: mapView ? null : FloatingActionButton(onPressed: () {
                setState(() {
                  mapView = true;
                });
              },
                  backgroundColor: primaryColor,
                  child: Icon(Icons.gps_fixed, color: Colors.white)
              ),
              extendBodyBehindAppBar: mapView,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: !mapView ? Colors.transparent : Colors.white54,
                iconTheme:
                    IconThemeData(color: mapView ? blackColor : whiteColor),
                leading: IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 15.sp,
                  ),
                ),
                actions: [
                  if (API.USER != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: InkWell(
                        onTap: () => Get.to(() => const CartScreen()),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Badge(
                              label: Text(
                                Hive.box('cart').length.toString(),
                                style: TextStyle(color: whiteColor, fontSize: 13),
                              ),
                              padding: EdgeInsets.all(5.0),
                              //showBadge: Hive.box('cart').isNotEmpty,
                              child: const Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              )),
                        ),
                      ),
                    )
                ],
              ),
              body: mapView ? salonMap() : salonsList()),
        ],
      ),
    );
  }

  search() {
    return Languages.of(context).labelSelectLanguage == 'English'
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.w),
            child: Row(
              children: [
                Expanded(
                    flex: 6,
                    child: Container(
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFCDA574),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            bottomLeft: Radius.circular(6)),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 2),
                            color: blackColor.withOpacity(0.20),
                            spreadRadius: 1.5,
                            blurRadius: 1.5,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _searchController,
                        cursorColor: primaryColor,
                        style: const TextStyle(
                            color: blackColor,
                            fontSize: 15,
                            fontFamily: 'SFRProRegular'),
                        decoration: InputDecoration(
                          hintText: Languages.of(context).search,
                          fillColor: Colors.white,
                          hintStyle: const TextStyle(
                              color: whiteColor,
                              fontSize: 15,
                              fontFamily: 'SFRProRegular'),
                          prefixIcon: Icon(
                            Icons.search,
                            color: whiteColor,
                            size: 15.sp,
                          ),
                          border: const UnderlineInputBorder(
                              borderSide: BorderSide.none),
                          suffixIcon: query.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _salonsSearch.clear();
                                      query = '';
                                      _searchController.text = '';
                                    });
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: whiteColor,
                                    size: 15.sp,
                                  )
                                  //),
                                  )
                              : Container(),
                          suffixIconConstraints: BoxConstraints(
                              minWidth: 1.w, minHeight: 4.h, maxWidth: 10.w),
                        ),
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: MaterialButton(
                      onPressed: () {
                        query = _searchController.text;
                        _searchsalons();
                      },
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(6),
                              bottomRight: Radius.circular(6))),
                      height: 5.h,
                      color: whiteColor.withOpacity(0.9),
                      child: Text(
                        'Search',
                        style: TextStyle(
                            color: blackColor.withOpacity(0.5),
                            fontSize: 10.sp),
                      ),
                    )),
                SizedBox(
                  width: 3.w,
                ),
                Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Filter()),
                      ),
                      child: Container(
                          height: 5.h,
                          width: 10.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFFCDA574),
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
                          child: Icon(
                            Icons.filter_alt,
                            color: whiteColor,
                            size: 25.sp,
                          )),
                    )),
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.w),
            child: Row(
              children: [
                Expanded(
                    flex: 6,
                    child: Container(
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFCDA574),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(6),
                            bottomRight: Radius.circular(6)),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 2),
                            color: blackColor.withOpacity(0.20),
                            spreadRadius: 1.5,
                            blurRadius: 1.5,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _searchController,
                        cursorColor: primaryColor,
                        style: TextStyle(color: whiteColor, fontSize: 10.sp),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 1.h, vertical: 1.w),
                          hintText: Languages.of(context).search_hint,
                          fillColor: Colors.white,
                          hintStyle:
                              TextStyle(color: whiteColor, fontSize: 10.sp),
                          prefixIcon: Icon(
                            Icons.search,
                            color: whiteColor,
                            size: 15.sp,
                          ),
                          border: const UnderlineInputBorder(
                              borderSide: BorderSide.none),
                          suffixIcon: query.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _salonsSearch.clear();
                                      query = '';
                                      _searchController.text = '';
                                    });
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: whiteColor,
                                    size: 15.sp,
                                  )
                                  //),
                                  )
                              : Container(),
                          suffixIconConstraints: BoxConstraints(
                              minWidth: 1.w, minHeight: 4.h, maxWidth: 10.w),
                        ),
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: MaterialButton(
                      onPressed: () {
                        query = _searchController.text;
                        _searchsalons();
                      },
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6),
                              bottomLeft: Radius.circular(6))),
                      height: 5.h,
                      color: whiteColor.withOpacity(0.9),
                      child: Text(
                        Languages.of(context).search_hint,
                        style: TextStyle(
                            color: blackColor.withOpacity(0.5),
                            fontSize: 10.sp),
                      ),
                    )),
                SizedBox(
                  width: 1.w,
                ),
                Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Filter()),
                      ),
                      child: Container(
                          height: 5.h,
                          width: 10.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFFCDA574),
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
                          child: Icon(
                            Icons.filter_alt,
                            color: whiteColor,
                            size: 25.sp,
                          )),
                    )),
              ],
            ),
          );
  }

  salonsList() {
    return Column(
      children: [
        SizedBox(
          height: 0.h,
        ),
        search(),
        salons(),
      ],
    );
  }

  salons() {
    final dataProvider = Provider.of<DataReposotory>(context, listen: false);
    return Expanded(
        child: query.isEmpty && _salonsSearch.isEmpty
            ? NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
                  final currentPosition = notification.metrics.pixels;
                  final maxPosition = notification.metrics.maxScrollExtent;
                  if (currentPosition >= maxPosition / 2) {
                    dataProvider.getsalonlist;
                  }
                  return true;
                },
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(8.0),
                  itemCount: dataProvider.salonList.length,
                  itemBuilder: (context, index) {
                    final item = dataProvider.salonList[index];
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0.h, vertical: 1.w),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.h, vertical: 0.5.w),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EntityDetailScreen(
                                  //categorie: _service_filter[index].id,
                                  entity: item,
                                  //salons: _salons[index],
                                ),
                              ),
                            ),
                            child: Container(
                              //height: 17.h,
                              width: 25.w,
                              decoration: BoxDecoration(
                                color: Colors.white10.withOpacity(0.80),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: ClipRRect(
                                      borderRadius: Languages.of(context)
                                                  .labelSelectLanguage ==
                                              'English'
                                          ? const BorderRadius.horizontal(
                                              left: Radius.circular(10))
                                          : const BorderRadius.horizontal(
                                              right: Radius.circular(10)),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'http://salonat.qa/' + item.image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 1.5.w),
                                                child: Text(
                                                    Languages.of(context)
                                                                .labelSelectLanguage ==
                                                            'English'
                                                        ? item.name
                                                        : item.nameAr,
                                                    style: TextStyle(
                                                        color: blackColor,
                                                        fontSize: 13.sp,
                                                        fontFamily:
                                                            'Calibri_bold'),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          if (item.address != null) ...[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Icon(Icons.place,
                                                    color: blackColor,
                                                    size: 17),
                                                Flexible(
                                                  child: Text(
                                                    Languages.of(context)
                                                                .labelSelectLanguage ==
                                                            'English'
                                                        ? item.address
                                                        : item.address,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: blackColor,
                                                        fontFamily: 'Calibri'),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.fade,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 1.h),
                                          ],
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star_rounded,
                                                color: yellowColor,
                                                size: 17,
                                              ),
                                              widthSpace,
                                              Text(
                                                dataProvider.vendorList == null
                                                    ? const Center()
                                                    : '${item.rating} '
                                                            '${item.totalUserRated} '
                                                            '' +
                                                        Languages.of(context)
                                                            .Review,
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontFamily: 'Calibri',
                                                    color: blackColor),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                itemCount: _salonsSearch.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EntityDetailScreen(
                            entity: _salonsSearch[index],
                          ),
                        ),
                      ),
                      child: Container(
                        height: 16.h,
                        width: 25.w,
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: _height,
                                decoration: BoxDecoration(
                                  borderRadius: Languages.of(context)
                                              .labelSelectLanguage ==
                                          'English'
                                      ? const BorderRadius.only(
                                          bottomLeft: Radius.circular(6),
                                          topLeft: Radius.circular(6))
                                      : const BorderRadius.only(
                                          bottomRight: Radius.circular(6),
                                          topRight: Radius.circular(6)),
                                  image: DecorationImage(
                                    image: NetworkImage('http://salonat.qa/' +
                                        _salonsSearch[index].image),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4.w,
                                  vertical: 1.h,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            Languages.of(context)
                                                        .labelSelectLanguage ==
                                                    'English'
                                                ? _salonsSearch[index].name
                                                : _salonsSearch[index].nameAr,
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontFamily: 'Calibri_bold',
                                                color: blackColor),
                                            maxLines: 1,
                                            overflow: TextOverflow.clip),
                                      ],
                                    ),
                                    SizedBox(height: 0.h),
                                    Text(
                                      _salonsSearch[index].address == null
                                          ? ''
                                          : Languages.of(context)
                                                      .labelSelectLanguage ==
                                                  'English'
                                              ? _salonsSearch[index].address
                                              : _salonsSearch[index].addressAr,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontFamily: 'Calibri',
                                          color: blackColor),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          color: yellowColor,
                                          size: 12.sp,
                                        ),
                                        Text(
                                          _salonsSearch == null
                                              ? const Center()
                                              : '${_salonsSearch[index].rating} '
                                                      '(${_salonsSearch[index].totalUserRated})' +
                                                  Languages.of(context).Review,
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontFamily: 'Calibri',
                                              color: blackColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ));
  }

  clinics() {
    return Expanded(
        child: _isloading
            ? const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                  color: primaryColor,
                ),
              )
            : query.isEmpty && _salonsSearch.isEmpty
                ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(8.0),
                    itemCount: _salons.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.h, vertical: 1.w),
                        child: InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EntityDetailScreen(
                                entity: _salons[index],
                              ),
                            ),
                          ),
                          child: Container(
                            height: 16.h,
                            width: 25.w,
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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: _height,
                                    decoration: BoxDecoration(
                                      borderRadius: Languages.of(context)
                                                  .labelSelectLanguage ==
                                              'English'
                                          ? const BorderRadius.only(
                                              bottomLeft: Radius.circular(6),
                                              topLeft: Radius.circular(6))
                                          : const BorderRadius.only(
                                              bottomRight: Radius.circular(6),
                                              topRight: Radius.circular(6)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'http://salonat.qa/' +
                                                _salons[index].image),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4.w,
                                      vertical: 1.h,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                Languages.of(context)
                                                            .labelSelectLanguage ==
                                                        'English'
                                                    ? _salons[index].name
                                                    : _salons[index].nameAr,
                                                style: TextStyle(
                                                    color: blackColor,
                                                    fontSize: 15.sp,
                                                    fontFamily: 'Calibri_bold'),
                                                maxLines: 1,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ],
                                        ),
                                        Text(
                                          _salons == null
                                              ? const Center()
                                              : Languages.of(context)
                                                          .labelSelectLanguage ==
                                                      'English'
                                                  ? _salons[index].address
                                                  : _salons[index].addressAr,
                                          style: TextStyle(
                                              color: blackColor,
                                              fontFamily: 'Calibri',
                                              fontSize: 12.sp),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star_rounded,
                                              color: yellowColor,
                                              size: 20.sp,
                                            ),
                                            widthSpace,
                                            Text(
                                              _salons == null
                                                  ? const Center()
                                                  : '${_salons[index].rating} '
                                                          '${_salons[index].totalUserRated} '
                                                          '' +
                                                      Languages.of(context)
                                                          .Review,
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontFamily: 'Calibri',
                                                  color: blackColor),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: _salonsSearch.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.h, vertical: 1.w),
                        child: InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EntityDetailScreen(
                                entity: _salonsSearch[index],
                              ),
                            ),
                          ),
                          child: Container(
                            height: 16.h,
                            width: 25.w,
                            decoration: BoxDecoration(
                              color: Colors.white10.withOpacity(0.20),
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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: _height,
                                    decoration: BoxDecoration(
                                      borderRadius: Languages.of(context)
                                                  .labelSelectLanguage ==
                                              'English'
                                          ? const BorderRadius.only(
                                              bottomLeft: Radius.circular(6),
                                              topLeft: Radius.circular(6))
                                          : const BorderRadius.only(
                                              bottomRight: Radius.circular(6),
                                              topRight: Radius.circular(6)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'http://salonat.qa/' +
                                                _salonsSearch[index].image),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4.w,
                                      vertical: 2.h,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                Languages.of(context)
                                                            .labelSelectLanguage ==
                                                        'English'
                                                    ? _salonsSearch[index].name
                                                    : _salonsSearch[index]
                                                        .nameAr,
                                                style: black15SemiBoldTextStyle,
                                                maxLines: 1,
                                                overflow: TextOverflow.clip),
                                          ],
                                        ),
                                        SizedBox(height: 1.h),
                                        Text(
                                          _salonsSearch == null
                                              ? const Center()
                                              : Languages.of(context)
                                                          .labelSelectLanguage ==
                                                      'English'
                                                  ? _salonsSearch[index].address
                                                  : _salonsSearch[index]
                                                      .addressAr,
                                          style: grey12TextStyle,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star_rounded,
                                              color: yellowColor,
                                              size: 12.sp,
                                            ),
                                            Text(
                                              _salonsSearch == null
                                                  ? const Center()
                                                  : '${_salonsSearch[index].rating} '
                                                          '(${_salonsSearch[index].totalUserRated})' +
                                                      Languages.of(context)
                                                          .Review,
                                              style: grey12TextStyle,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ));
  }

  salonMap() {
    return Stack(
      children: [
        if (_position != null) googleMap(),
        salonsDetails(),
      ],
    );
  }

  googleMap() {
    return GoogleMap(
      markers: allMarkers,
      initialCameraPosition: CameraPosition(
        target: LatLng(_position.lat, _position.lng),
        zoom: 13,
      ),
      zoomControlsEnabled: false,
      zoomGesturesEnabled: true,
      minMaxZoomPreference: const MinMaxZoomPreference(10, 15),
      onMapCreated: mapCreated,
    );
  }

  mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
    allMarkers.add(
      Marker(
        markerId: const MarkerId('location'),
        draggable: false,
        infoWindow: InfoWindow(title: 'Your location'),
        position: LatLng(_position.lat, _position.lng),
        icon: location,
      ),
    );
  }

  moveCamera() {
    final dataProvider = Provider.of<DataReposotory>(context, listen: false);
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
              dataProvider.salonList[_pageController.page.toInt()].lat,
              dataProvider.salonList[_pageController.page.toInt()].lng),
          zoom: 14.0,
          bearing: 45.0,
          tilt: 45.0,
        ),
      ),
    );
  }

  salonsDetails() {
    _height = 18.h;
    final dataProvider = Provider.of<DataReposotory>(context, listen: false);
    return dataProvider.salonList.isEmpty
        ? const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(primaryColor),
            ),
          )
        : Positioned(
            bottom: 12.h,
            child: SizedBox(
              height: 18.h,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                controller: _pageController,
                itemCount: dataProvider.salonList.length,
                itemBuilder: (context, index) {
                  return nearbySalonsList(index);
                },
              ),
            ),
          );
  }

  nearbySalonsList(index) {
    final isEn = Languages.of(context).labelSelectLanguage == 'English';
    final dataProvider = Provider.of<DataReposotory>(context, listen: false);
    final item = dataProvider.salonList[index];
    return Padding(
      padding: EdgeInsets.only(left: isEn ? 0 : 8.0, right: isEn ? 8.0 : 0),
      child: NearbyMapCard(entity: item),
    );
  }
}
