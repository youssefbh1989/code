import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:salonat/localisation/language/language.dart';
import 'package:salonat/models/favoritemodel.dart';
import 'package:salonat/services/api.dart';
import 'package:salonat/services/apiservice.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants.dart';
import '../../models/salonmodels.dart';
import '../common/screens/entity_details.dart';


class Favorites extends StatefulWidget {
  const Favorites({Key key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  TextEditingController _favcontroller = TextEditingController();
  double height;
  double width;

  List<FavoriteModel> _favorite = [];
  bool _isloading = true;
  bool favorite = false;

  @override
  void initState() {
   getfavdata();

    super.initState();
  }

  getfavdata(){
    WebService().getfavorites().then((value) {
      setState(() {
        _favorite = value;
        _isloading = false;
      });
    });


  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: backgroundcolor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor:  primaryColor,
          titleSpacing: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
                size: API.isPhone ? 20.0 : 25.0
            ),
          ),
          // actions: [
          //   PopupMenuButton<String>(
          //     color: whiteColor.withOpacity(0.5),
          //     shape: const RoundedRectangleBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(15.0))),
          //     icon: ClipOval(
          //         child: Languages.of(context).labelSelectLanguage == "English"?
          //         Image.asset('assets/new/england.png')
          //             :Image.asset('assets/new/qatar.png')
          //     ),
          //     onSelected: (String result) {
          //       changeLanguage(context, result);
          //     },
          //     itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          //       PopupMenuItem<String>(
          //         value: 'ar',
          //         child: Text('العربية',
          //             style: GoogleFonts.cairo(
          //                 fontWeight: FontWeight.w700, color: whiteColor)),
          //       ),
          //       PopupMenuItem<String>(
          //         value: 'en',
          //         child: Text('English',
          //             style: GoogleFonts.cairo(
          //                 fontWeight: FontWeight.w700, color: whiteColor)),
          //       ),
          //     ],
          //   ),
          // ],
          title: Text(
            Languages.of(context).Favorites,
            style: blackSemiBoldTextStyle,
          ),
        ),
        body: _favorite.isEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                child: favoriteListEmpty())
            : Padding(
                padding: EdgeInsets.symmetric(vertical: 2.w),
                child: favoritesList()));
  }

  favoriteListEmpty() {
    return _isloading
        ? const Center(
            child: CircularProgressIndicator(

              color: primaryColor,
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Icon(
                  Icons.favorite_border,
                  color: primaryColor,
                  size: 30.sp,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                Languages.of(context).favempty,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:  primaryColor,fontWeight: FontWeight.bold,
                  fontSize: 12.sp
                ),
              )
            ],
          );
  }

  favoritesList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _favorite.length,
      itemBuilder: (context, index) {
        final item = _favorite[index];
        return Slidable(

          actionPane:  SlidableDrawerActionPane(),
          actionExtentRatio: 0.45,


          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.w),
              child: IconSlideAction(

                caption: Languages.of(context).delete,
                color: primaryColor,
                icon: Icons.delete,
                foregroundColor: whiteColor,
                onTap: () {
                  setState(() {
                    _favcontroller.text = _favorite[index].id.toString();
                    _updateFavorite();
                    getfavdata();

                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(Languages.of(context).remove),
                  ));
                },
              ),
            ),

          ],

          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.w),
            child: InkWell(

              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EntityDetailScreen(
                    entity:
                    SalonModel.fromJson(_favorite[index].toJson()),
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
                              'https://salonat.qa/' + _favorite[index].image,
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
                                      ? _favorite[index].name
                                      : _favorite[index].name_ar,
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
                                    ? _favorite[index].address ?? ''
                                    : _favorite[index].address_ar ?? '')
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
                                              ? _favorite[index].address
                                              : _favorite[index].address_ar,
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
    );
  }
  _updateFavorite() {
    WebService().updateFav(id: _favcontroller.text.toString()).then((value) {
      setState(() {
        favorite = value;
      });
    });
  }
}
