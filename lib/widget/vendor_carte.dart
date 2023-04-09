import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salonat/models/vendormodel.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';
import '../localisation/language/language.dart';
import '../services/api.dart';
import '../services/apiservice.dart';

class Carte_Vendor extends StatefulWidget {
  final VendorModel vendor;

  const Carte_Vendor({Key key, this.vendor}) : super(key: key);

  @override
  State<Carte_Vendor> createState() => _Carte_VendorState();
}

class _Carte_VendorState extends State<Carte_Vendor> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 155,
          width: 155,
          foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black38, Colors.transparent],
                  stops: [.0, .43])),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            image: DecorationImage(
              image: widget.vendor.image == null
                  ? _shimmer()
                  : NetworkImage('http://salonat.qa/' + widget.vendor.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: .0,
          left: .0,
          right: .0,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 40),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
              decoration: BoxDecoration(
                color: Colors.white10.withOpacity(0.80),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      widget.vendor == null
                          ? const Center()
                          : Languages.of(context).labelSelectLanguage ==
                                  "English"
                              ? widget.vendor.name
                              : widget.vendor.nameAr,
                      style: white13SemiBoldTextStyle,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center),
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
      id: widget.vendor.id.toString(),
    )
        .then((value) {
      setState(() {
        favorite = value;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(Languages.of(context).remove),
          behavior: SnackBarBehavior.floating,
        ));
      });
    });
  }

  Widget _favbutton({bool done = false}) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: _updateFavorite,
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            done ? Icons.favorite : Icons.favorite_border,
            color: done ? Colors.red.shade600 : Colors.white,
          )),
    );
  }

  Widget _shimmer() {
    return Shimmer.fromColors(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.red,
        ),
        baseColor: Colors.transparent,
        highlightColor: Colors.white);
  }
}
