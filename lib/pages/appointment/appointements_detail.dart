import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:salonat/column/Columnbuilder.dart';
import 'package:salonat/models/appointments.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants.dart';
import '../../localisation/language/language.dart';


class Appointements_detail extends StatefulWidget {
  const Appointements_detail({Key key, this.appointement}) : super(key: key);

  final AppointmentsModel appointement;

  @override
  State<Appointements_detail> createState() => _Appointements_detailState();
}

class _Appointements_detailState extends State<Appointements_detail> {
  bool _isloading = true;
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: [],
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 15.sp,
          ),
        ),
      ),
      body: Container(
          child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              'https://salonat.qa/' + widget.appointement.image,
                          height: 25.h,
                          width: double.infinity,
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
                      ],
                    )),
                  ],
                ),
                SizedBox(height: 1.h,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: primaryColor,
                          size: 20.sp,
                        ),
                        Text(
                          widget.appointement.name,
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 15.sp,
                              fontFamily: 'Calibri'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    widget.appointement.address == null
                        ? Row()
                        : Row(
                            children: [
                              Icon(
                                Icons.place,
                                color: primaryColor,
                                size: 15.sp,
                              ),
                              Flexible(
                                child: Text(widget.appointement.address,
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 15.sp,
                                        fontFamily: 'Calibri'),
                                    maxLines: 1,
                                    overflow: TextOverflow.clip),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Price :',
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 15.sp,
                                fontFamily: 'Calibri_bold')),
                        Text(
                            widget.appointement.appointmentservices[0]
                                    .finalPrice +
                                ' QAR',
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 15.sp,
                                fontFamily: 'Calibri')
                        ),

                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Status :',
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 15.sp,
                                fontFamily: 'Calibri_bold')),
                        Text(widget.appointement.status,
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 15.sp,
                                fontFamily: 'Calibri')),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Payment Methods :',
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 15.sp,
                                fontFamily: 'Calibri_bold')),
                        Text(widget.appointement.paymentMethod,
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 15.sp,
                                fontFamily: 'Calibri')),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0.h, vertical: 0.w),
                      child: Divider(
                        thickness: 1,
                        color: primaryColor,
                        height: 2.h,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Reference ID :',
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 15.sp,
                                fontFamily: 'Calibri_bold'),
                          ),
                          Text(widget.appointement.referenceId,
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12.sp,
                                  fontFamily: 'Calibri')),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0.h, vertical: 0.w),
                      child: Divider(
                        thickness: 1,
                        color: primaryColor,
                        height: 2.h,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          services()
        ],
      )),
    );
  }

  services() {
    return SizedBox(
      child: ColumnBuilder(
        itemCount: widget.appointement.appointmentservices.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white10.withOpacity(0.80),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 2),
                      color: blackColor.withOpacity(0.1),
                      spreadRadius: 1.5,
                      blurRadius: 1.5,
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(
                      Languages.of(context).labelSelectLanguage == 'English'
                          ? widget.appointement.appointmentservices[0].name
                          : widget.appointement.appointmentservices[0].nameAr,
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 15.sp,
                          fontFamily: 'Calibri_bold',
                          fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  trailing: Text(
                      widget.appointement.appointmentservices[0].price + ' QAR',
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 15.sp,
                          fontFamily: 'Calibri'),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                )),
          );
        },
      ),
    );
  }
}
