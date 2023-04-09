import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';


import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:salonat/models/artistmodel.dart';
import 'package:salonat/models/entity.dart';
import 'package:salonat/models/usermodel.dart';

import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../column/Columnbuilder.dart';
import '../../../constants/constants.dart';
import '../../../localisation/language/language.dart';
import '../../../models/salonmodels.dart';
import '../../../models/vendormodel.dart';
import '../../../servicelistcart/service_list.dart';
import '../../../services/api.dart';
import '../../../services/apiservice.dart';
import '../../../services/data_repository.dart';
import '../../../services/user.dart';
import '../../auth/signin.dart';



class EntityDetailScreenSupplier extends StatefulWidget {
  const EntityDetailScreenSupplier(
      {Key key, this.entity, this.profile, String clinics_id})
      : super(key: key);
  final EntityModel entity;
  final UserModel profile;

  @override
  State<EntityDetailScreenSupplier> createState() => _EntityDetailScreenSupplierState();
}

class _EntityDetailScreenSupplierState extends State<EntityDetailScreenSupplier> {
  int numberofserviec = 0;
  TextEditingController _serviceSubController = TextEditingController();
  Rx<EntityModel> _entity;
  final _scrollController = ScrollController();
  List<Map<String, dynamic>> _tabs = [];
  double _rating = 0;
  final TextEditingController _reviewController = TextEditingController();


  @override
  void initState() {
    //getcart();
    super.initState();
    _entity = Rx(widget.entity.clone());
    print('is issssss:   ${_entity.value.runtimeType}');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {

        _tabs = [
          {'title': Languages.of(context).about, 'widget': _aboutPage()},
          {'title': Languages.of(context).gallery, 'widget': _galleryPage()},
        ];

        if (_entity is! ArtistModel) {
          _tabs
            ..insert(1,
                {'title':Languages.of(context).product, 'widget': _categoryPage()})
            ..add({'title': Languages.of(context).review, 'widget': _reviewPage()});
        }


      });
    });

    WebService().getEntityById(entity: _entity.value).then((value) {
      if (mounted) {
        _entity.value = value;
        print('servicessss:    ${_entity.value.categories.length}');
      }
    });

/*    WebService().getcategory().then((value) {
      if (mounted) {
        setState(() {
          _servicebycat = value;
          _entity.value.categories = value;
          print(_servicebycat);
          _isloading = false;
        });
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundcolor,
        body: Stack(
          children: [ _nestedScrollView()],
        ));
  }

  Widget _nestedScrollView() {
    final isClosed = _entity.value.openClose == null
        ? null
        : _entity.value.openClose.toLowerCase() == 'closed';

    return DefaultTabController(
      length: _tabs.length,
      child: NestedScrollView(
          floatHeaderSlivers: true,
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverSafeArea(
                top: false,
                sliver: SliverAppBar(
                  //floating: true,
                  pinned: true,
                  primary: true,
                  backgroundColor:  primaryColor,
                  expandedHeight: API.isPhone ? 250.0 : 500.0,
                  iconTheme: const IconThemeData(
                    color: Colors.white, // <-- SEE HERE
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: false,
                    title: SafeArea(
                      child: Obx(() => RichText(
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                          text: TextSpan(
                            text: Languages.of(context).labelSelectLanguage ==
                                'English'
                                ? _entity.value.name
                                : _entity.value.nameAr,
                            style: TextStyle(
                                color: primaryColor,
                                fontFamily: 'Calibri_bold',
                                fontSize: API.isPhone ? 20.0 : 40.0),
                          ))),
                    ),
                    background: Stack(
                      children: [
                        Obx(() => Container(
                          foregroundDecoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black26,
                                    Colors.transparent,
                                    Colors.black26
                                  ],
                                  stops: [
                                    .0,
                                    .5,
                                    .9
                                  ])
                          ),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://salonat.qa/${_entity.value.cover}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                        Positioned(
                          right: 15,
                          top: 15,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(() => SafeArea(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      _entity.value.rating?.toString() ?? '0.0',
                                      style:  TextStyle(
                                          color: whiteColor,
                                          fontSize: API.isPhone ? 20.0 : 35.0,
                                          fontFamily: 'SFProDisplay-Bold'),
                                    ),
                                    widthSpace,
                                     Icon(
                                      Icons.star_rounded,
                                      color: yellowColor,
                                      size: API.isPhone ? 20.0 : 35.0,
                                    ),
                                  ],
                                ),
                              )),
                              if (isClosed != null)
                                Container(
                                  decoration: BoxDecoration(
                                    color: isClosed
                                        ? Colors.red.shade600
                                        : Colors.lightGreen,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 15),
                                  child: Text(
                                    (isClosed
                                        ? Languages.of(context).closed
                                        : Languages.of(context).open)
                                        .toUpperCase(),
                                    style:  TextStyle(
                                      fontFamily: 'SFProDisplay-Bold',
                                      color: Colors.white,
                                      fontSize: API.isPhone ? 15.0 : 20.0,
                                    ),
                                  ),
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ];
          },
          body: Column(
            children: [
              _tabBar(),
              Expanded(
                child: _tabs.isEmpty
                    ? Container()
                    : TabBarView(
                    children: _tabs
                        .map((e) => SingleChildScrollView(
                      child: e['widget'],
                    ))
                        .toList(growable: true)),
              ),
            ],
          )),
    );
  }

  Widget _bookAppointmentButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 4.w),
          child: GestureDetector(
            onTap: () => API.USER == null
                ? _loginAlert()
                : _serviceSubController.text.isEmpty
                ? _serviceEmpty()
                : _addToCart(),
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

  /* _getcart() {
    WebService().getcart(0).then((value) {
      if (mounted)
        setState(() {
          _carte = value;
        });
    });
  }

  _getdata() {
    WebService()
        .getfil(
        category_id: _selectedService.toString(),
        salon_id: _entity.value.id.toString(),
        max: '',
        min: '',
        search: '',
        type: '')
        .then((value) {
      if (mounted)
        setState(() {
          _subcategories = value;
          if (kDebugMode) {
            print(_subcategories);
          }
        });
    });
  }*/

  _tabBar() {
    if (_tabs.isEmpty) {
      return Container();
    }
    return TabBar(
        indicatorColor: Colors.white,
        isScrollable: !(_entity is ArtistModel),
        labelStyle: TextStyle(
            color: whiteColor, fontSize: 15.sp, fontFamily: 'SFRProRegular'),
        unselectedLabelStyle: TextStyle(
            color: Colors.white70,
            fontSize: 15.sp,
            fontFamily: 'SFRProRegular'),
        tabs: _tabs
            .map((e) => Tab(
          child: Text(
            e['title'],
            style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: API.isPhone ? 25.0 : 40.0
            ),
          ),
        ))
            .toList());
  }

  Widget _aboutPage() {
    //final dataProvider = Provider.of<DataReposotory>(context);
    return Obx(() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (_entity.value.about==null||_entity.value.about=='N/A')
              ? Container()
              : Padding(
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
                        style: TextStyle(
                            color:primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: API.isPhone ? 20.0 : 30.0

                        ),
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
                                ? _entity.value.about
                                : _entity.value.aboutAr),
                        expandText: Languages.of(context).showmore,
                        collapseText: Languages.of(context).showless,
                        maxLines: 5,
                        linkStyle: const TextStyle(fontWeight:FontWeight.bold,color:  primaryColor,),
                        style:  TextStyle(
                            color:  blackColor,
                            fontSize: API.isPhone ? 15.0 : 30.0
                        ),
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
                        style: const TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        launchUrl(Uri.parse(
                            'tel:${_entity.value.phone.toString() ?? _entity.value.phone.toString() ?? ''}'));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.h, vertical: 1.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/profilepic/phone.png',
                              height:    API.isPhone ? 20.0 : 30.0,
                              color: blackColor,
                            ),
                            SizedBox(
                              width: 0.w,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.h, vertical: 1.w),
                              child: Text(
                                _entity.value.phone.toString(),
                                style: greyRegularTextStyle,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    InkWell(
                      onTap: () {
                        launchUrl(
                            Uri.parse('mailto:${_entity.value.email.toString()}'));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.h, vertical: 1.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/profilepic/web.png',
                              height:  API.isPhone ? 20.0 : 30.0,
                              color: blackColor,

                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                                _entity.value.email.toString(),
                                style:greyRegularTextStyle
                            ),
                          ],
                        ),
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
            child: _entity.value.saturday_opening != null &&
                _entity.value.sunday_closing != null &&
                _entity.value.sunday_opening != null &&
                _entity.value.friday_opening != null &&
                _entity.value.thursday_closing != null &&
                _entity.value.wednesday_closing != null &&
                _entity.value.thursday_opening != null &&
                _entity.value.wednesday_opening != null &&
                _entity.value.tuesday_closing != null &&
                _entity.value.tuesday_opening != null &&
                _entity.value.monday_closing != null &&
                _entity.value.monday_opening != null
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
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    heightSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 1.h, vertical: 1.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${Languages.of(context).Monday} :',
                            style: greyRegularTextStyle,
                          ),
                          Row(
                            children: [
                              Text(
                                _entity.value.monday_opening,
                                style: black13RegularTextStyle,
                              ),
                              widthSpace,
                              Text(
                                _entity.value.monday_closing,
                                style: black13RegularTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 1.h, vertical: 1.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${Languages.of(context).Tuesday} :',
                            style: greyRegularTextStyle,
                          ),
                          Row(
                            children: [
                              Text(
                                _entity.value.tuesday_opening,
                                style: black13RegularTextStyle,
                              ),
                              widthSpace,
                              Text(
                                _entity.value.tuesday_closing,
                                style: black13RegularTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 1.h, vertical: 1.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${Languages.of(context).Wednesday} :',
                            style: greyRegularTextStyle,
                          ),
                          Row(
                            children: [
                              Text(
                                _entity.value.wednesday_opening,
                                style: black13RegularTextStyle,
                              ),
                              widthSpace,
                              Text(
                                _entity.value.wednesday_closing,
                                style: black13RegularTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 1.h, vertical: 1.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${Languages.of(context).Thursday} :',
                            style: greyRegularTextStyle,
                          ),
                          Row(
                            children: [
                              Text(
                                _entity.value.thursday_opening,
                                style: black13RegularTextStyle,
                              ),
                              widthSpace,
                              Text(
                                _entity.value.thursday_closing,
                                style: black13RegularTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 1.h, vertical: 1.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${Languages.of(context).Friday} :',
                            style: black13RegularTextStyle.copyWith(color: Colors.red),
                          ),
                          Text(
                            _entity.value.friday_opening,
                            style: black13RegularTextStyle.copyWith(
                                color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 1.h, vertical: 1.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${Languages.of(context).Saturday} :',
                            style: greyRegularTextStyle,
                          ),
                          Row(
                            children: [
                              Text(
                                _entity.value.saturday_opening,
                                style: black13RegularTextStyle,
                              ),
                              widthSpace,
                              Text(
                                _entity.value.saturday_closing,
                                style: black13RegularTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 1.h, vertical: 1.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${Languages.of(context).Sunday} :',
                            style: greyRegularTextStyle,
                          ),
                          Row(
                            children: [
                              Text(
                                _entity.value.sunday_opening,
                                style: black13RegularTextStyle,
                              ),
                              widthSpace,
                              Text(
                                _entity.value.sunday_closing,
                                style: black13RegularTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
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
          if (!(_entity is ArtistModel))
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.w),
                child: _entity.value.lng != 0
                    ? Container(
                  height:API.isPhone ? 130.0 : 200.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GoogleMap(
                        mapType: MapType.terrain,
                        zoomControlsEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(_entity.value.lat ?? 25.287215,
                              _entity.value.lng ?? 51.535910),
                          zoom: 14.4746,
                        ),
                        markers: _entity.value.lat != null && _entity.value.lat != .0
                            ? {
                          Marker(
                            position:
                            LatLng(_entity.value.lat, _entity.value.lng),
                            markerId: const MarkerId('pos'),
                          )
                        }
                            : (<Marker>{}),
                        onTap: openMaps),
                  ),
                )
                    : Container()),
        ],
      ),
    ));
  }

  Widget _categoryPage() {
    return Obx(() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
      child:  _entity.value.categories.isEmpty
          ? Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Center(
          child: Text('No Product availaible',
              style: TextStyle(color: primaryColor,
                  fontFamily: 'calibri',
                  fontWeight: FontWeight.bold)),
        ),
      )
          :Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColumnBuilder(
              itemCount: _entity.value.categories.length,
              itemBuilder: (context, index) {
                final item = _entity.value.categories[index];
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
                      decoration: const BoxDecoration(),
                      child: ListTile(
                        leading: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth: Get.width * .4,
                              minWidth: 5
                          ),
                          child: CachedNetworkImage(
                            imageUrl: 'https://salonat.qa/${item.image}' ?? '',
                            errorWidget: (_, uu_, uuu) => const Icon(
                                Icons.broken_image_outlined,
                                color: blackColor),
                            color: primaryColor,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ServiceList(
                                    entity: _entity.value,
                                    profile: widget.profile,
                                    salonId: _entity.value.id.toString(),
                                    categories:
                                    _entity.value.categories[index].id
                                        .toString(),
                                    categoryName:
                                    _entity.value.categories[index].name),
                              ));
                        },
                        trailing: Text('View',
                            style: TextStyle(
                                color:primaryColor,
                                fontFamily: 'Calibri',
                                fontSize: API.isPhone ? 15.0 : 30.0,fontWeight: FontWeight.bold)),
                        title: Text(
                            Languages.of(context).labelSelectLanguage ==
                                'English'
                                ? item.name
                                : item.nameAr,
                            style: TextStyle(
                                color: primaryColor,
                                fontFamily: 'Calibri',
                                fontSize: API.isPhone ? 15.0 : 30.0,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.clip),
                        subtitle: item.services.length == null
                            ? const Center()
                            : Text(item.services.length.toString(),
                          style: TextStyle(
                              fontSize: API.isPhone ? 10.0 : 15.0,
                              color: primaryColor,
                              fontWeight: FontWeight.bold
                          ),),
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
    ));
  }

  Widget _galleryPage() {
    //final dataProvider = Provider.of<DataReposotory>(context, listen: false);
    return Obx(() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
      child:  _entity.value.gallery.isEmpty
          ? Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Center(
          child: Text('No Photos availaible',
              style: TextStyle(color: primaryColor,
                  fontFamily: 'calibri',
                  fontWeight: FontWeight.bold)),
        ),
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StaggeredGridView.countBuilder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            staggeredTileBuilder: (_) => const StaggeredTile.count(1, 1),
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            itemCount: _entity.value.gallery.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => _openGallery(index),
                borderRadius: BorderRadius.circular(6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    imageUrl:
                    'https://salonat.qa/${_entity.value.gallery[index]}',
                    placeholder: (context, _) => _shimmer(),
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ));
  }

  Widget _reviewPage() {
    return Obx(() => Padding(
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
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.w),
                    child: Text(Languages.of(context).review,
                        style: TextStyle(
                            fontSize: API.isPhone ? 20.0 : 30.0,
                            color: primaryColor,
                            fontWeight: FontWeight.bold
                        )),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.w),
                    child: Text(
                        "${Languages.of(context).feeling_about_salon} ?",
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize:API.isPhone ? 20.0 : 30.0
                        )),
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
                          this._rating = rating;
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
                              color: blackColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextFormField(
                              controller: _reviewController,
                              cursorColor: primaryColor,
                              style: TextStyle(
                                  color: primaryColor
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 2.h),
                                hintText:
                                '${Languages.of(context).say_somthings}...',
                                hintStyle: grey13RegularTextHintStyle,
                                border: const UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1.h,
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: API.USER == null ? _loginAlert : _review,
                              child: Container(
                                  height: 6.h,
                                  decoration: BoxDecoration(
                                    color:  primaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                      child: Image.asset(
                                        Languages.of(context).labelSelectLanguage ==
                                            'English'
                                            ? ('assets/icons/review.png')
                                            : 'assets/specialists/Group 76.png',
                                      ))),
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
          _allReview(),
        ],
      ),
    ));
  }

  Widget _allReview() {
    //final dataProvider = Provider.of<DataReposotory>(context);
    return _entity.value.reviewedUsers.isNotEmpty
        ? Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.w),
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
          padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.w),
          child: ColumnBuilder(
            itemCount: _entity.value.reviewedUsers.length,
            itemBuilder: (context, index) {
              final item = _entity.value.reviewedUsers[index];
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                    vertical: 5, horizontal: 15),
                padding: const EdgeInsets.symmetric(
                    horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          item.userName,
                          style: const TextStyle(
                              color: primaryColor
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        RatingBar.builder(
                          initialRating:
                          double.tryParse(item.rating) ?? 1,
                          minRating: 1,
                          allowHalfRating: true,
                          itemSize: 13,
                          unratedColor: blackColor.withOpacity(.5),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (double value) {},
                        ),
                      ],
                    ),
                    heightSpace,
                    heightSpace,
                    Text(
                      item.review,
                      style: black13RegularTextStyle,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    )
        : Container();
  }

  void _loginAlert({String text}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: whiteColor,
          child: Container(

            width: 65.w,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10),
              /*     boxShadow: [
                BoxShadow(
                  color: blackColor.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 2,
                ),
              ],*/
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
                              color: primaryColor,
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
                                  color: primaryColor,
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
                                        color: whiteColor, fontSize: 15.sp),
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

  void _serviceEmpty({String text}) {
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
                          text ?? 'Your cart is empty',
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

  Future<void> _addToCart() async {
    final dataProvider = Provider.of<DataReposotory>(context, listen: false);
    setState(() {});

    setState(() {});

    final join = await WebService().addtocart(
        service_id: _serviceSubController.text.toString(), quantity: '1');
    setState(() {});

/*    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ScheduleAppointmentClinics(
              clinics: _entity.value,
             // categories: dataProvider.categories[0],
              profile: API.USER)),
    );*/
  }

  Future<void> _review() async {

    setState(() {});

    setState(() {});

    await UsersWebService().addreview(
        review: _reviewController.text,
        rating: _rating.toString(),
        salon_id: _entity.value.id.toString());

    _logoutDialog();
  }

  void _logoutDialog({String text}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.w),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor: whiteColor,
          child: Container(

            width: 65.w,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10),
              /*  boxShadow: [
                BoxShadow(
                  color: whiteColor,
                  spreadRadius: 2,
                  blurRadius: 2,
                ),
              ],*/
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
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold
                          ),
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
                                    Languages.of(context).ok,
                                    style: TextStyle(
                                        color: whiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp
                                    ),
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
        baseColor: Colors.white,
        highlightColor: Colors.grey);
  }

  void _openGallery(int index) => Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => GalleryWidget(
        photos: _entity.value.gallery.map((e) => 'https://salonat.qa/$e').toList(),
        index: index,
      )));

  void openMaps(LatLng ltn) async {
    final dataProvider = Provider.of<DataReposotory>(context, listen: false);
    final lat = dataProvider.clinicsbyid[0].lat != null &&
        dataProvider.clinicsbyid[0].lat != .0
        ? dataProvider.clinicsbyid[0].lat
        : 25.287215;
    final lng = dataProvider.clinicsbyid[0].lng != null &&
        dataProvider.clinicsbyid[0].lng != .0
        ? dataProvider.clinicsbyid[0].lng
        : 51.535910;
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunchUrl(Uri.parse(googleUrl)) == null) {
      throw 'Could not open the map.';
    } else {
      await launchUrl(Uri.parse(googleUrl));
    }
  }
}

class GalleryWidget extends StatefulWidget {
  final List<String> photos;
  final int index;

  const GalleryWidget({Key key, this.photos, this.index}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  final controller = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.jumpToPage(widget.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                itemCount: widget.photos.length,
                pageController: controller,
                loadingBuilder: (_, __) => _shimmer(),
                builder: (context, index) => PhotoViewGalleryPageOptions(
                  imageProvider: CachedNetworkImageProvider(widget.photos[index]),
                  initialScale: PhotoViewComputedScale.contained * 1,
                  minScale: PhotoViewComputedScale.contained * 1,
                  maxScale: 1.5,

                ),
              ),
              Positioned(
                  top: 50,
                  right: 25,
                  child: GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Icon(Icons.close,color: whiteColor,)))
            ],
          ),
        ));
  }

  Widget _shimmer() {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.center,
        children: [
          Shimmer.fromColors(
              baseColor: Colors.white12,
              highlightColor: Colors.white,
              child: Container(
                width: size.width,
                height: size.height * .3,
                color: Colors.black,
              )),
        ],
      ),
    );
  }
}
