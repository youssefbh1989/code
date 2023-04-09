import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salonat/localisation/language/language.dart';
import 'package:sizer/sizer.dart';
import '../constants/constants.dart';
import '../exception/unauthorized.dart';
import '../localisation/locale_constant.dart';
import '../pages/bottom_bar.dart';
import '../services/user.dart';

class JoinUs extends StatefulWidget {
  const JoinUs({Key key}) : super(key: key);

  @override
  _JoinUsState createState() => _JoinUsState();
}

class _JoinUsState extends State<JoinUs> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isRequesting = false;
  final bool _accepted = true;
  bool _showAcceptError = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: false,
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 15.sp,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/logo- white.png',
                        height: 25.h,
                        width: 40.w,
                        color: primaryColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: TextFormField(
                        enabled: !_isRequesting,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: primaryColor),
                        validator: (txt) => txt.isEmpty || !txt.contains('@')
                            ? Languages.of(context).email_val
                            : null,
                        textDirection: TextDirection.ltr,
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          filled: true,
                          errorStyle: const TextStyle(
                              fontSize: 16.0,
                              color: primaryColor
                          ),
                          labelText: Languages.of(context).email,
                          labelStyle: TextStyle(
                            color: primaryColor
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
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: TextFormField(
                        enabled: !_isRequesting,
                        keyboardType: TextInputType.emailAddress,
                        controller: _nameController,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: primaryColor),
                        validator: (txt) => txt.isEmpty
                            ? Languages.of(context).name_val
                            : null,
                        textDirection: TextDirection.ltr,
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          filled: true,
                          errorStyle: const TextStyle(
                              fontSize: 16.0,
                              color: primaryColor
                          ),
                          labelText: Languages.of(context).name,
                          labelStyle: TextStyle(
                              color:primaryColor
                          ),
                          fillColor: whiteColor,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 2.h),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: primaryColor)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: primaryColor, width: 2.0),
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
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: TextFormField(
                        enabled: !_isRequesting,
                        keyboardType: TextInputType.emailAddress,
                        maxLines: 3,
                        minLines: 3,
                        controller: _subjectController,
                        style: const TextStyle(
                            color: primaryColor
                      ),
                        textInputAction: TextInputAction.next,
                        validator: (txt) => txt.isEmpty
                            ? Languages.of(context).pleaseenterthesubject
                            : null,
                        textDirection: TextDirection.ltr,
                        cursorColor: primaryColor,
                        decoration: InputDecoration(

                          filled:true,
                          errorStyle: const TextStyle(
                              fontSize: 16.0,
                              color: primaryColor
                          ),
                          labelText: Languages.of(context).subject,
                          labelStyle: TextStyle(
                              color: primaryColor
                          ),
                          fillColor: whiteColor,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 2.h),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: primaryColor, width: 2.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: primaryColor)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: primaryColor, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: primaryColor
                          )),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              enabled: !_isRequesting,
                              keyboardType: TextInputType.emailAddress,
                              maxLines: 6,
                              minLines: 3,
                              controller: _messageController,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(color: primaryColor),
                              validator: (txt) => txt.isEmpty
                                  ? Languages.of(context).pleaseenternotes
                                  : null,
                              textDirection: TextDirection.ltr,
                              cursorColor: primaryColor,
                              decoration: InputDecoration(
                                filled:true,
                                errorStyle: const TextStyle(
                                    fontSize: 16.0,
                                    color: primaryColor
                                ),
                                labelText: Languages.of(context).note,
                                labelStyle: TextStyle(
                                  color: primaryColor
                                ),
                                fillColor:whiteColor,
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 17, horizontal: 15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: primaryColor, width: 2.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color:primaryColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: primaryColor, width: 2.0),
                                    borderRadius:
                                        BorderRadius.circular(10.0)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: primaryColor)),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.h,vertical: 1.w),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        height: 5.h,
                        color: primaryColor,
                        mouseCursor: MouseCursor.defer,
                        textColor: Colors.white,
                        minWidth: double.infinity,
                        onPressed: _join,
                        child: Text(
                          Languages.of(context).join_us,
                          style: TextStyle(
                              color: whiteColor, fontSize: 12.sp,
                          fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _logoutDialog({String text}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          backgroundColor: Colors.white.withOpacity(0.15),
          child: Container(
            height: 15.h,
            width: 65.w,
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
                  padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.h, vertical: 1.w),
                        child: Text(
                          text ??
                              Languages.of(context).thanksjoin,
                          textAlign: TextAlign.center,
                          style: black15SemiBoldTextStyle,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Expanded(child:
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              height: 5.h,
                              color: whiteColor,
                              mouseCursor: MouseCursor.defer,
                              textColor: Colors.white,
                              minWidth: double.infinity,
                              onPressed: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomBar())),
                              child: Text(
                                Languages.of(context).ok,
                                style: TextStyle(
                                    color: const Color(0xFF9B16A1),
                                    fontSize: 15.sp),
                              ),
                            )
                            )],
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

  divider() {
    return Expanded(
      child: Container(
        color: greyColor,
        height: 1,
        width: double.infinity,
      ),
    );
  }

  Future<void> _join() async {
    setState(() {});

    _showAcceptError = false;
    if (_formKey.currentState.validate() && _accepted) {
      setState(() {});
      _isRequesting = true;

      try {
        final join = await UsersWebService().contactus(
            name: _nameController.text,
            email: _emailController.text,
            message: _messageController.text,
            subject: _subjectController.text);

        _logoutDialog();
      } on UnauthorizedException {
        setState(() {
          _isRequesting = false;
        });
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
}
