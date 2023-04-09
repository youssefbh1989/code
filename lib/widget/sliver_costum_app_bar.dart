import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salonat/widget/background_widget.dart';
import 'package:share/share.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';
import '../localisation/language/language.dart';
import '../models/salonmodels.dart';

class CustomSliverAppBar extends StatelessWidget {
  final SalonModel salon;
  const CustomSliverAppBar({Key key, this.salon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      expandedHeight: 30.h,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
          image: DecorationImage(
            image: NetworkImage('http://salonat.qa/' + salon.cover),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          color: blackColor.withOpacity(0.2),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(10.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Expanded(
                flex: 2,
                child: ClipOval(
                  child: salon.image == null
                      ? _shimmer()
                      : CachedNetworkImage(
                    imageUrl: 'http://salonat.qa/' + salon.image,
                    height: 12.h,
                    width: 18.w,
                    errorWidget: (_, __, ___) => Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Icon(
                        Icons.broken_image_outlined,
                        size: 15.sp,
                      ),
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),

              Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 1.w),
                            child: RichText(
                                maxLines: 2,
                                overflow: TextOverflow.fade,
                                text: TextSpan(
                                  text: Languages.of(context).labelSelectLanguage ==
                                      'English'
                                      ? salon.name
                                      : salon.nameAr,
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontFamily: 'Calibri_bold',
                                      fontSize: 15.sp),
                                )),
                          ),
                        ],
                      ),
                      salon.totalUserRated.toString()!='0'?Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: yellowColor,
                            size: 20.sp,
                          ),
                          widthSpace,
                          Text(
                            salon == null
                                ? const Center()
                                : '${salon.rating} ${(salon.totalUserRated)} ' +
                                Languages.of(context).Review,
                            style: TextStyle(
                                color: whiteColor,
                                fontSize: 12.sp,
                                fontFamily: 'Calibri_bold'),
                          ),
                        ],
                      ):Center()
                    ],
                  )),


            ],
          ),
        ),
      ),
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
