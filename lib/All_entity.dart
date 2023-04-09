import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:salonat/pages/common/screens/entity_details.dart';
import 'package:salonat/pages/common/screens/entity_details_supplier.dart';
import 'package:salonat/services/apiservice.dart';
import 'package:sizer/sizer.dart';

import 'constants/constants.dart';
import 'localisation/language/language.dart';
import 'models/salonmodels.dart';
import 'services/api.dart';

class All_entity extends StatefulWidget {
  const All_entity({Key key, this.type, this.title}) : super(key: key);

  final String type;
  final String title;
  @override
  _All_entityState createState() => _All_entityState();
}

class _All_entityState extends State<All_entity> {
  bool _isLoading = false;
  List<SalonModel> _items = [];
  ScrollController _scrollController = ScrollController();
  int page = 0;
  double height;
  double width;

  @override
  void initState() {
    super.initState();
    _loadMore();
    print(widget.type);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMore();

      }

    });
  }

  @override
  void dispose(){
    super.dispose();
    _scrollController.dispose();
  }

  Future<void> _loadMore() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        WebService().getsalon(type: widget.type, page: page).then((value) {
          if (mounted) {
            setState(() {
              _items = _items + value;
              print(_items);
              page = page+1 ;
              _isLoading = false;
            });
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title.toString()),
        elevation: 0,
        backgroundColor: primaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: whiteColor,
            )),
      ),
      backgroundColor: backgroundcolor,

      body: _items.isEmpty?Center(child: CircularProgressIndicator(
        color: primaryColor,

      ),):RefreshIndicator(

        onRefresh: () async {
          await _loadMore();
        },
        color: primaryColor,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _isLoading ? _items.length + 1 : _items.length,
          itemBuilder: (context, index) {
            if (index == _items.length) {
              return Center();
            }
            return Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.w),
              child: InkWell(
                onTap: () => _items[index].type == 'Vendor'
                    ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EntityDetailScreenSupplier(
                          entity: SalonModel.fromJson(
                              _items[index].toJson()),
                        ),
                  ),
                )
                    : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EntityDetailScreen(
                      entity: SalonModel.fromJson(
                          _items[index].toJson()),
                    ),
                  ),
                ),
                child: Container(
                  height: 16.h,
                  width: 25.w,
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
                  child: Container(
                    height: 16.h,
                    width: 25.w,
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
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 0,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  'https://salonat.qa/' +_items[index].image,
                                  fit: BoxFit.fill,
                                  height: height,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4.w,
                                  vertical: 2.h,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Languages.of(context).labelSelectLanguage == 'English'
                                          ? _items[index].name
                                          : _items[index].nameAr,
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontFamily: 'Calibri_bold',
                                        fontSize: API.isPhone ? 15.0 : 30.0,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 1.h),
                                    if ((Languages.of(context).labelSelectLanguage == 'English'
                                        ? _items[index].address ?? ''
                                        : _items[index].addressAr ?? '')
                                        .isNotEmpty)
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.place,
                                            size: API.isPhone ? 15.0 : 30.0,
                                            color: primaryColor,
                                          ),
                                          SizedBox(width: 1.w),
                                          Flexible(
                                            fit: FlexFit.loose,
                                            child: Text(
                                              Languages.of(context).labelSelectLanguage == 'English'
                                                  ? _items[index].address
                                                  : _items[index].addressAr,
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontSize: API.isPhone ? 15.0 : 30.0,
                                                fontFamily: 'Calibri',
                                              ),
                                              maxLines: 2,
                                              softWrap: false,
                                              overflow: TextOverflow.fade,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
