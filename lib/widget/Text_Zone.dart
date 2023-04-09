import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../constants/constants.dart';

Widget Text_Field(TextEditingController ControllerField, String labelText,
    String validation, Function submit) {
  return TextFormField(
    obscureText: true,
    //enabled: !_isRequesting,
    controller: ControllerField,
    cursorColor: const Color(0xFF9B16A1),
    style: const TextStyle(color: Colors.white),
    keyboardType: TextInputType.emailAddress,
    textInputAction: TextInputAction.next,
    validator: (txt) => txt.isEmpty ? validation : null,
    onFieldSubmitted: (txt) => submit,
    textDirection: TextDirection.ltr,
    decoration: InputDecoration(
      errorStyle: const TextStyle(fontSize: 16.0, color: whiteColor),
      prefixIcon: Icon(
        Icons.lock,
        color: whiteColor,
        size: 20.sp,
      ),
      labelText: labelText,
      labelStyle: grey16SemiBoldTextStyle,
      fillColor: Color(0xffc79a9a),
      isDense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.white)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.white)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0)),
      errorBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      disabledBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      focusedErrorBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
    ),
  );
}
