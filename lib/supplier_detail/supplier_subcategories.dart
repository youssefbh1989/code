import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:salonat/services/apiservice.dart';
import 'package:salonat/supplier_detail/productdetail.dart';
import 'package:sizer/sizer.dart';
import '../constants/constants.dart';
import '../models/service_filter.dart';

class Subcategories_Services extends StatefulWidget {
  final String salonid;
  final String categories;
  final String categorie_name;
  const Subcategories_Services(
      {Key key, this.salonid, this.categories, this.categorie_name})
      : super(key: key);

  @override
  State<Subcategories_Services> createState() => _Subcategories_ServicesState();
}

class _Subcategories_ServicesState extends State<Subcategories_Services> {
  bool _isloading = false;
  bool isSelected = false;
  List<ServiceFilterModel> _subcategories = [];

  void initState() {
    _isloading = true;
    getdata();
    super.initState();
  }

  getdata() {
    WebService()
        .getfil(
            category_id: widget.categories,
            salon_id: widget.salonid.toString(),
            max: '',
            min: '',
            search: '',
            type: '')
        .then((value) {
      if (mounted)
        setState(() {
          _subcategories = value;
          _isloading = false;
          if (kDebugMode) {
            print(_subcategories);
          }
          _isloading = false;
        });
    });
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
        appBar: AppBar(

          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: whiteColor,
              size: 15.sp,
            ),
          ),
          title: Text(widget.categorie_name,
              style: TextStyle(
                  color: whiteColor,
                  fontSize: 15.sp,
                  fontFamily: 'Calibri_bold')),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
          child: _isloading
              ? Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                )
              : ListView.builder(
                  itemCount: _subcategories.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Product_Detail(
                                product: _subcategories[index],
                              ),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
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
                              _subcategories[index].name,
                              style: TextStyle(
                                  color: isSelected == true
                                      ? primaryColor
                                      : blackColor,
                                  fontFamily: 'Calibri',
                                  fontSize: 12.sp),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text('more',style: TextStyle(color: primaryColor,fontSize: 10.sp,
                                fontFamily:'Calibri' )),
                            trailing: Text(
                              '${_subcategories[index].price.toString()} QAR',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontFamily: 'Calibri',
                                  fontSize: 10.sp),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}
