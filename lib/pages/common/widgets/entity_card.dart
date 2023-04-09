import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:salonat/models/entity.dart';
import 'package:salonat/widget/text_field.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/constants.dart';
import '../../../localisation/language/language.dart';
import '../../../services/api.dart';
import '../../../services/apiservice.dart';
import '../../../services/user.dart';
import '../../auth/phone_sign_up.dart';


class EntityCard extends StatefulWidget {
  final EntityModel entity;

  const EntityCard({Key key, this.entity}) : super(key: key);

  @override
  State<EntityCard> createState() => _EntityCardState();
}

class _EntityCardState extends State<EntityCard> {
  bool favorite = false;
  final _formKey = GlobalKey<FormState>();
  final bool _accepted = true;
  bool _isRequesting = false;
  final _mailController = TextEditingController();
  final _passwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: API.isPhone ? 100.0 : 200.0,
          width: API.isPhone ? 135.0 : 250.0,
          foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(18.0),
                  topLeft: Radius.circular(18.0)),
              gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.transparent],
                  stops: [.0, .43])),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(18.0),
                topLeft: Radius.circular(18.0)),
            border: Border.all(
              color: whiteColor,
            ),
            image: DecorationImage(
              image: NetworkImage('https://salonat.qa/${widget.entity.image}'),
              fit: BoxFit.fill,
            ),
            /*boxShadow: [
              BoxShadow(
                color: blackColor.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 2,
              ),
            ],*/
          ),
        ),
        Positioned(
          bottom: 10,
          left: .0,
          right: .0,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 40,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18)),
                /*boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.2),
                    blurRadius: 2.5,
                    spreadRadius: 2.5,
                  ),
                ],*/
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      widget.entity == null
                          ? const Center()
                          : Languages.of(context).labelSelectLanguage ==
                                  "English"
                              ? widget.entity.name
                              : widget.entity.nameAr,
                      style: TextStyle(
                          fontFamily: 'SFPro',
                          fontSize:  API.isPhone ? 15.0 : 30.0,
                          color: primaryColor,
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center),
                  if (widget.entity.openClose != null &&
                      widget.entity.openClose.toLowerCase() == 'closed')
                    Text(
                      Languages.of(context).closed,
                      style: white10SFProMedium,
                    )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: _favbutton(done: favorite ? true : false),
        )
      ],
    );
  }

  _updateFavorite() {
    if (API.USER == null) {
      return;
    }
    WebService()
        .updateFav(
      id: widget.entity.id.toString(),
    )
        .then((value) {
      setState(() {
        favorite = value;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: whiteColor,
          content: Text(
            favorite ? Languages.of(context).add : Languages.of(context).remove,
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ),
          behavior: SnackBarBehavior.floating,
        ));
      });
    });
  }

  Widget _favbutton({bool done = false}) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: API.USER == null ? _loginalert : _updateFavorite,
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            done ? Icons.favorite : Icons.favorite_border,
            color: done ? Colors.red.shade600 : primaryColor,
          )),
    );
  }

  Future<void> _login() async {
    setState(() {});

    if (_formKey.currentState.validate() && _accepted) {
      setState(() {});
      _isRequesting = true;
      try {
        final user = await UsersWebService().login(
            mail: _mailController.text, password: _passwdController.text);

        API.USER = user;
        await Hive.box('global').put('user', user);
        await Hive.box('user');

        Get.snackbar('Login', 'Login .',
            backgroundColor: whiteColor,
            snackPosition: SnackPosition.BOTTOM,
            colorText: primaryColor);
        Navigator.pop(context);
      } catch (e) {
        print(e);
        Get.snackbar('Error Login account',
            'These credentials do not match our records.',
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.black);
      }
    }
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
                            validator: (txt) => txt.isEmpty
                                ? Languages.of(context).email_val
                                : null,
                            textDirection: TextDirection.ltr,
                            cursorColor: primaryColor,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  fontSize: 12.sp, color: primaryColor),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: primaryColor,
                                size: 20.sp,
                              ),
                              labelText: Languages.of(context).emailorpassword,
                              labelStyle: TextStyle(color: primaryColor),
                              fillColor: Colors.white,
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
                                color: primaryColor,
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
                              style: TextStyle(
                                  color: primaryColor, fontSize: 10.sp),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Phone_Sign_Up()),
                              ),
                              child: Text(
                                Languages.of(context).signupnow,
                                style: TextStyle(
                                  color: primaryColor,
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
}
