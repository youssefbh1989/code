import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';
import '../services/api.dart';

Widget Text_Field(
    TextEditingController ControllerField,
    String labelText,
    String validation,
    Function submit,
    Icon icon,
    bool obscure,
    {Iterable<String> autofill}) {
  final bool _isRequesting = false;
  return TextFormField(
    obscureText: obscure,
    controller: ControllerField,
    enabled: !_isRequesting,
    cursorColor: primaryColor,

    style:  TextStyle( color: primaryColor,fontSize:
    API.isPhone ? 14.0 : 25.0),
    keyboardType: TextInputType.emailAddress,
    textInputAction: TextInputAction.next,
    validator: (txt) => txt.isEmpty ? validation : null,
    onFieldSubmitted: (txt) => submit,
    autofillHints: autofill,
    textDirection: TextDirection.ltr,
    decoration: InputDecoration(
      filled: true,
      errorStyle:
          TextStyle(fontSize: API.isPhone ? 14.0 : 14.0, color: primaryColor, fontFamily: 'Calibri'),
      prefixIcon: icon,
      labelText: labelText,
      labelStyle: TextStyle(color: primaryColor),
      fillColor: whiteColor,
      isDense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: primaryColor)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: primaryColor)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color:primaryColor),
          borderRadius: BorderRadius.circular(10.0)),
      errorBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),

              borderSide: BorderSide(
                  color: primaryColor
              )),
      disabledBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      focusedErrorBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: primaryColor
          )),
    ),
  );
}
