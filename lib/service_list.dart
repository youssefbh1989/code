import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:salonat/models/usermodel.dart';
import 'package:salonat/pages/auth/signup.dart';
import 'package:salonat/pages/bottom_bar.dart';
import 'package:salonat/services/api.dart';
import 'package:salonat/services/apiservice.dart';
import 'package:salonat/services/data_repository.dart';
import 'package:salonat/services/user.dart';
import 'package:salonat/widget/text_field.dart';
import 'package:sizer/sizer.dart';
import 'constants/constants.dart';
import 'exception/unauthorized.dart';
import 'localisation/language/language.dart';
import 'models/service_filter.dart';

class Service_list extends StatefulWidget {
  final String salonid;
  final String categories;
  final String categorie_name;
  final UserModel profile;
  const Service_list(
      {Key key,
      this.salonid,
      this.categories,
      this.categorie_name,
      this.profile})
      : super(key: key);

  @override
  State<Service_list> createState() => _Service_listState();
}

class _Service_listState extends State<Service_list> {
  bool _isloading = false;
  bool isSelected = false;
  List<ServiceFilterModel> _subcategories = [];
  final _formKey = GlobalKey<FormState>();
  TextEditingController servicesubcontroller = TextEditingController();
  final _mailController = TextEditingController();
  final _passwdController = TextEditingController();
  int selectedsubservice = 0;
  bool _isRequesting = false;

  final bool _accepted = true;
  bool _showAcceptError = false;

  void initState() {
    _isloading = true;
    getdata();
    super.initState();
  }

  getdata() {
    WebService()
        .getfil(
            category_id: widget.categories,
            salon_id: widget.salonid.toString(),
            max: '',
            min: '',
            search: '',
            type: '')
        .then((value) {
      if (mounted)
        setState(() {
          _subcategories = value;
          _isloading = false;
          if (kDebugMode) {
            print(_subcategories);
          }
          _isloading = false;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      extendBodyBehindAppBar: true,
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
        title: Text(widget.categorie_name,
            style: TextStyle(
                color: whiteColor,
                fontSize: 15.sp,
                fontFamily: 'Calibri_bold')),

      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/new/back.png"), fit: BoxFit.fill),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
          child: _isloading
              ? Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                )
              : ListView.builder(
                  itemCount: _subcategories.length,
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
                        child: ListTile(
                            title: Text(
                              _subcategories[index].name,
                              style: TextStyle(
                                  color: blackColor,
                                  fontFamily: 'Calibri',
                                  fontSize: 12.sp),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: _subcategories[index].duration == '0' ||
                                    _subcategories[index].duration == '00'
                                ? Text('')
                                : Text(_subcategories[index].duration + ' Min'),
                            trailing: Text(
                              '${_subcategories[index].price.toString()} QAR',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontFamily: 'Calibri',
                                  fontSize: 10.sp),
                            ),
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      API.USER==null
                                          ? _loginalert()
                                          : setState(() {
                                              selectedsubservice = index;
                                              selectedsubservice =
                                                  _subcategories[index].id;
                                              servicesubcontroller.text =
                                                  selectedsubservice.toString();
                                              _addtocart();

                                            });
                                    },
                                    child: selectedsubservice ==
                                        _subcategories[index].id?Icon(
                                      Icons.add,
                                      color: primaryColor,
                                    ):Icon(
                                  Icons.add,
                                  color: greyColor,
                                )),
                              ],
                            )),
                      ),
                    );
                  }),
        ),
      ),
    );
  }

  Future<void> _addtocart() async {
    final dataProvider = Provider.of<DataReposotory>(context, listen: false);
    setState(() {});

    setState(() {});

    final join = await WebService().addtocart(
        service_id: servicesubcontroller.text.toString(), quantity: '1');
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
                              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomBar(),)),
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
          insetPadding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0))),
          backgroundColor: Colors.white10.withOpacity(0.5),
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
                                color: whiteColor,
                                fontFamily: 'Calibri',
                                fontSize: 15.sp),
                            textInputAction: TextInputAction.next,
                            validator: (txt) =>
                                txt.isEmpty || !txt.contains('@')
                                    ? Languages.of(context).email_val
                                    : null,
                            textDirection: TextDirection.ltr,
                            cursorColor: primaryColor,
                            decoration: InputDecoration(
                              errorStyle:
                                  TextStyle(fontSize: 12.sp, color: whiteColor),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: whiteColor,
                                size: 20.sp,
                              ),
                              labelText: Languages.of(context).emailorpassword,
                              labelStyle: grey16SemiBoldTextStyle,
                              fillColor: Colors.white,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 2.h),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10.0)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
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
                                color: whiteColor,
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
                            color: whiteColor,
                            mouseCursor: MouseCursor.defer,
                            textColor: Colors.white,
                            minWidth: double.infinity,
                            onPressed: () {
                              _login();
                              Navigator.pop(context);
                            },
                            child: Text(
                              Languages.of(context).login,
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 15.sp,
                                  fontFamily: 'Calibri'),
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
                              Languages.of(context).donthaveaccount + ' ?',
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
                        // Padding(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: 1.h, vertical: 1.w),
                        //   child: Row(
                        //     children: [
                        //       Expanded(
                        //           child: MaterialButton(
                        //             shape: RoundedRectangleBorder(
                        //                 borderRadius: BorderRadius.circular(25)),
                        //             height: 5.h,
                        //             color: whiteColor,
                        //             mouseCursor: MouseCursor.defer,
                        //             textColor: Colors.white,
                        //             minWidth: double.infinity,
                        //             onPressed: () => Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                     builder: ((context) => const Signin()))),
                        //             child: Text(
                        //               Languages.of(context).ok,
                        //               style: TextStyle(
                        //                   color: primaryColor, fontSize: 15.sp),
                        //             ),
                        //           )
                        //       )
                        //     ],
                        //   ),
                        // ),
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

    _showAcceptError = false;

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
          widget.profile==API.USER;
        });
      } on UnauthorizedException {
        setState(() {
          _isRequesting = false;
        });
      } on DioError catch (e) {
      } finally {
        setState(() {
          _isRequesting = false;
        });
      }
    } else if (!_accepted) {
      setState(() {
        _showAcceptError = true;
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
}
