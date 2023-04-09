import 'dart:async';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:location/location.dart';
import 'package:salonat/localisation/language/language.dart';
import 'package:salonat/models/positionmodel.dart';
import 'package:salonat/pages/auth/phone_sign_up.dart';
import 'package:salonat/services/api.dart';
import 'package:salonat/services/user.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants.dart';
import '../../widget/text_field.dart';
import '../bottom_bar.dart';
import 'forgetpassword.dart';
import 'otp.dart';

class Signin extends StatefulWidget {
  const Signin({Key key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  final bool _switchValue = true;
  final _mailController = TextEditingController();
  final _passwdController = TextEditingController();
  final _passwdNode = FocusNode();
  bool psw = true;
  bool confirmpsw = true;
  DateTime currentBackPressTime;
  bool visible = true;
  PositionModel _position;
  LocationData mycurrentLocation;
  double height;
  double width;
  bool _isRequesting = false;
  final bool _accepted = true;
  bool _showAcceptError = false;
  AuthButtonType buttonType;
  AuthIconType iconType;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _mailController.dispose();
    _passwdController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      extendBodyBehindAppBar: false,
      resizeToAvoidBottomInset: true,


      body: SingleChildScrollView(
        child: Column(
          children: [
            AutofillGroup(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 8.h,),

                        Image.asset(
                          'assets/logo- white.png',
                          width: API.isPhone ? 200.0 : 300.0,
                          height: API.isPhone ? 250.0 : 450.0,
                          color: primaryColor,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: TextFormField(
                            //enabled: !_isRequesting,
                            keyboardType: TextInputType.emailAddress,
                            controller: _mailController,
                            autofillHints: [AutofillHints.email],
                            style: TextStyle(
                                color: primaryColor,
                                fontFamily: 'Calibri',
                                fontSize: API.isPhone ? 20.0 : 20.0),
                            textInputAction: TextInputAction.next,
                            validator: (txt) =>
                                txt.isEmpty
                                    ? Languages.of(context).email_val
                                    : null,
                            textDirection: TextDirection.ltr,
                            cursorColor: primaryColor,
                            decoration: InputDecoration(
                              filled: true,
                              //fillColor: Colors.deepPurpleAccent,
                              errorStyle: TextStyle(
                                  fontSize: API.isPhone ? 14.0 : 14.0, color: primaryColor),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: primaryColor,
                                size: API.isPhone ? 20.0 : 35.0,
                              ),
                              labelText: Languages.of(context).emailorpassword,
                              labelStyle: TextStyle(color: primaryColor),
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
                                borderSide: BorderSide(color: primaryColor)

                              ),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: primaryColor)),

                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text_Field(
                                  _passwdController,
                                  Languages.of(context).password,
                                  Languages.of(context).password_val,
                                  _login,
                                  Icon(
                                    Icons.lock,
                                    color: primaryColor,
                                    size: API.isPhone ? 20.0 : 35.0,
                                  ),
                                  true,
                                  autofill: [AutofillHints.password]),
                              SizedBox(
                                height: 50,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgetPassword()),
                                  );
                                },
                                child: Text(
                                  Languages.of(context).forgetpassword + " ?",
                                  style: TextStyle(color: primaryColor,fontSize: API.isPhone ? 14.0 : 20.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: API.isPhone ? 30.0 : 65.0),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            height: API.isPhone ? 40.0 : 60.0,
                            color: primaryColor,
                            mouseCursor: MouseCursor.defer,
                            textColor: Colors.white,
                            minWidth: double.infinity,
                            onPressed: () {
                              _login();
                            },
                            child: Text(
                              Languages.of(context).login,
                              style: TextStyle(
                                  color: whiteColor,
                                  fontSize: API.isPhone ? 15.0 : 30.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Calibri'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  divider(),
                                  widthSpace,
                                  widthSpace,
                                  Text(
                                    Languages.of(context).signinwith,
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: API.isPhone ? 14.0 : 20.0
                                    ),
                                  ),
                                  widthSpace,
                                  widthSpace,
                                  divider(),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                        /*      Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AppleAuthButton(
                                  onPressed: (){},
                                  text: ' Apple Accounts',

                                  style: AuthButtonStyle(
                                    iconSize: 2.h,
                                    iconColor: primaryColor,
                                    textStyle: TextStyle(color: primaryColor,
                                        fontSize: 12.sp,fontWeight: FontWeight.bold),
                                    height: 5.h,
                                    width:60.w,
                                    buttonColor: whiteColor

                                  ),
                                ),
                              ),*/
                         /*     GoogleAuthButton(
                                onPressed: (){
                                  AuthService().signInWithGoogle();


                                },

                                text: ' Google Account',

                                style: AuthButtonStyle(
                                  iconSize: 2.h,
                                  height: 5.h,
                                  width:60.w,


                                 iconColor: primaryColor,
                                  buttonColor: whiteColor,
                                  textStyle: TextStyle(color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                  fontSize: 12.sp),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),*/
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    Languages.of(context).donthaveaccount +
                                        ' ?',
                                    style: TextStyle(color: primaryColor,fontSize: API.isPhone ? 14.0 : 20.0 ),
                                  ),
                                  InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  Phone_Sign_Up()),
                                    ),
                                    child: Text(
                                      Languages.of(context).signupnow,
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontFamily: 'Calibri',
                                        fontSize: API.isPhone ? 14.0 : 20.0,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: blackColor,
        textColor: whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }

  divider() {
    return Expanded(
      child: Container(
        color: primaryColor,
        height: 1,
        width: double.infinity,
      ),
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
        waitDialog();


        await Hive.box('global').put('user', user);
        await Hive.box('user');






      } catch (e) {
        print(e);
        Get.snackbar('Error Login account',
            'These credentials do not match our records.',
            backgroundColor: backgroundcolor,
            snackPosition: SnackPosition.BOTTOM,
            colorText: primaryColor);
      }
    }

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
                  EdgeInsets.symmetric(vertical: 1.w, horizontal: 1.h),
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    height: 5.h,
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
                      Languages.of(context).Confirm,
                      style: primaryColor15BoldTextStyle,
                    ),
                  ),
                ),
              ],
              content: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                alignment: Alignment.center,
                height: 25.h,
                child: Column(
                  children: <Widget>[
                    Image.asset("assets/new/verification.png",
                        height: 10.h, width: 15.w),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      Languages.of(context).password_reseted,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: const Color(0xFF222B45),
                        fontFamily: 'SFProDisplay-Bold',
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }

    void _logoutDialog({String text, Function ontap}) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            backgroundColor: Colors.white.withOpacity(0.15),
            child: Container(
              height: 20.h,
              width: 45.w,
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.h, vertical: 1.w),
                          child: Text(
                            text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontFamily: 'SFProDisplay-Bold'),
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
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


        API.USER.phone_verified_at=='null'
            ?   ShowverificationDialog()
            : Get.offAll(() => BottomBar(
            profile: API.USER,
            ));
        Get.snackbar('Login', 'Login .',
            backgroundColor: backgroundcolor,
            snackPosition: SnackPosition.BOTTOM,
            colorText: primaryColor);
      },
    );
  }


  ShowverificationDialog() {
    showDialog(context: context, builder: (context) => AlertDialog(
      elevation: 2,
      backgroundColor: whiteColor,
      title:  Text('Verication',style: TextStyle(
          color:  primaryColor,
          fontWeight: FontWeight.bold
      ),),
      content: Text('Your Account is not verified Please Continue to Verification Screen',
        style: TextStyle(
          color:  primaryColor,
        ),),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child:
        Text('No',style: TextStyle(
            color:  primaryColor

        ),)),
        TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Otp(profile: API.USER)));

              Get.snackbar('Verification',
                  'Verification code sent to your phone',
                  backgroundColor: backgroundcolor,
                  snackPosition: SnackPosition.BOTTOM,
                  colorText: primaryColor);
                  _resend_code();


            },
            child:  Text('Yes',style: TextStyle(
                color:  primaryColor
            ),)),
      ],
    ));
  }
  Future<void> _resend_code() async {
    setState(() {});

    setState(() {});

    final verification = await UsersWebService().resend_code();

    Get.snackbar('Resend Verification Code', 'Code Sent',
        backgroundColor: primaryColor,
        snackPosition: SnackPosition.BOTTOM, colorText: primaryColor);
  }

}
