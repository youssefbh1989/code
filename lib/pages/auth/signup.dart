import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:salonat/localisation/language/language.dart';
import 'package:salonat/pages/auth/signin.dart';
import 'package:salonat/widget/text_field.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants.dart';
import '../../services/api.dart';
import '../../services/user.dart';
import '../bottom_bar.dart';
import 'otp.dart';

class Signup extends StatefulWidget {
  const Signup({Key key, this.phone}) : super(key: key);

  final String phone;

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  double height;
  double width;
  bool psw = true;
  bool confirmpsw = true;
  final bool _isRequesting = false;
  final bool _showPasswd = false;
  final _formKey = GlobalKey<FormState>();
  final _mailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwdController = TextEditingController();
  final _rPasswdController = TextEditingController();
  final bool _showAcceptError = false;
  final bool _accepted = true;

  @override
  void dispose() {
    _nameController.dispose();
    _passwdController.dispose();
    _mailController.dispose();
    _rPasswdController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
            size: API.isPhone ? 20.0 : 35.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AutofillGroup(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height:2.h),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/logo- white.png',
                          width: API.isPhone ? 200.0 : 300.0,
                          height: API.isPhone ? 200.0 : 400.0,
                          color: primaryColor,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Text_Field(
                              _nameController,
                              Languages.of(context).name,
                              Languages.of(context).name_val,
                              _signup,
                              Icon(
                                Icons.person,
                                color: primaryColor,
                                size: API.isPhone ? 20.0 : 35.0,
                              ),
                              false,
                              autofill: [AutofillHints.name]),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: TextFormField(
                            enabled: !_isRequesting,
                            autofillHints: [AutofillHints.email],
                            keyboardType: TextInputType.emailAddress,
                            controller: _mailController,
                            style:  TextStyle(color:primaryColor,
                            fontSize: API.isPhone ? 14.0 : 25.0,),
                            textInputAction: TextInputAction.next,

                            textDirection: TextDirection.ltr,
                            cursorColor: primaryColor,
                            decoration: InputDecoration(
                              filled: true,
                              errorStyle:  TextStyle(
                                  fontSize: 16.0, color: primaryColor),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: primaryColor,
                                size: API.isPhone ? 20.0 : 35.0,
                              ),
                              labelText: Languages.of(context).email,
                              labelStyle: TextStyle(
                                color: primaryColor,
                                fontSize:  API.isPhone ? 20.0 : 20.0

                              ),
                              fillColor: whiteColor,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 2.h),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: primaryColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: primaryColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: primaryColor),
                                  borderRadius: BorderRadius.circular(10.0)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      color: primaryColor
                                  )),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      color: primaryColor
                                  )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 0.5.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('* Not Required',style: TextStyle(
                                color: greyColor
                              ),),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        /*Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: TextFormField(
                            enabled: !_isRequesting,
                            keyboardType: TextInputType.emailAddress,
                            controller: _phoneController,
                            autofillHints: [AutofillHints.telephoneNumber],
                            textInputAction: TextInputAction.next,
                            style:  TextStyle(color: blackColor),
                            validator: (txt) => txt.isEmpty
                                ? Languages.of(context).mobile_val
                                : null,
                            textDirection: TextDirection.ltr,
                            onFieldSubmitted: (txt) => _signup(),
                            cursorColor: Color(0xffc79a9a),
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                  fontSize: 16.0, color: Color(0xffc79a9a)),
                              prefixIcon: Icon(
                                Icons.phone,
                                color: primaryColor,
                                size: 20.sp,
                              ),
                              labelText: Languages.of(context).mobile,
                              labelStyle: TextStyle(
                                color:  primaryColor
                              ),
                              fillColor: blackColor,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 2.h),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: primaryColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: primaryColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: primaryColor),
                                  borderRadius: BorderRadius.circular(10.0)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
                        ),*/
                       /* SizedBox(
                          height: 2.h,
                        ),*/
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: TextFormField(
                            enabled: !_isRequesting,
                            obscureText: true,
                            keyboardType: TextInputType.name,
                            controller: _passwdController,
                            autofillHints: [AutofillHints.newPassword],
                            style:  TextStyle(color:primaryColor,
                            fontSize: API.isPhone ? 14.0 : 25.0),
                            textInputAction: TextInputAction.next,
                            validator: (txt) => txt.isEmpty
                                ? Languages.of(context).password_val
                                : null,
                            textDirection: TextDirection.ltr,
                            cursorColor: primaryColor,
                            decoration: InputDecoration(
                              filled: true,
                              errorStyle:  TextStyle(
                                  fontSize: API.isPhone ? 14.0 : 20.0, color: primaryColor),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: primaryColor,
                                size: API.isPhone ? 20.0 : 35.0,
                              ),
                              labelText: Languages.of(context).password,
                              labelStyle: TextStyle(
                                color:  primaryColor,
                                  fontSize:API.isPhone ? 20.0 : 20.0
                              ),
                              fillColor: whiteColor,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 2.h),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: primaryColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color:primaryColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: primaryColor),
                                  borderRadius: BorderRadius.circular(10.0)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      color: primaryColor
                                  )),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      color: primaryColor
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: TextFormField(
                            enabled: !_isRequesting,
                            obscureText: true,
                            keyboardType: TextInputType.name,
                            controller: _rPasswdController,
                            textInputAction: TextInputAction.next,
                            style:  TextStyle(color: primaryColor,
                              fontSize:  API.isPhone ? 14.0 : 25.0
                            ),
                            validator: (txt) => txt.isEmpty
                                ? Languages.of(context).password_confirm_val
                                : null,
                            textDirection: TextDirection.ltr,
                            cursorColor: primaryColor,
                            decoration: InputDecoration(
                              filled: true,
                              errorStyle:  TextStyle(
                                  fontSize: API.isPhone ? 14.0 : 20.0, color: primaryColor),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: primaryColor,
                                size: API.isPhone ? 20.0 : 35.0,
                              ),
                              labelText: Languages.of(context).repassword,
                              labelStyle: TextStyle(
                                color:  primaryColor
                              ),
                              fillColor: whiteColor,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 2.h),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color:primaryColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: primaryColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: primaryColor),
                                  borderRadius: BorderRadius.circular(10.0)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      color: primaryColor
                                  )),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      color: primaryColor
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.h, vertical: 1.w),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            height: 5.h,
                            color: primaryColor,
                            mouseCursor: MouseCursor.defer,
                            textColor: Colors.white,
                            minWidth: double.infinity,
                            onPressed: _signup,
                            child: Text(
                              Languages.of(context).signup,
                              style: TextStyle(
                                  color: whiteColor,
                                   fontSize: API.isPhone ? 15.0 : 30.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Languages.of(context).alredyhaveaccount + ' ?',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize:API.isPhone ? 14.0 : 20.0
                                ),
                              ),
                              InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Signin()),
                                ),
                                child: Text(
                                  Languages.of(context).login,
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: API.isPhone ? 14.0 : 20.0,
                                    fontFamily: 'Calibri',
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
    );
  }

  divider() {
    return Expanded(
      child: Container(
        color: greyColor,
        height: 1,
        width: double.infinity,
      ),
    );
  }

  Future<void> _signup() async {
    if (_formKey.currentState.validate() && _accepted) {
      setState(() {});

      try{

      final user = await UsersWebService().signup(
          name: _nameController.text,
          email: _mailController.text,
          phone: widget.phone.toString(),
          password: _passwdController.text,
          confirmpsw: _rPasswdController.text);
          waitDialog();
          API.USER = user;
          await Hive.box('global').put('user', user);

    }on DioError catch(e){
        Get.snackbar('The given data was invalid :', 'The email or the Phone has already been taken',
            backgroundColor: backgroundcolor,
            snackPosition: SnackPosition.BOTTOM, colorText: primaryColor);
      }
      }
  }



  waitDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (contxet) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          backgroundColor: whiteColor,
          child: Container(
            height: 20.h,
            width: 35.w,
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
                        Languages.of(context).creatnewaccount,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: primaryColor
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
      const Duration(seconds: 3),
      () {
        currentIndex = 0;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Otp(profile: API.USER)),
        );
      },
    );
  }
}
