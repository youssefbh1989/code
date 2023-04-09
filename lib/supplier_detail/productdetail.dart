import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:salonat/localisation/language/language.dart';
import 'package:salonat/models/service_filter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants.dart';




class Product_Detail extends StatefulWidget {
  final ServiceFilterModel product;
  const Product_Detail({Key key, this.product}) : super(key: key);

  @override
  State<Product_Detail> createState() => _Product_DetailState();
}

class _Product_DetailState extends State<Product_Detail> {


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {


    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/new/back.png"), fit: BoxFit.fill),
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: false,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(

          titleSpacing: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: whiteColor,
              size: 15.sp,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 30.h,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(   'http://salonat.qa/' +
                        widget.product.images[0].image,),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  color: blackColor.withOpacity(0.2),
                ),
              ),
              SizedBox(height: 2.h,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 1.h,vertical: 1.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(Languages.of(context).labelSelectLanguage=='English'?
                    ' QAR '+ widget.product.price:widget.product.price + 'رق ',
                      maxLines: 1,style: TextStyle(
                      fontSize: 12.sp,fontFamily: 'Calibri',color: whiteColor,
                    ),)
                  ],
                ),
              ),
              // Padding(
              //   padding:  EdgeInsets.symmetric(horizontal: 1.h,vertical: 1.w),
              //   child:                       ClipOval(child:
              //   widget.product.images[0] == null
              //       ? _shimmer()
              //       :CachedNetworkImage(
              //     imageUrl:
              //     'http://salonat.qa/' +
              //         widget.product.images[0].image,
              //     height: 24.h,
              //     width: 48.w,
              //     errorWidget: (_, __, ___) => Container(
              //       width: double.infinity,
              //       height: double.infinity,
              //       child: Icon(
              //         Icons.broken_image_outlined,
              //         size: 15.sp,
              //       ),
              //     ),
              //     fit: BoxFit.fill,
              //   ),
              //   ),
              //
              //
              // ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 1.h,vertical: 1.w),
                child: Column(
                  children: [
                    Html(
                      data: Languages.of(context).labelSelectLanguage ==
                          'English'
                          ? widget.product.description
                          : widget.product.descriptionAr,
                      style: {
                        "body": Style(
                          color: whiteColor,

                          fontWeight: FontWeight.bold,
                        ),
                        "li":Style(

                        )


                      },

                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }



  divider() {
    return Expanded(
      child: Container(
        color: whiteColor,
        height: 1,
        width: double.infinity,
      ),
    );
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
                      MaterialPageRoute(builder: (context) => const Product_Detail()),
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
                  padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
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

  waitDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (contxet) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 1.h),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          backgroundColor: Colors.white.withOpacity(0.15),
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
                        style: grey13RegularTextStyle,
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
