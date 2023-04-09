import 'dart:async';


import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:salonat/models/entity.dart';
import 'package:salonat/models/salonmodels.dart';
import 'package:salonat/models/service.dart';
import 'package:salonat/models/usermodel.dart';
import 'package:salonat/pages/auth/signup.dart';
import 'package:salonat/pages/cart_screen.dart';
import 'package:salonat/services/api.dart';
import 'package:salonat/services/apiservice.dart';
import 'package:salonat/services/user.dart';
import 'package:salonat/widget/text_field.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';
import '../exception/unauthorized.dart';
import '../localisation/language/language.dart';
import '../models/service_filter.dart';

class ServiceList extends StatefulWidget {
  final String salonId;
  final String categories;
  final String categoryName;
  final String categoryNameAr;
  final UserModel profile;
  final EntityModel entity;
  final SalonModel salons;

  const ServiceList({
    Key key,
    this.salonId,
    this.categories,
    this.categoryName,
    this.profile,
    this.entity,
    this.salons, this.categoryNameAr,
  }) : super(key: key);

  @override
  State<ServiceList> createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  bool _isLoading = false;
  bool isSelected = false;
  List<ServiceFilterModel> _subcategories = [];
  final _formKey = GlobalKey<FormState>();
  TextEditingController serviceSubController = TextEditingController();
  final _mailController = TextEditingController();
  final _passwdController = TextEditingController();
  int selectedSubservice = 0;
  bool _isRequesting = false;
  final _cartBox = Hive.box('cart');
  final List<int> _isAdding = [];

  final bool _accepted = true;

  //bool _showAcceptError = false;

  void initState() {
    super.initState();
    _isLoading = true;
    getdata();
  }

  getdata() async {
    final values = await Future.wait([
      WebService().getfil(
          category_id: widget.categories,
          salon_id: widget.salonId.toString(),
          max: '',
          min: '',
          search: '',
          type: ''),
    ]);

    if (mounted) {
      setState(() {
        _subcategories = values[0];
        _isLoading = false;
        if (kDebugMode) {
          print(_subcategories);
        }
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
              size: API.isPhone ? 20.0 : 25.0
          ),
        ),
        title: Text(Languages.of(context).labelSelectLanguage=='English'?
        widget.categoryName:widget.categoryNameAr,
            style: TextStyle(
                color: whiteColor,
                fontSize: 15.sp,
                fontFamily: 'Calibri_bold')),
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : ListView.builder(
                itemCount: _subcategories.length,
                itemBuilder: (context, index) {
                  final inCart = _cartBox.values
                      .where(
                          (element) => element.id == _subcategories[index].id)
                      .isNotEmpty;
                  ServiceModel service;
                  if (inCart) {
                    service = _cartBox.values.firstWhere(
                        (element) => element.id == _subcategories[index].id);
                  }
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      onTap: () => _toggleAdd(_subcategories[index], inCart),
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
                        child: ListTile(
                          title: Text(Languages.of(context).labelSelectLanguage=='English'?
                            _subcategories[index].name: _subcategories[index].nameAr,
                            style: TextStyle(
                              color: primaryColor,fontWeight: FontWeight.bold,

                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: SizedBox(
                            width: MediaQuery.of(context).size.width * .4,
                            child: RichText(
                                text: TextSpan(children: [
                              if (_subcategories[index].duration != '0' &&
                                  _subcategories[index].duration != '00')
                                TextSpan(
                                    text:
                                        '${_subcategories[index].duration}    ',
                                    style: TextStyle(
                                      color: primaryColor,
                                    )),
                              TextSpan(
                                text:
                                    '${_subcategories[index].price.substring(0, _subcategories[index].price.indexOf('.'))} QAR',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontFamily: 'Calibri',
                                    fontSize: 10.sp),
                              ),
                            ])),
                          ),
                          leading: InkWell(
                            onTap: () => _toggleAdd(_subcategories[index], inCart),
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(color: primaryColor),
                                shape: BoxShape.circle,
                                color: inCart
                                    ? primaryColor
                                    : Colors.transparent,
                              ),
                              foregroundDecoration:
                                  _isAdding.contains(_subcategories[index].id)
                                      ? BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.withOpacity(.6),
                                        )
                                      : null,
                              child: inCart
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          ),
                          trailing: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      if (service != null &&
                                          service.qty > 1) {
                                        service.qty--;
                                        await service.save();
                                        setState(() {});
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: inCart &&
                                                (service != null &&
                                                    service.qty > 1)
                                            ? primaryColor
                                            : greyColor,
                                        shape: BoxShape.circle,
                                      ),
                                      padding: const EdgeInsets.all(5),
                                      child: const Icon(
                                        Icons.remove,
                                        size: 15,
                                        color: whiteColor,
                                      ),
                                    ),
                                  ),
                                  Text(service?.qty?.toString() ?? '1'),
                                  InkWell(
                                    onTap: () async {
                                      if (service != null) {
                                        service.qty++;
                                        await service.save();
                                        setState(() {});
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color:
                                            inCart ? primaryColor : greyColor,
                                        shape: BoxShape.circle,
                                      ),
                                      padding: const EdgeInsets.all(5),
                                      child: const Icon(
                                        Icons.add,
                                        size: 15,
                                        color: whiteColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                Languages.of(context).personne,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
      ),
    );
  }

  Future<void> _addtocart({ServiceFilterModel srvc, bool remove}) async {
    //final dataProvider = Provider.of<DataReposotory>(context, listen: false);

/*    if (_isAdding.contains(srvc)) {
      return;
    }*/

    //await WebService().addtocart(service_id: id.toString(), quantity: '1');
    if (!remove) {
      await _cartBox.add(ServiceModel(
          id: srvc.id,
          name: srvc.name,
          nameAr: srvc.nameAr,
          price: double.tryParse(srvc.price),
          entity: widget.entity?.toJson(),
      entityType: widget.entity?.runtimeType.toString()));
    } else {
      try {
        final service =
            _cartBox.values.firstWhere((element) => element.id == srvc.id);
        await _cartBox.deleteAt(_cartBox.values.toList().indexOf(service));
      } catch (_) {}
    }

    setState(() {});

    //_serviceAddToCart(added: service == null);
  }

  void _serviceAddToCart({bool added = true}) {
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
                          'Service is ${added ? 'added to' : 'removed from'} cart',
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

  void _loginalert({String text}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.w),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0))),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Wrap(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.h, vertical: 1.w),
                          child: Text(
                            text ?? Languages.of(context).login,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Calibri'),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            enabled: !_isRequesting,
                            keyboardType: TextInputType.emailAddress,
                            controller: _mailController,
                            style: TextStyle(
                                color: primaryColor,
                                fontFamily: 'Calibri',
                                fontSize: 15.sp),
                            textInputAction: TextInputAction.next,
                            validator: (txt) =>
                                txt.isEmpty
                                    ? Languages.of(context).email_val
                                    : null,
                            textDirection: TextDirection.ltr,
                            cursorColor:  primaryColor,
                            decoration: InputDecoration(

                              errorStyle:
                                  TextStyle(fontSize: 12.sp, color: primaryColor),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color:  primaryColor,
                                size: 20.sp,
                              ),
                              labelText: Languages.of(context).emailorpassword,
                              labelStyle: TextStyle(
                                color:  primaryColor
                              ),
                              fillColor: Colors.white,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 2.h),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color:  primaryColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color:  primaryColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color:  primaryColor),
                                  borderRadius: BorderRadius.circular(10.0)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: primaryColor)),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text_Field(
                              _passwdController,
                              Languages.of(context).password,
                              Languages.of(context).password_val,
                              _login,
                              Icon(
                                Icons.lock,
                                color:  primaryColor,
                                size: 20.sp,
                              ),
                              true),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.h),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            height: 5.h,
                            color: primaryColor,
                            mouseCursor: MouseCursor.defer,
                            textColor: Colors.white,
                            minWidth: double.infinity,
                            onPressed: () {
                              _login();
                              //Navigator.pop(context);
                            },
                            child: Text(
                              Languages.of(context).login,
                              style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 15.sp,
                                  fontFamily: 'Calibri',
                              fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${Languages.of(context).donthaveaccount} ?',
                              style: grey15MediumTextStyle,
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Signup()),
                              ),
                              child: Text(
                                Languages.of(context).signupnow,
                                style: TextStyle(
                                  color: whiteColor,
                                  fontFamily: 'Calibri',
                                  fontSize: 12.sp,
                                  decoration: TextDecoration.underline,
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
            ),
          ),
        );
      },
    );
  }

  Future<void> _login() async {
    setState(() {});

    //_showAcceptError = false;

    if (_formKey.currentState.validate() && _accepted) {
      setState(() {});
      _isRequesting = true;

      try {
        final user = await UsersWebService().login(
            mail: _mailController.text, password: _passwdController.text);

        API.USER = user;
        await Hive.box('global').put('user', user);

        waitDialog();
        setState(() {
          widget.profile == API.USER;
          Navigator.pop(context);
        });
      } on UnauthorizedException {
        setState(() {
          _isRequesting = false;
        });
      } on DioError catch (_) {
      } finally {
        setState(() {
          _isRequesting = false;
        });
      }
    } else if (!_accepted) {
      setState(() {
        //_showAcceptError = true;
      });
    }
  }

  waitDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (contxet) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 1.h),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          backgroundColor: Colors.white.withOpacity(0.15),
          child: Container(
            height: 20.h,
            width: 30.w,
            decoration: BoxDecoration(
              color: Colors.white,
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
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: SpinKitRing(
                        color: primaryColor,
                        lineWidth: 5,
                        size: 50.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        Languages.of(context).pleasewait,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold
                        ),
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
      const Duration(seconds: 5),
      () {
        Navigator.pop(context);
        //
        // widget.profile==API.USER;
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: ((context) =>  Clinics_Detail())));
      },
    );
  }

  void _toggleAdd(ServiceFilterModel service, bool inCart) {
    API.USER == null
        ? _loginalert()
        : _addtocart(srvc: service, remove: inCart);
  }
}
