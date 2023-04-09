import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:salonat/localisation/language/language.dart';
import 'package:salonat/models/usermodel.dart';
import 'package:salonat/pages/bottom_bar.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants.dart';
import '../../services/user.dart';


class Otp extends StatefulWidget {
  const Otp({Key key, this.profile, String token}) : super(key: key);

  final UserModel profile;

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  TextEditingController controller1;
  final _formKey = GlobalKey<FormState>();
  final bool _showAcceptError = false;

  final bool _isRequesting = false;

  FocusNode focusNode1 = FocusNode();
  final bool _isloading = true;

  @override
  void initState() {
    super.initState();
    controller1 = TextEditingController();
  }

  @override
  void dispose() {
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
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 119,
            child: Column(
              children: [
                SizedBox(
                  height: 5.h,
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
                Text(
                  Languages.of(context).VerifyYourAccount,
                  style: TextStyle(
                      color: primaryColor,
                      fontFamily: 'Calibri',
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  Languages.of(context).pleaseenter4digitcode,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: 'Calibri',
                      color: primaryColor,),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    codeTextField(),
                  ],
                ),
                Row(
                  children: const [Text('')],
                ),
                SizedBox(
                  height: 2.h,
                ),
                MaterialButton(
                  onPressed: () {
                    _resend_code();
                  },
                  child: Text(Languages.of(context).resendcode,
                      style: TextStyle(
                          color: primaryColor,
                          fontFamily: 'Calibri',
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp)),
                ),
                SizedBox(
                  height: 5.h,
                ),
                startButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  codeTextField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 5.h,
          width: 20.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white10.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            controller: controller1,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            cursorColor:  primaryColor,
            style: TextStyle(
              color: primaryColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold

            ),
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 11),
              border: UnderlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
      ],
    );
  }

  startButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 1.w),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        height: 5.h,
        color: primaryColor,
        mouseCursor: MouseCursor.defer,
        textColor: Colors.white,
        minWidth: double.infinity,
        onPressed: () {
          if(controller1.text.isEmpty) {

            Get.snackbar('Error :', 'Please Enter the Verifivation Code ',
              backgroundColor: backgroundcolor,
              colorText: primaryColor,
              snackPosition: SnackPosition.BOTTOM,);

          }else{

            _verification();

          }
        },
        child: Text(
          Languages.of(context).Next,
          style: TextStyle(color: whiteColor, fontSize: 15.sp,
          fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  waitDialog(String text) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (contxet) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: const SpinKitRing(
                        color: primaryColor,
                        lineWidth: 5,
                        size: 50.0,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: primaryColor,

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
        Get.snackbar('Verification', 'Your Account have Been Verified ',
            backgroundColor: backgroundcolor,
            colorText: primaryColor,

            snackPosition: SnackPosition.BOTTOM,);
        Get.to(() => BottomBar());
      },
    );
  }

  Future<void> _verification() async {
    setState(() {});

    setState(() {});
try {
  final verification = await UsersWebService().verificationmail(
    verification_code: controller1.text,
  );

  waitDialog('Please wait while we verified your account');

}on DioError catch(e){
  Get.snackbar('Error', e.message.toString(),
      backgroundColor: backgroundcolor,

      snackPosition: SnackPosition.BOTTOM, colorText: primaryColor);


}


  }

  Future<void> _resend_code() async {
    setState(() {});

    setState(() {});

    final verification =
        await UsersWebService().resend_code();

    Get.snackbar('Resend Verification Code', 'Code Sent',
        backgroundColor: whiteColor,

        snackPosition: SnackPosition.BOTTOM, colorText: primaryColor);
  }
}
