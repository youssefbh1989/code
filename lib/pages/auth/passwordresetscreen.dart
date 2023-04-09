import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:salonat/constants/constants.dart';
import 'package:salonat/localisation/language/language.dart';
import 'package:salonat/pages/auth/signin.dart';
import 'package:salonat/services/api.dart';
import 'package:sizer/sizer.dart';
import '../../services/user.dart';
import '../bottom_bar.dart';


class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({Key key, this.profile}) : super(key: key);

  final String profile;

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  final bool _showPassword = false;
  bool visible = true;
  final bool _showConformPassword = false;
  FocusNode newPassWordFocusNode = FocusNode();
  FocusNode confirmNewPassWordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final bool _accepted = true;
  bool _isRequesting = false;

  bool _showAcceptError=true;

  @override
  void dispose() {
    super.dispose();
    newPassWordFocusNode.dispose();
    confirmNewPassWordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _showDialog() async {
      return showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              backgroundColor: Colors.white.withOpacity(0.5),
              actionsPadding:
                   const EdgeInsets.only(bottom: 8, left: 16, right: 16),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    height: 50,
                    color: whiteColor,
                    mouseCursor: MouseCursor.defer,
                    textColor: Colors.white,
                    minWidth: double.infinity,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Signin()),
                      );
                    },
                    child: Text(
                      "OK",
                      style: primaryColor15BoldTextStyle,
                    ),
                  ),
                ),
              ],
              content: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                alignment: Alignment.center,
                height: 230,
                child: Column(
                  children: <Widget>[
                    Image.asset("assets/new/verification.png",
                        height: 75, width: 75),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Verified !',
                        style: TextStyle(
                            color: Color(0xFF222B45),
                            fontSize: 28,
                            fontFamily: 'SFProDisplay-Bold')),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Yalla! You have successfully Reset Your Password.",
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF222B45),
                        fontFamily: 'SFProDisplay-Bold',
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }

    return Scaffold(
      backgroundColor: backgroundcolor,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                SizedBox(
                height: 2.h,
              ),

              Image.asset(
                'assets/logo- white.png',
                width: 40.w,
                height: 20.h,
                color: primaryColor,
              ),
              SizedBox(
                height: 2.h,
              ),
               Text(Languages.of(context).reset_pass, style: TextStyle(
                   color: primaryColor,
                fontFamily: 'SFProDisplay-Bold',
                 fontSize: API.isPhone ? 15.0 : 30.0,
              )),
                SizedBox(
                height: 5.h,
              ),
               Text(Languages.of(context).password_val,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: API.isPhone ? 15.0 : 30.0,
                    fontFamily: 'SFProDisplay-Bold',

                  )),
                SizedBox(
                height: 5.h,
              ),
              passwordTextField(),
              SizedBox(
                height: 2.h,
              ),

              confirm_passwordTextField(),
               SizedBox(
                height: 5.h,
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: API.isPhone ? 30.0 : 65.0),
                child:
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    height: API.isPhone ? 40.0 : 60.0,
                    color: primaryColor,
                    mouseCursor: MouseCursor.defer,
                    textColor: Colors.white,
                    minWidth: double.infinity,
                    onPressed: () {

                      if(newPasswordController.text.isEmpty||confirmNewPasswordController.text.isEmpty) {
                        Get.snackbar('Error : ',
                            'Please Enter Your New Password !!',
                            backgroundColor: backgroundcolor,
                            snackPosition: SnackPosition.BOTTOM,
                            colorText: primaryColor);
                      }else{
                        _new_user_password();
                      }
                    },
                    child: Text(
                      Languages.of(context).Confirm,
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: API.isPhone ? 15.0 : 30.0,fontFamily: 'Calibri',
                          fontWeight: FontWeight.bold),
                    ),
                  ),

              ),
            ],
          ),
        ),
      ),
    );
  }

  passwordTextField() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: TextFormField(
              obscureText: true,
              cursorColor: primaryColor,
              controller: newPasswordController,
              style:  TextStyle(color: primaryColor,
                  fontSize: API.isPhone ? 20.0 : 20.0),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (txt) =>
                  txt.isEmpty ? Languages.of(context).password_val : null,
              textDirection: TextDirection.ltr,
              decoration: InputDecoration(
                filled: true,
                errorStyle:
                TextStyle(fontSize: 12.sp,color: primaryColor),
                prefixIcon:  Icon(
                  Icons.lock,
                  color:primaryColor,
                  size: 10.sp,
                ),
                labelText: Languages.of(context).password,
                labelStyle: TextStyle(color: primaryColor),
                fillColor: whiteColor,
                isDense: true,
                contentPadding:  EdgeInsets.symmetric(
                    horizontal: 2.h),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: primaryColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: primaryColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: primaryColor),
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
          heightSpace,
        ],
      ),
    );
  }
  confirm_passwordTextField() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: TextFormField(
              obscureText: true,
              controller: confirmNewPasswordController,
              cursorColor: primaryColor,
              style: const TextStyle(color: primaryColor),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (txt) =>
              txt.isEmpty ? Languages.of(context).password_val : null,
              textDirection: TextDirection.ltr,
              decoration: InputDecoration(
                filled: true,
                errorStyle:
                TextStyle(fontSize: 12.sp, color: primaryColor),
                prefixIcon:  Icon(
                  Icons.lock,
                  color: primaryColor,
                  size: 10.sp,
                ),
                labelText: Languages.of(context).password,
                labelStyle: TextStyle(color: primaryColor
                ),
                fillColor: Colors.white,
                isDense: true,
                contentPadding:  EdgeInsets.symmetric(
                    horizontal: 2.h),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color:primaryColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: primaryColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: primaryColor),
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
          heightSpace,
        ],
      ),
    );
  }
  Future<void> _new_user_password() async {
    setState(() {});
    _showAcceptError = false;

    if (_formKey.currentState.validate() && _accepted) {
      setState(() {});
      try {
        final verification = await UsersWebService().new_password_user(
            password: newPasswordController.text.toString(),
            password_confirmation: confirmNewPasswordController.text.toString(),
            email: widget.profile
        );

        waitDialog();
      }
      finally {
        setState(() {
          _isRequesting = false;
        });
      }
    }else if (!_accepted) {
      setState(() {
        _showAcceptError = true;
      });
    }
  }
      void _logoutDialog({String text}) {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              insetPadding:
              EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6.0))),
              backgroundColor: Colors.white.withOpacity(0.15),
              child: Container(
                height: 30.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white10.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(6),
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 1.h, vertical: 1.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/new/ok.png',
                            height: 10.h,
                            width: 10.h,
                          ),
                          SizedBox(height: 1.h,),
                          Text(
                            text ??
                                "Your Password Have been Reseted Succsufelly ,Please, login Again",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Calibri',
                              fontSize: 15.sp,
                              color: whiteColor
                            ),
                          ),
                          SizedBox(height: 5.h,),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () =>
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (
                                                  context) => const Signin())),
                                  child: Container(
                                    height: 5.h,
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(4.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                      border: Border.all(color: whiteColor),
                                      borderRadius: BorderRadius.circular(6),
                                      boxShadow: [
                                        // BoxShadow(
                                        //   color: primaryColor.withOpacity(0.2),
                                        //   spreadRadius: 2,
                                        //   blurRadius: 2,
                                        // ),
                                      ],
                                    ),
                                    child: Text(
                                      Languages
                                          .of(context)
                                          .Confirm,
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 15.sp,fontFamily: 'Calibri'
                                      ),
                                    ),
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
            );
          },
        );
      }

  waitDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (contxet) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 1.h),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          backgroundColor: whiteColor,
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
                        style: TextStyle(
                            color: primaryColor,fontWeight: FontWeight.bold
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

        Get.snackbar('Reset Password', 'Your Password Have been Reseted Succsufelly ,Please, login Again ',
            backgroundColor: backgroundcolor,

            snackPosition: SnackPosition.BOTTOM, colorText: primaryColor);
        Get.to(()=>Signin());
      },
    );
  }
    }
