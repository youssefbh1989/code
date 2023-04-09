import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salonat/constants/constants.dart';
import 'package:salonat/pages/common/screens/search_salon_home.dart';
import 'package:salonat/services/api.dart';
import 'package:sizer/sizer.dart';
import '../../../localisation/language/language.dart';
import '../../../models/salonmodels.dart';
import '../../../services/apiservice.dart';
import '../../filter/filter.dart';
import '../widgets/entity.dart';
import '../widgets/nearby.dart';
import 'entity_details.dart';

class Liste_entity extends StatefulWidget {
  const Liste_entity(
      {Key key,
      this.title,
      this.categorie_id,
      this.titre,
      this.minprice,
      this.maxprice,
      this.service,
      this.shortby,
      this.categorie,
      RangeValues Services,
      this.title_categories})
      : super(key: key);
  final String title;
  final String categorie_id;
  final String titre;
  final String title_categories;

  final String minprice;
  final String maxprice;
  final String service;
  final String categorie;
  final String shortby;
  final String athome = 'At Home';

  @override
  State<Liste_entity> createState() => _Liste_entityState();
}

class _Liste_entityState extends State<Liste_entity> {
  List<SalonModel> _salonsservicehome = [];
  List<SalonModel> _salonsservicesalons = [];
  List<SalonModel> _all = [];
  bool _isloading = true;

  final _searchTextController = TextEditingController();
  String query = '';

  TextEditingController _searchControllersalon = TextEditingController();
  TextEditingController _searchControllerhome = TextEditingController();
  int pagehome = 0;
  int pagesalon = 0;
  final scrollController = ScrollController();
  bool _isloadingmore = false;
  String athome='At Home';
  String atsalon='At Salon';

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    getall();
    getSalon();
    gethome();
  }

  getall() {
    WebService()
        .getall(
      category: widget.categorie_id.toString(),
      type: widget.title.toString(),
    )
        .then((value) {
      if (mounted) {
        setState(() {
          _all = value;
          print('youssef is all${_all}');
          print(_all.length);

          _isloading = false;
        });
      }
    });
  }

  gethome() {
    WebService()
        .getsalonbycategoryandtype(
            category: widget.categorie_id.toString(),
            type: widget.title.toString(),
            service_available: 'At Home',
            page: pagehome)
        .then((value) {
      if (mounted) {
        setState(() {
          _salonsservicehome = value;
          print('youssef is home${_salonsservicehome}');
          print(_salonsservicehome.length);

          _isloading = false;
        });
      }
    });
  }

  getSalon() {
    WebService()
        .getsalonbycategoryandtype(
            category: widget.categorie_id.toString(),
            type: widget.title.toString(),
            service_available: 'At Salon',
            page: pagesalon)
        .then((value) {
      if (mounted) {
        setState(() {
          _salonsservicesalons = _salonsservicesalons + value;

          print('youssef is salons${_salonsservicesalons}');
          print(_salonsservicesalons.length);

          _isloading = false;
        });
      }
    });
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        _isloadingmore = true;
      });
      print('Scroll called by youssef');

      pagesalon = pagesalon + 1;
      await getSalon();
      setState(() {
        _isloadingmore = false;
      });
    } else {
      print('Scroll called by mariem');
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.title == 'Salon'
        ? DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: backgroundcolor,
              appBar: AppBar(
                bottom:  TabBar(
                  indicatorColor: Colors.white,
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        ' Salon Service',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: API.isPhone ? 15.0 : 25.0),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Home Service',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                        fontSize: API.isPhone ? 15.0 : 25.0),
                      ),
                    ),
                  ],
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () {
                          Get.to(() => Nearby_entity(
                              title: widget.title,
                              category: widget.categorie_id));
                        },
                        child: Icon(
                          Icons.place,
                          color: Colors.white,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () {
                          Get.to(() => Filter());
                        },
                        child: Icon(
                          Icons.filter_alt_outlined,
                          color: Colors.white,
                        )),
                  )
                ],
                centerTitle: true,
                title: Text(widget.title_categories,
                style: TextStyle(
                   fontSize: API.isPhone ? 15.0 : 25.0
                ),),
                leading: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                backgroundColor: primaryColor,
              ),
              body: TabBarView(
                children: [
                  atthesalon(),
                  homeservice(),
                ],
              ),
            ),
          )
        : Scaffold(
            backgroundColor: backgroundcolor,
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        Get.to(() => Nearby_entity(
                            title: widget.title,
                            category: widget.categorie_id));
                      },
                      child: Icon(
                        Icons.place,
                        color: Colors.white,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        Get.to(() => Filter());
                      },
                      child: Icon(
                        Icons.filter_alt_outlined,
                        color: Colors.white,
                      )),
                )
              ],
              centerTitle: true,
              title: Text(widget.title_categories),
              leading: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )),
              backgroundColor: primaryColor,
            ),
            body: clinicsbeautyartist(),
          );
  }

  homeservice() {
    return _isloading
        ? Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          )
        :_salonsservicehome.isEmpty?Center(child:
            Text('No home service availaible',style: TextStyle(
              color: primaryColor,fontWeight: FontWeight.bold,fontSize: 10.sp
            ),),): Column(
            children: [
              _searchWidgethome(),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount:  _salonsservicehome.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.w),
                      child: InkWell(
                              borderRadius: BorderRadius.circular(18),
                              onTap: () =>
                              _salonsservicehome[index].openClose != 'Closed'
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EntityDetailScreen(
                                                    entity: _salonsservicehome[index],
                                                    clinics_id:
                                                    _salonsservicehome[index]
                                                            .id
                                                            .toString()),
                                          ),
                                        )
                                      : Container(),
                              child: Entity(entity: _salonsservicehome[index]),
                            )

                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    width: 2.w,
                  ),
                ),
              ),
            ],
          );
  }

  atthesalon() {
    return _isloading
        ? const Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          )
        :_salonsservicesalons.isEmpty?Center(child:
        Text('No salon service availaible',style: TextStyle(
            color: primaryColor,fontWeight: FontWeight.bold,fontSize: 10.sp
             ),),): Column(
            children: [
              _searchWidget(),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  itemCount: _isloadingmore ? _salonsservicesalons.length + 1 : _salonsservicesalons.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.w),
                      child: InkWell(
                              borderRadius: BorderRadius.circular(18),
                              onTap: () =>
                              _salonsservicesalons[index].openClose != 'Closed'
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EntityDetailScreen(
                                                    entity: _salonsservicesalons[index],
                                                    clinics_id:
                                                    _salonsservicesalons[index]
                                                            .id
                                                            .toString()),
                                          ),
                                        )
                                      : Container(),
                              child: Entity(entity: _salonsservicesalons[index]),
                            )

                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    width: 2.w,
                  ),
                ),
              ),
            ],
          );
  }

  clinicsbeautyartist() {
    return _isloading
        ? Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          )
        : Column(
            children: [
              _searchWidget(),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _all.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.h, vertical: 2.w),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(18),
                          onTap: () => _all[index].openClose != 'Closed'
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EntityDetailScreen(
                                        entity: _all[index],
                                        clinics_id: _all[index].id.toString()),
                                  ),
                                )
                              : Container(),
                          child: Entity(entity: _all[index]),
                        ));
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    width: 2.w,
                  ),
                ),
              ),
            ],
          );
  }

  Widget _searchWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0.sp, horizontal: 1.h),
      child: SizedBox(
        height: 35.sp,
        child: Padding(
          padding: EdgeInsets.all(1.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchControllersalon,
                  onSubmitted: (value) {
                    setState(() {});
                  },
                  cursorHeight: 26,
                  cursorColor: primaryColor,
                  enabled: true,
                  style: TextStyle(
                      color: primaryColor, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(

                      suffixIcon:
                      InkWell(onTap: _submit, child: const Icon(Icons.search,
                        color:  primaryColor,)),
                      border: InputBorder.none,
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: BorderSide(color: primaryColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor)),

                      suffixIconConstraints: BoxConstraints(
                          minWidth: 60, minHeight: 40, maxWidth: 60),
                      contentPadding:
                          EdgeInsets.only(top: 0, left: 2.w, right: 20),
                      hintStyle: GoogleFonts.cairo(
                          color: primaryColor,  fontSize: API.isPhone ? 15.0 : 35.0),
                      hintText: Languages.of(context).search),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchWidgethome() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0.sp, horizontal: 20),
      child: SizedBox(
        height: 35.sp,
        child: Padding(
          padding: EdgeInsets.all(1.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchControllerhome,
                  onSubmitted: (value) {
                    setState(() {



                    });
                  },
                  cursorHeight: 26,
                  cursorColor: primaryColor,
                  enabled: true,
                  style: TextStyle(
                      color: primaryColor, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      /*prefixIcon: Container(
                        child: Icon(
                          Icons.search,
                          color: primaryColor,
                        ),
                      ),*/
                      border: InputBorder.none,
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: BorderSide(color: primaryColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor)),
                      suffixIcon:
                      InkWell(onTap: _submithome, child: const Icon(Icons.search,
                        color:  primaryColor,)),
                      suffixIconConstraints: BoxConstraints(
                          minWidth: 60, minHeight: 40, maxWidth: 60),
                      contentPadding:
                          EdgeInsets.only(top: 0, left: 5.w, right: 20),
                      hintStyle: GoogleFonts.cairo(
                          color: primaryColor, fontSize: 10.sp),
                      hintText: Languages.of(context).search),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

   void _submit() {
    if (_searchControllersalon.text.isNotEmpty) {
      FocusScope.of(context).unfocus();
      Get.to(() => Search_Salon_Home(keyword: _searchControllersalon.text,text:atsalon));

    }
  }
  void _submithome() {
    if (_searchControllerhome.text.isNotEmpty) {
      FocusScope.of(context).unfocus();
      Get.to(() => Search_Salon_Home(keyword: _searchControllerhome.text,text:athome));

    }
  }
}
