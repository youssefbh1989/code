import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:salonat/constants/constants.dart';
import 'package:salonat/localisation/language/language.dart';
import 'package:salonat/models/entity.dart';
import 'package:salonat/pages/common/screens/entity_details.dart';
import 'package:sizer/sizer.dart';

class NearbyMapCard extends StatelessWidget {
  const NearbyMapCard({Key key, this.entity}) : super(key: key);
  
  final EntityModel entity;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EntityDetailScreen(
              entity: entity,
            ),
          ),
        ),
        child: Container(
          height: 16.h,
          decoration: BoxDecoration(
            color: Colors.white10.withOpacity(0.80),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2),
                color: blackColor.withOpacity(0.1),
                spreadRadius: 1.5,
                blurRadius: 1.5,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 16.h,
                decoration: BoxDecoration(
                  color: backgroundcolor,
                  borderRadius:
                  Languages.of(context).labelSelectLanguage == 'English'
                      ? const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10))
                      : const BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: CachedNetworkImage(imageUrl: 'https://salonat.qa/' +
                    entity.image,
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 1.0.w),
                      child: Text(
                          Languages.of(context).labelSelectLanguage == 'English'
                              ? entity.name
                              : entity.nameAr,
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 15.sp,
                              fontFamily: 'Calibri_bold'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Row(
                      children: [
                        Icon(Icons.place, color: primaryColor, size: 15.sp),
                        SizedBox(
                          width: 1.5.h,
                        ),
                        Flexible(
                          child: Text(
                            entity.address == null
                                ? ''
                                : Languages.of(context).labelSelectLanguage ==
                                'English'
                                ? entity.address
                                : entity.addressAr,
                            style: TextStyle(
                                color: primaryColor,
                                fontFamily: 'Calibri',
                                fontSize: 12.sp),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: yellowColor,
                          size: 20.sp,
                        ),
                        widthSpace,
                        Text(
                          '${entity.rating} '
                              '${entity.totalUserRated} '
                              '' +
                              Languages.of(context).Review,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Calibri',
                              color: primaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
