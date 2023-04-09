import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salonat/models/category.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';
import '../localisation/language/language.dart';
import '../models/cat.dart';

class Carte_Category extends StatefulWidget {
  final Cat categories;

  const Carte_Category({Key key, this.categories}) : super(key: key);

  @override
  State<Carte_Category> createState() => _Carte_CategoryState();
}

class _Carte_CategoryState extends State<Carte_Category> {
  bool favorite = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         widget.categories.image == null
            ? Icon(Icons.broken_image_outlined)
            : Image.network(
                'http://salonat.qa/' + widget.categories.services[0].image.toString(),
                color: Color(0xffB2628E),
                height: 6.h,
                width: 12.w,
                fit: BoxFit.contain,
              ),
        heightSpace,
        Text(
          Languages.of(context).labelSelectLanguage == "English"
              ? widget.categories.services[0].name
              : widget.categories.services[0].nameAr,
          style: TextStyle(
              color: blackColor,
              fontSize: 8.sp,
              fontFamily: 'SFProDisplay-Bold'),
          maxLines: 1,
          overflow: TextOverflow.clip,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
