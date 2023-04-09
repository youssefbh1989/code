import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:salonat/models/usermodel.dart';
import 'package:salonat/pages/cart_screen.dart';
import 'package:salonat/pages/common/widgets/entity_card.dart';
import 'package:salonat/widget/slider_clinics.dart';
import 'package:sizer/sizer.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../All_entity.dart';
import '../../constants/constants.dart';
import '../../controller/home_controller.dart';
import '../../localisation/language/language.dart';
import '../../models/salonmodels.dart';
import '../../services/api.dart';
import '../../services/apiservice.dart';
import '../../services/data_repository.dart';
import '../common/screens/entity_details.dart';
import '../common/screens/entity_details_supplier.dart';
import '../common/screens/entitycategory.dart';
import '../search/serch_screen.dart';

class Home extends StatefulWidget {
  Home({Key key, this.profile, String token}) : super(key: key);
  final UserModel profile;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> _cats = List();

  double height;
  double width;
  bool _isloading = true;
  bool _isloadingmore = false;
  bool favorite = false;
  final TextEditingController _serchcontroller = TextEditingController();
  final _homeKey = Key('home');
  final _formKey = GlobalKey<FormState>();
  final _mailController = TextEditingController();
  final _passwdController = TextEditingController();
  bool _isRequesting = false;
  int page = 0;
  final scrollController = ScrollController();
  final _visibleFab = true.obs;

  final bool _accepted = true;
  List<SalonModel> _salons = [];

  @override
  void initState() {
    super.initState();
    _initFirebase();

    scrollController.addListener(_scrollListener);
  }

  void _initFirebase() async {
    await Get.find<HomeController>().getNotifications();

    //FlutterRingtonePlayer.play(fromAsset: 'assets/sounds/notif.mp3');
  }

  Future getsalon() async {
    WebService().getsalon(page: page, type: 'Salon').then((value) {
      if (mounted) {
        setState(() {
          _salons = _salons + value;
          _isloading = false;
        });
      }
    });
  }

  void didChangeDependencies() {
    super.didChangeDependencies();

    _cats.add({
      'title': 'Clinic',
      'titre': Languages.of(context).beautyclinics.toString()
    });
    _cats.add({
      'title': 'Salon',
      'titre': Languages.of(context).salonspa,
    });
    _cats.add({'title': 'Fitness', 'titre': Languages.of(context).fitness});
    _cats.add({'title': 'Artist', 'titre': Languages.of(context).makeupartist});
    _cats.add(
        {'title': 'Vendor', 'titre': Languages.of(context).beautySupplier});
  }

  @override
  void dispose() {
    _serchcontroller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        _isloadingmore = true;
      });
      print('Scroll called by youssef');

      page = page + 1;
      await getsalon();
      setState(() {
        _isloadingmore = false;
      });
    } else {
      print('Scroll called by mariem');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataReposotory>(context);

    return NotificationListener<UserScrollNotification>(
      onNotification: (notif) {
        if (notif.direction == ScrollDirection.forward) {
          _visibleFab.value = true;
        } else if (notif.direction == ScrollDirection.reverse) {
          _visibleFab.value = false;
        }
        return false;
      },
      child: VisibilityDetector(
        onVisibilityChanged: (info) {
          if (info.visibleFraction == 1.0) {
            setState(() {});
          }
        },
        key: _homeKey,
        child: RefreshIndicator(
          color: primaryColor,
          onRefresh: () async {
            _initFirebase();
          },
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 0.5.h, vertical: 1),
            children: [
              SizedBox(
                height: 6.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 1.2.h, vertical: 1),
                    child: Text(
                      Languages.of(context).labelSelectLanguage == 'English'
                          ? 'Hello  ${API.USER?.name ?? ''}'
                          : ' مرحبًا${API.USER?.name ?? ''}',
                      style: const TextStyle(
                          fontFamily: 'SFProDisplay-Bold',
                          fontSize: 18,
                          color: primaryColor),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (API.USER != null)
                        InkWell(
                          onTap: () => Get.to(() => const CartScreen()),
                          child: Align(
                            child: Badge(
                                label: Text(
                                  Hive.box('cart').length.toString(),
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontSize: API.isPhone ? 12.0 : 30.0),
                                ),

                                //showBadge: Hive.box('cart').isNotEmpty,
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: primaryColor,
                                  size: API.isPhone ? 30.0 : 60.0,
                                )),
                          ),
                        ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 1.4.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(13),
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
                            Icons.menu_outlined,
                            color: primaryColor,
                            size: API.isPhone ? 25.0 : 38.0,
                          )),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Expanded(
                        flex: 10,
                        child: Container(
                          height: API.isPhone ? 45.0 : 50.0,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(13),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 1),
                                color: blackColor.withOpacity(0.1),
                                spreadRadius: 1.5,
                                blurRadius: 1.5,
                              ),
                            ],
                          ),
                          child: TextFormField(
                            readOnly: true,
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchScreen())),
                            cursorColor: primaryColor,
                            style: black14MediumTextStyle,
                            decoration: InputDecoration(
                              hintText:
                                  '${Languages.of(context).search_hint} ...',
                              isDense: true,
                              hintStyle: TextStyle(
                                color: primaryColor,
                                fontSize: API.isPhone ? 15.0 : 25.0,
                                fontFamily: 'SFRProRegular',
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: primaryColor,
                                size: API.isPhone ? 25.0 : 40.0,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 1.h),
                child: categorielist(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 0.h),
                child: Banners(
                  slider: (dataProvider.sliders ?? []).isNotEmpty
                      ? dataProvider.sliders
                      : [],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.h, vertical: 2.w),
                        child: Text(
                          Languages.of(context).beautyclinics,
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: API.isPhone ? 20.0 : 30.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.h, vertical: 1.w),
                        child: InkWell(
                          onTap: () => {
                            Get.to(() => All_entity(
                                  type: 'Clinic',
                                  title: Languages.of(context).beautyclinics,
                                ))
                          },
                          child: Text(
                            Languages.of(context).more + ' >>',
                            style: TextStyle(
                                fontSize: API.isPhone ? 15.0 : 30.0,
                                color: primaryColor,
                                fontFamily: 'Calibri_bold'),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: API.isPhone ? 150.0 : 250.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // horizontal list of items
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: dataProvider.clinicsList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.h, vertical: 0.w),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(18),
                                onTap: () =>
                                    dataProvider.clinicsList[index].openClose !=
                                            'Closed'
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EntityDetailScreen(
                                                      entity: dataProvider
                                                          .clinicsList[index],
                                                      profile: widget.profile,
                                                      clinics_id: dataProvider
                                                          .clinicsList[index].id
                                                          .toString()),
                                            ),
                                          )
                                        : Container(),
                                child: EntityCard(
                                    entity: dataProvider.clinicsList[index]),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.h, vertical: 2.w),
                        child: Text(
                          Languages.of(context).salonspa,
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: API.isPhone ? 20.0 : 30.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.h, vertical: 1.w),
                        child: InkWell(
                          onTap: () => {
                            Get.to(() => All_entity(
                                  type: 'Salon',
                                  title: Languages.of(context).salonspa,
                                ))
                          },
                          child: Text(
                            Languages.of(context).more + ' >>',
                            style: TextStyle(
                                fontSize: API.isPhone ? 15.0 : 30.0,
                                color: primaryColor,
                                fontFamily: 'Calibri_bold'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: API.isPhone ? 150.0 : 250.0,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification notification) {
                        final currentPosition = notification.metrics.pixels;
                        final maxPosition =
                            notification.metrics.maxScrollExtent;
                        if (currentPosition >= maxPosition / 2) {
                          dataProvider.getsalonlist;
                        }
                        return true;
                      },
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        controller: scrollController,
                        itemCount: dataProvider.salonList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 1.h, vertical: 0.w),
                            child: InkWell(
                                borderRadius: BorderRadius.circular(18),
                                onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EntityDetailScreen(
                                          entity: dataProvider.salonList[index],
                                        ),
                                      ),
                                    ),
                                child: EntityCard(
                                  entity: dataProvider.salonList[index],
                                )),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),


              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.h, vertical: 1.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.h, vertical: 0.w),
                              child: Text(
                                Languages.of(context).fitness,
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: API.isPhone ? 20.0 : 30.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.h, vertical: 1.w),
                              child: InkWell(
                                onTap: () => {
                                  Get.to(() => All_entity(
                                        type: 'Fitness',
                                        title:
                                            Languages.of(context).makeupartist,
                                      ))
                                },
                                child: Text(
                                  Languages.of(context).more + ' >>',
                                  style: TextStyle(
                                      fontSize: API.isPhone ? 15.0 : 30.0,
                                      color: primaryColor,
                                      fontFamily: 'Calibri_bold'),
                                ),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: API.isPhone ? 150.0 : 250.0,
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification notification) {
                          final currentPosition = notification.metrics.pixels;
                          final maxPosition =
                              notification.metrics.maxScrollExtent;
                          if (currentPosition >= maxPosition / 2) {
                            dataProvider.getartists;
                          }
                          return true;
                        },
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: dataProvider.fitness.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.h, vertical: 0.w),
                              child: InkWell(
                                  onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EntityDetailScreen(
                                            entity: dataProvider.fitness[index],
                                          ),
                                        ),
                                      ),
                                  child: EntityCard(
                                    entity: dataProvider.fitness[index],
                                  )),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.h, vertical: 1.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.h, vertical: 0.w),
                              child: Text(
                                Languages.of(context).makeupartist,
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: API.isPhone ? 20.0 : 30.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.h, vertical: 1.w),
                              child: InkWell(
                                onTap: () => {
                                  Get.to(() => All_entity(
                                        type: 'Artist',
                                        title:
                                            Languages.of(context).makeupartist,
                                      ))
                                },
                                child: Text(
                                  Languages.of(context).more + ' >>',
                                  style: TextStyle(
                                      fontSize: API.isPhone ? 15.0 : 30.0,
                                      color: primaryColor,
                                      fontFamily: 'Calibri_bold'),
                                ),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: API.isPhone ? 150.0 : 250.0,
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification notification) {
                          final currentPosition = notification.metrics.pixels;
                          final maxPosition =
                              notification.metrics.maxScrollExtent;
                          if (currentPosition >= maxPosition / 2) {
                            dataProvider.getartists;
                          }
                          return true;
                        },
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: dataProvider.artist.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.h, vertical: 0.w),
                              child: InkWell(
                                  onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EntityDetailScreen(
                                            entity: dataProvider.artist[index],
                                          ),
                                        ),
                                      ),
                                  child: EntityCard(
                                    entity: dataProvider.artist[index],
                                  )),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.h, vertical: 0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.h, vertical: 2.w),
                              child: Text(
                                Languages.of(context).beautySupplier,
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: API.isPhone ? 20.0 : 30.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.h, vertical: 1.w),
                              child: InkWell(
                                onTap: () => {
                                  Get.to(() => All_entity(
                                        type: 'Vendor',
                                        title: Languages.of(context)
                                            .beautySupplier,
                                      ))
                                },
                                child: Text(
                                  Languages.of(context).more + ' >>',
                                  style: TextStyle(
                                      fontSize: API.isPhone ? 15.0 : 30.0,
                                      color: primaryColor,
                                      fontFamily: 'Calibri_bold'),
                                ),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: API.isPhone ? 150.0 : 250.0,
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification notification) {
                          final currentPosition = notification.metrics.pixels;
                          final maxPosition =
                              notification.metrics.maxScrollExtent;
                          if (currentPosition >= maxPosition / 2) {
                            dataProvider.getvendors;
                          }
                          return true;
                        },
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: dataProvider.vendorList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.h, vertical: 0.w),
                              child: InkWell(
                                  onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EntityDetailScreenSupplier(
                                            entity:
                                                dataProvider.vendorList[index],
                                          ),
                                        ),
                                      ),
                                  child: EntityCard(
                                    entity: dataProvider.vendorList[index],
                                  )),
                            );
                          },
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget categorielist() {
    final dataProvider = Provider.of<DataReposotory>(context, listen: false);
    return SizedBox(
        height: 4.h,
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dataProvider.categories.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => Entity_Category(
                          title: _cats[index]['title'],
                          titre: _cats[index]['titre'],
                          categories: dataProvider.categories[index],
                          categorie_id:
                              dataProvider.categories[index].id.toString()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: whiteColor),
                      /* height: API.isPhone ? 130.0 : 200.0,
                      width: API.isPhone ? 150.0 : 250.0,*/
                      child: Text(
                        Languages.of(context).labelSelectLanguage == 'English'
                            ? dataProvider.categories[index].name
                            : dataProvider.categories[index].nameAr,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: API.isPhone ? 15.0 : 30.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: API.isPhone ? 10.0 : 40.0),
                      margin: EdgeInsets.symmetric(
                          horizontal: API.isPhone ? 4.0 : 10.0),
                    ),
                  ),
                ],
              );
            }));
  }
}
