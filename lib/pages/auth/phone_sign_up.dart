import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:salonat/localisation/language/language.dart';
import 'package:salonat/pages/auth/signin.dart';
import 'package:salonat/pages/auth/signup.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants.dart';
import '../../services/api.dart';
import '../bottom_bar.dart';
import 'otp.dart';

class Phone_Sign_Up extends StatefulWidget {
  const Phone_Sign_Up({Key key}) : super(key: key);

  @override
  _Phone_Sign_UpState createState() => _Phone_Sign_UpState();
}

class _Phone_Sign_UpState extends State<Phone_Sign_Up> {
  double height;
  double width;
  bool psw = true;
  bool confirmpsw = true;
  final bool _isRequesting = false;
  final bool _showPasswd = false;
  final _formKey = GlobalKey<FormState>();

  final _phoneController = TextEditingController();

  final bool _showAcceptError = false;
  final bool _accepted = true;

  @override
  void dispose() {

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

                        SizedBox(height: 5.h,),

                        Image.asset(
                          'assets/logo- white.png',
                          width: 40.w,
                          height: 20.h,
                          color: primaryColor,
                        ),

                        SizedBox(height: 5.h,),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(8),
                            ],

                            enabled: !_isRequesting,
                            keyboardType: TextInputType.number,
                            controller: _phoneController,
                            autofillHints: [AutofillHints.telephoneNumber],
                            textInputAction: TextInputAction.next,
                            style:  TextStyle(color: primaryColor,fontWeight: FontWeight.bold),
                            validator: (txt) => txt.isEmpty
                                ? Languages.of(context).mobile_val
                                : null,
                            textDirection: TextDirection.ltr,
                            //onFieldSubmitted: (txt) => _signup(),
                            cursorColor: primaryColor,
                            decoration: InputDecoration(
                              filled: true,
                              errorStyle:  TextStyle(
                                  fontSize: 16.0, color: primaryColor),
                              prefixIcon: Icon(
                                Icons.phone,
                                color: primaryColor,
                                size: API.isPhone ? 20.0 : 35.0,
                              ),
                              labelText: Languages.of(context).mobile,
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
                        ),
                        SizedBox(height: 5.h,),


                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.2.h, vertical: 1.w),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            height: API.isPhone ? 40.0 : 60.0,
                            color: primaryColor,
                            mouseCursor: MouseCursor.defer,
                            textColor: Colors.white,
                            minWidth: double.infinity,
                            onPressed: (){


                              _phoneController.text.isEmpty?
                              Get.snackbar('Error :', 'Please Enter Your Mobile Number .',
                              backgroundColor: backgroundcolor,
                              snackPosition: SnackPosition.BOTTOM,
                              colorText: primaryColor):

                              Get.to(()=>Signup(
                              phone:_phoneController.text
                            ));

                              },
                            child: Text(
                              Languages.of(context).signup,
                              style: TextStyle(
                                  color: whiteColor,
                                  fontSize: API.isPhone ? 15.0 : 30.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Languages.of(context).alredyhaveaccount + ' ?',
                                style: TextStyle(
                                    color: primaryColor,
                                   fontSize: API.isPhone ? 14.0 : 20.0
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
                            color: Color(0xffc79a9a)
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
