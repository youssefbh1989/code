import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:salonat/constants/constants.dart';
import 'package:salonat/services/api.dart';
import 'package:sizer/sizer.dart';

import '../localisation/language/language.dart';

class Add_Salon extends StatefulWidget {
  const Add_Salon({Key key}) : super(key: key);

  @override
  State<Add_Salon> createState() => _Add_SalonState();
}

class _Add_SalonState extends State<Add_Salon> {
  @override
  Widget build(BuildContext context) {
    bool _isRequesting = false;
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        title: Text(
          'Add Your Busniss',
          style: TextStyle(color: whiteColor,fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: TextFormField(
                enabled: !_isRequesting,
                keyboardType: TextInputType.emailAddress,
                //controller: _emailController,
                textInputAction: TextInputAction.next,
                style: const TextStyle(color: primaryColor),
                validator: (txt) => txt.isEmpty || !txt.contains('@')
                    ? Languages.of(context).email_val
                    : null,
                textDirection: TextDirection.ltr,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  filled: true,
                  errorStyle:
                      const TextStyle(fontSize: 16.0, color: primaryColor),
                  labelText: 'Full Name',
                  labelStyle: TextStyle(color: primaryColor),
                  fillColor: whiteColor,
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
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
                //controller: _emailController,
                textInputAction: TextInputAction.next,
                style: const TextStyle(color: primaryColor),
                validator: (txt) => txt.isEmpty || !txt.contains('@')
                    ? Languages.of(context).email_val
                    : null,
                textDirection: TextDirection.ltr,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  filled: true,
                  errorStyle:
                      const TextStyle(fontSize: 16.0, color: primaryColor),
                  labelText: 'Full  Arabic Name',
                  labelStyle: TextStyle(color: primaryColor),
                  fillColor: whiteColor,
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
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
                //controller: _emailController,
                textInputAction: TextInputAction.next,
                style: const TextStyle(color: primaryColor),
                validator: (txt) => txt.isEmpty || !txt.contains('@')
                    ? Languages.of(context).email_val
                    : null,
                textDirection: TextDirection.ltr,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  filled: true,
                  errorStyle:
                      const TextStyle(fontSize: 16.0, color: primaryColor),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: primaryColor),
                  fillColor: whiteColor,
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
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
                keyboardType: TextInputType.number,
                //controller: _emailController,
                textInputAction: TextInputAction.next,
                style: const TextStyle(color: primaryColor),
                validator: (txt) =>
                    txt.isEmpty ? Languages.of(context).email_val : null,
                textDirection: TextDirection.ltr,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  filled: true,
                  errorStyle:
                      const TextStyle(fontSize: 16.0, color: primaryColor),
                  labelText: 'Phone',
                  labelStyle: TextStyle(color: primaryColor),
                  fillColor: whiteColor,
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
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
            Row(
              children: [
                Expanded(flex:2,child: Padding(
                  padding: EdgeInsets.only(left: 4.6.h),
                  child: TextFormField(
                    enabled: !_isRequesting,
                    keyboardType: TextInputType.number,
                    //controller: _emailController,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(color: primaryColor),
                    validator: (txt) =>
                    txt.isEmpty ? Languages.of(context).email_val : null,
                    textDirection: TextDirection.ltr,
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                      filled: true,
                      errorStyle:
                      const TextStyle(fontSize: 16.0, color: primaryColor),
                      labelText: 'Profile Photo',
                      labelStyle: TextStyle(color: primaryColor),
                      fillColor: whiteColor,
                      isDense: true,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: primaryColor)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10),
                          topLeft: Radius.circular(10)),
                          borderSide: const BorderSide(color: primaryColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10),
                              topLeft: Radius.circular(10))),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: primaryColor)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                ),),
                Expanded(flex:1,child: Padding(
                  padding:  EdgeInsets.only(right:4.6.h),

                  child: MaterialButton(

                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only
                      (bottomRight: Radius.circular(10.0),
                    topRight: Radius.circular(10.0))),

                    onPressed: (){},

                    color: primaryColor,
                    child: Text('Browse',style: TextStyle(
                      color: whiteColor
                    ),


                    ),
                    height: API.isPhone ? 30.0 : 74.0,
                    minWidth:  API.isPhone ? 200.0 : 500.0,

                  ),
                ),)

              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              children: [
                Expanded(flex:2,child: Padding(
                  padding: EdgeInsets.only(left: 4.6.h),
                  child: TextFormField(
                    enabled: !_isRequesting,
                    keyboardType: TextInputType.number,
                    //controller: _emailController,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(color: primaryColor),
                    validator: (txt) =>
                    txt.isEmpty ? Languages.of(context).email_val : null,
                    textDirection: TextDirection.ltr,
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                      filled: true,
                      errorStyle:
                      const TextStyle(fontSize: 16.0, color: primaryColor),
                      labelText: 'Cover Photo',
                      labelStyle: TextStyle(color: primaryColor),
                      fillColor: whiteColor,
                      isDense: true,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: primaryColor)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10),
                              topLeft: Radius.circular(10)),
                          borderSide: const BorderSide(color: primaryColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10),
                              topLeft: Radius.circular(10))),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: primaryColor)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                ),),
                Expanded(flex:1,child: Padding(
                  padding:  EdgeInsets.only(right: 4.6.h),

                  child: MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only
                      (bottomRight: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),

                    onPressed: (){},

                    color: primaryColor,
                    child: Text('Browse',style: TextStyle(
                        color: whiteColor
                    ),


                    ),
                    height: API.isPhone ? 30.0 : 74.0,
                    minWidth:  API.isPhone ? 200.0 : 500.0,

                  ),
                ),)

              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: TextFormField(
                enabled: !_isRequesting,
                keyboardType: TextInputType.emailAddress,
                //controller: _emailController,
                textInputAction: TextInputAction.next,
                style: const TextStyle(color: primaryColor),
                validator: (txt) => txt.isEmpty || !txt.contains('@')
                    ? Languages.of(context).email_val
                    : null,
                textDirection: TextDirection.ltr,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  filled: true,
                  errorStyle:
                  const TextStyle(fontSize: 16.0, color: primaryColor),
                  labelText: 'CR Number ',
                  labelStyle: TextStyle(color: primaryColor),
                  fillColor: whiteColor,
                  isDense: true,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
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
            Row(
              children: [
                Expanded(flex:2,child: Padding(
                  padding: EdgeInsets.only(left: 4.6.h),
                  child: TextFormField(
                    enabled: !_isRequesting,
                    keyboardType: TextInputType.number,
                    //controller: _emailController,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(color: primaryColor),
                    validator: (txt) =>
                    txt.isEmpty ? Languages.of(context).email_val : null,
                    textDirection: TextDirection.ltr,
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                      filled: true,
                      errorStyle:
                      const TextStyle(fontSize: 16.0, color: primaryColor),
                      labelText: 'CR Copy',
                      labelStyle: TextStyle(color: primaryColor),
                      fillColor: whiteColor,
                      isDense: true,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: primaryColor)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10),
                              topLeft: Radius.circular(10)),
                          borderSide: const BorderSide(color: primaryColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10),
                              topLeft: Radius.circular(10))),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: primaryColor)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                ),),
                SizedBox(height: 2.h,),
                Expanded(flex:1,child: Padding(
                  padding:  EdgeInsets.only(right: 4.6.h),

                  child: MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only
                      (bottomRight: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),

                    onPressed: (){},

                    color: primaryColor,
                    child: Text('Browse',style: TextStyle(
                        color: whiteColor
                    ),


                    ),
                    height: API.isPhone ? 30.0 : 74.0,
                    minWidth:  API.isPhone ? 200.0 : 500.0,

                  ),
                ),)

              ],
            ),
            SizedBox(height: 2.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: TextFormField(
                enabled: !_isRequesting,
                keyboardType: TextInputType.emailAddress,
                //controller: _emailController,
                textInputAction: TextInputAction.next,
                style: const TextStyle(color: primaryColor),
                validator: (txt) => txt.isEmpty || !txt.contains('@')
                    ? Languages.of(context).email_val
                    : null,
                textDirection: TextDirection.ltr,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  filled: true,
                  errorStyle:
                  const TextStyle(fontSize: 16.0, color: primaryColor),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: primaryColor),
                  fillColor: whiteColor,
                  isDense: true,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
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
                //controller: _emailController,
                textInputAction: TextInputAction.next,
                style: const TextStyle(color: primaryColor),
                validator: (txt) => txt.isEmpty || !txt.contains('@')
                    ? Languages.of(context).email_val
                    : null,
                textDirection: TextDirection.ltr,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  filled: true,
                  errorStyle:
                  const TextStyle(fontSize: 16.0, color: primaryColor),
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(color: primaryColor),
                  fillColor: whiteColor,
                  isDense: true,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
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
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: primaryColor)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ),
            SizedBox(height:2.h),
            MaterialButton(onPressed: (){},
              height: API.isPhone ? 30.0 : 60.0,

              minWidth:  API.isPhone ? 200.0 : 500.0,

              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),

            color: primaryColor,
            child: Text('Add',style: TextStyle(
              color: whiteColor,
              fontSize: API.isPhone ? 15.0 : 25.0
            ),),)
            
          ],
        ),
      ),
    );
  }
}
