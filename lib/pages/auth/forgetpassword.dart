import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:salonat/constants/constants.dart';
import 'package:salonat/localisation/language/language.dart';
import 'package:salonat/pages/auth/verificationscreen.dart';
import 'package:salonat/services/api.dart';
import 'package:sizer/sizer.dart';
import '../../services/user.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _mailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final bool _accepted = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundcolor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          leading: IconButton(
            onPressed: (){Get.back();},
            icon: Icon(
              Icons.arrow_back_ios,
              size: API.isPhone ? 15.0 : 30.0,
              color: Colors.white,
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height - 119,
                child: Column(
                  children: [
                     SizedBox(height: 5.h),
                    Image.asset(
                      'assets/logo- white.png',
                      width:  API.isPhone ? 100.0 : 200.0,
                      height:    API.isPhone ? 100.0 : 200.0,
                      color: primaryColor,
                    ),
                    SizedBox(height: 5.h),
                    Text(Languages.of(context).please_enter,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: API.isPhone ? 15.0 : 30.0,
                          fontFamily: "SFProDisplay-Bold",
                        ),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip),
                    SizedBox(
                      height: 10.h,
                    ),
                    emailTextField(),
                    SizedBox(
                      height: 3.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: API.isPhone ? 30.0 : 65.0),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        height: API.isPhone ? 40.0 : 60.0,
                        color:primaryColor,
                        mouseCursor: MouseCursor.defer,
                        textColor: Colors.white,
                        minWidth: double.infinity,
                        onPressed: () {

                          if(_mailController.text.isEmpty) {
                            Get.snackbar('Error :', 'Please Enter Your Phone Number Or Email Address',
                              backgroundColor: backgroundcolor,
                              colorText: primaryColor,
                              snackPosition: SnackPosition.BOTTOM,);

                          }else{
                            _verification_email();
                          }
                        },
                        child: Text(
                          Languages.of(context).Send,
                          style: TextStyle(
                              color: whiteColor,   fontSize: API.isPhone ? 15.0 : 30.0,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  emailTextField() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 6.w,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _mailController,
              style:  TextStyle(color: primaryColor,
                  fontSize: API.isPhone ? 20.0 : 20.0),
              textInputAction: TextInputAction.next,
              validator: (txt) => txt.isEmpty
                  ? Languages.of(context).email_val
                  : null,
              textDirection: TextDirection.ltr,
              cursorColor:  primaryColor,
              decoration: InputDecoration(
                filled: true,
                errorStyle: const TextStyle(
                    fontSize: 16.0,
                    color: primaryColor
                ),
             /*   prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: primaryColor,
                ),*/
                //labelText: Languages.of(context).email,
                labelStyle: TextStyle(color:primaryColor),
                fillColor:  whiteColor,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 2.w, vertical: 2.h),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: primaryColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color:primaryColor)),
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
        ],
      ),
    );
  }

  Future<void> _verification_email() async {
    setState(() {});

    if (_formKey.currentState.validate() && _accepted) {
      setState(() {});

      final verification = await UsersWebService().email_verification(
        email: _mailController.text,
      );

     if(_mailController.text.contains('@')){ Get.snackbar('Password Reset',  Languages.of(context).resetpasscode,
          backgroundColor: backgroundcolor,


          snackPosition: SnackPosition.BOTTOM, colorText: primaryColor,);
      Get.to(()=>VerificationScreen(profile: _mailController.text,));


    } else {
       Get.snackbar('Password Reset',  'Verification Code Was Sent to Your Mobile Number',
         backgroundColor: backgroundcolor,


         snackPosition: SnackPosition.BOTTOM, colorText: primaryColor,);
       Get.to(()=>VerificationScreen(profile: _mailController.text,));

     }
     }
  }


}
