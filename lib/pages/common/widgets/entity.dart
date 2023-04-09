import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salonat/models/entity.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/constants.dart';
import '../../../localisation/language/language.dart';
import '../../../services/api.dart';
import '../../../services/apiservice.dart';

class Entity extends StatefulWidget {
  final EntityModel entity;

  const Entity({Key key, this.entity}) : super(key: key);

  @override
  State<Entity> createState() => _EntityState();
}

class _EntityState extends State<Entity> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 16,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  'https://salonat.qa/${widget.entity.image}',
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                  height: API.isPhone ? 200.0 : 400.0,

                ),
                Positioned(
                  bottom: 0,

                  child: Row(
                    children: [
                      Container(
                        height: 4.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.2)
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(left: 2.h),
                              child: Text(
                                widget.entity.rating?.toString() ?? '0.0',
                                style:  TextStyle(
                                    color: whiteColor,
                                    fontSize: API.isPhone ? 15.0 : 30.0,
                                    fontFamily: 'SFProDisplay-Bold'),
                              ),
                            ),
                            widthSpace,
                             Icon(
                              Icons.star_rounded,
                              color: yellowColor,
                              size: API.isPhone ? 30.0 : 45.0,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                Positioned(
                  right: 0,
                  child: _favbutton(done: favorite ? true : false),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipOval(
                      child: Image.network('https://salonat.qa/${widget.entity.cover}',
                      height: API.isPhone ? 50.0 : 100.0,
                      width: API.isPhone ? 50.0 : 100.0,
                      fit: BoxFit.fill,),
                    ),
                  )
                ),

              ],
            ),
            Padding(
              padding: EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                        widget.entity == null
                            ? ''
                            : Languages.of(context).labelSelectLanguage ==
                                    "English"
                                ? widget.entity.name
                                : widget.entity.nameAr,
                        style: TextStyle(
                            fontFamily: 'Calibri',
                            fontSize: API.isPhone ? 15.0 : 30.0,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.start),
                    subtitle: Text(
                        widget.entity.address == null
                            ? ''
                            : Languages.of(context).labelSelectLanguage ==
                                    "English"
                                ? widget.entity.address
                                : widget.entity.addressAr,
                        style: TextStyle(
                            fontFamily: 'Calibri',
                            fontSize: API.isPhone ? 15.0 : 30.0,
                            color: primaryColor,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.start),
                    trailing: widget.entity.type != 'Vendor' ||
                            widget.entity.type != 'Clinic'||widget.entity.type!='Artist'
                        ? Wrap(
                            children: [
                              widget.entity.service_available == 'At Home'
                                  ? Icon(
                                      Icons.home,
                                      color: primaryColor,
                                size: API.isPhone ? 30.0 : 45.0,
                                    )
                                  : Icon(
                                      Icons.home,
                                      color: primaryColor.withOpacity(.5),
                                size: API.isPhone ? 30.0 : 45.0,
                                    ),

                              widget.entity.service_available == 'At Salon'
                                  ? Icon(
                                      Icons.add_business,
                                      color: primaryColor,
                                size: API.isPhone ? 30.0 : 45.0,
                                    )
                                  : Icon(
                                      Icons.add_business,
                                      color: primaryColor.withOpacity(.5),
                                size: API.isPhone ? 30.0 : 45.0,
                                    ),
                              // Image.asset('assets/hair-salon.png',color: primaryColor,),
                            ],
                          )
                        : Text(''),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _updateFavorite() {
    if (API.USER == null) {
      return;
    }
    WebService()
        .updateFav(
      id: widget.entity.id.toString(),
    )
        .then((value) {
      setState(() {
        favorite = value;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: whiteColor,
          content: Text(favorite
              ? Languages.of(context).add
              : Languages.of(context).remove,style: TextStyle(
            color: primaryColor
          ),),
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
            color: done ? Colors.red.shade600 : primaryColor,
            size: API.isPhone ? 20.0 : 45.0,
          )),
    );
  }
}
