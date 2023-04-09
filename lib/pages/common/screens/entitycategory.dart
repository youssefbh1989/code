import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/constants.dart';
import '../../../localisation/language/language.dart';
import '../../../models/cat.dart';
import '../../../models/salonmodels.dart';
import '../../../models/slider_model.dart';
import '../../../services/api.dart';
import '../../../services/data_repository.dart';
import '../../../widget/slider_clinics.dart';
import '../widgets/entity_card.dart';
import 'entity_details.dart';
import 'entity_details_supplier.dart';
import 'liste_entity.dart';

class Entity_Category extends StatefulWidget {
  const Entity_Category({
    Key key,
    this.title,
    this.titre,
    this.slider,
    this.categories,
    this.categorie_id,
  }) : super(key: key);
  final String title;
  final String titre;
  final SliderModel slider;
  final Cat categories;
  final String categorie_id;

  @override
  State<Entity_Category> createState() => _Entity_CategoryState();
}

class _Entity_CategoryState extends State<Entity_Category> {
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    final dataProvider = Provider.of<DataReposotory>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xFFFFECF2),
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.titre.toString()),
        backgroundColor: primaryColor,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: SingleChildScrollView(
        child:    Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: whiteColor,
              gradient:
              LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFECF2),
                    whiteColor,
                    whiteColor,
                    whiteColor
                  ],
                  stops: [
                    .2,
                    .4,
                    .6,
                    .8
                  ]
              )
          ),
          child: Column(
            children: [
              SizedBox(
                height: 0.5.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.5.h),
                child: Banners(
                  slider: widget.title == 'Salon'
                      ? (dataProvider.slidersalon ?? []).isNotEmpty
                          ? dataProvider.slidersalon
                          : List.generate(3, (index) => null)
                      : widget.title == 'Clinic'
                          ? (dataProvider.sliders ?? []).isNotEmpty
                              ? dataProvider.sliders
                              : List.generate(3, (index) => null)
                          : widget.title == 'Vendor'
                              ? (dataProvider.slidervendorlist ?? []).isNotEmpty
                                  ? dataProvider.slidervendorlist
                                  : List.generate(3, (index) => null)
                              :  widget.title == 'Fitness'?
                                    List.generate(3, (index) => null)
                                  : (dataProvider.sliderartistlist ?? []).isNotEmpty
                                  ? dataProvider.sliderartistlist
                                  : List.generate(3, (index) => null),
                ),
              ),
              widget.title == 'Fitness'?
             Center(
        child:Text('In Progress',style: TextStyle(
          color: primaryColor,fontWeight: FontWeight.bold,
          fontSize: API.isPhone ? 25.0 : 38.0
        ),),
    ):
              widget.title == 'Artist'
                  ? Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: dataProvider.artist.length,
                  itemBuilder: (context, index) {
                    final item = dataProvider.artist[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.w),
                      child: InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EntityDetailScreen(
                              entity:
                              SalonModel.fromJson(dataProvider.artist[index].toJson()),
                            ),
                          ),
                        ),


                        child: Container(
                          height: 16.h,
                          width: 25.w,
                          decoration: BoxDecoration(
                            color: Colors.white10.withOpacity(0.8),
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
                                          'https://salonat.qa/' + dataProvider.artist[index].image,
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
                                                  ? dataProvider.artist[index].name
                                                  : dataProvider.artist[index].nameAr,
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
                                                ? dataProvider.artist[index].address ?? ''
                                                : dataProvider.artist[index].addressAr ?? '')
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
                                                          ? dataProvider.artist[index].address
                                                          : dataProvider.artist[index].addressAr,
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
              )
                  : widget.title == 'Vendor'
                      ? Expanded(
                        child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: dataProvider.vendorList.length,
                itemBuilder: (context, index) {
                  final item = dataProvider.vendorList[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.w),
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EntityDetailScreenSupplier(
                            entity:
                            SalonModel.fromJson(dataProvider.vendorList[index].toJson()),
                          ),
                        ),
                      ),

                        child: Container(
                          height: 16.h,
                          width: 25.w,
                          decoration: BoxDecoration(
                            color: Colors.white10.withOpacity(0.8),
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
                                          'https://salonat.qa/' + dataProvider.vendorList[index].image,
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
                                                  ? dataProvider.vendorList[index].name
                                                  : dataProvider.vendorList[index].nameAr,
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
                                                ? dataProvider.vendorList[index].address ?? ''
                                                : dataProvider.vendorList[index].addressAr ?? '')
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
                                                          ? dataProvider.vendorList[index].address
                                                          : dataProvider.vendorList[index].addressAr,
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
                      )
                      : StaggeredGridView.countBuilder(
                          physics: const BouncingScrollPhysics(),
                          crossAxisCount: 4,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                          shrinkWrap: true,
                          itemCount: widget.categories.services.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.h, vertical: 1.w),
                              child: InkWell(
                                  onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Liste_entity(
                                              title: widget.title.toString(),
                                              titre: widget.titre.toString(),
                                              categorie_id: widget
                                                  .categories.services[index].id
                                                  .toString(),
                                              title_categories: widget
                                                  .categories
                                                  .services[index]
                                                  .name
                                                  .toString()),
                                        ),
                                      ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      widget.categories.services[index].image ==
                                              null
                                          ? Icon(Icons.broken_image_outlined)
                                          : Image.network(
                                              'https://salonat.qa/' +
                                                  widget.categories
                                                      .services[index].image
                                                      .toString(),
                                              color: primaryColor,
                                              height: 6.h,
                                              width: 12.w,
                                              fit: BoxFit.contain,
                                            ),
                                      heightSpace,
                                      Text(
                                        Languages.of(context)
                                                    .labelSelectLanguage ==
                                                "English"
                                            ? widget
                                                .categories.services[index].name
                                            : widget.categories.services[index]
                                                .nameAr,
                                        style: TextStyle(
                                            color: blackColor,
                                            fontSize: API.isPhone ? 15.0 : 20.0,
                                            fontFamily: 'SFProDisplay-Bold'),
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  )),
                            );
                          },
                        )
            ],
          ),
        ),
      ),
    );
  }
}
