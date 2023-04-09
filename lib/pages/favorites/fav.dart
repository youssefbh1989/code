
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:salonat/localisation/language/language.dart';
import 'package:salonat/models/favoritemodel.dart';
import 'package:salonat/models/salonmodels.dart';
import 'package:salonat/models/usermodel.dart';
import 'package:salonat/pages/cart_screen.dart';
import 'package:salonat/pages/common/screens/entity_details.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants.dart';
import '../../services/api.dart';
import '../../services/apiservice.dart';
import '../../widget/redirection_auth.dart';
import '../auth/signin.dart';

class Fav extends StatefulWidget {
  const Fav({Key key, UserModel profile, String token}) : super(key: key);

  @override
  State<Fav> createState() => _FavState();
}

class _FavState extends State<Fav> {
  double height;
  double width;
  List<FavoriteModel> _favorites = [];
  bool _isloading = true;
  bool favorite = false;
  TextEditingController _favcontroller = TextEditingController();

  @override
  void initState() {
    getdatafav();
    super.initState();
  }

  Future getdatafav() async {
    WebService().getfavorites().then((value) {
      if (mounted) {
        setState(() {
          _favorites = value;
          _isloading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _favorites;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return API.USER != null
        ? Scaffold(
            backgroundColor: Color(0xfff6e3e3),
            extendBodyBehindAppBar: false,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                if (API.USER != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                      onTap: () => Get.to(() => const CartScreen()),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Badge(
                            label: Text(
                              Hive.box('cart').length.toString(),
                              style: TextStyle(color: whiteColor, fontSize: 13),
                            ),

                            //showBadge: Hive.box('cart').isNotEmpty,
                            child: const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Icon(
                                Icons.shopping_cart_outlined,
                                color: whiteColor,
                                size: 25,
                              ),
                            )),
                      ),
                    ),
                  )
              ],
            ),
            body: _favorites.isEmpty ? favoriteListEmpty() : favoritesList(),
          )
        : Redirection_auth();
  }

  favoriteListEmpty() {
    return _isloading
        ?  Center(
            child: CircularProgressIndicator(
            color: primaryColor,
          ))
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               const Center(
                child: Icon(
                  Icons.favorite_border,
                  color: primaryColor,
                  size: 50,
                ),
              ),
              heightSpace,
              heightSpace,
              heightSpace,
              heightSpace,
              Text(
                Languages.of(context).favempty,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          );
  }

  favoritesList() {
    return _isloading
        ? const Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          )
        : RefreshIndicator(
      color: primaryColor,
          onRefresh: ()async{
        await getdatafav();
          },
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 0.h, vertical: 0.w),
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final item = _favorites[index];
                return Slidable(

                  actionPane: const SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  secondaryActions: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0.h, vertical: 1.w),
                      child: IconSlideAction(
                        caption: Languages.of(context).delete,
                        color: primaryColor,
                        icon: Icons.delete,
                        foregroundColor: whiteColor,
                        onTap: () {
                          setState(() {
                            _favcontroller.text = _favorites[index].id.toString();
                            _updateFavorite();
                             getdatafav();
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: whiteColor,
                            content: Text(Languages.of(context).remove,style: TextStyle(
                              color: primaryColor,fontWeight: FontWeight.bold
                            ),),
                            behavior: SnackBarBehavior.floating,
                          ));
                        },
                      ),
                    ),
                  ],
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.w),
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EntityDetailScreen(
                            entity:
                                SalonModel.fromJson(_favorites[index].toJson()),
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
                                      'https://salonat.qa/' + _favorites[index].image,
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
                                              ? _favorites[index].name
                                              : _favorites[index].name_ar,
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
                                            ? _favorites[index].address ?? ''
                                            : _favorites[index].address_ar ?? '')
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
                                                      ? _favorites[index].address
                                                      : _favorites[index].address_ar,
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
