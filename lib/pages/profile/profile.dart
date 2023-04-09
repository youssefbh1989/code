import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:salonat/models/usermodel.dart';
import 'package:salonat/pages/policy/privacy.dart';
import 'package:salonat/services/api.dart';
import 'package:salonat/services/user.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants.dart';
import '../../controller/profile_controller.dart';
import '../../localisation/language/language.dart';
import '../../widget/redirection_auth.dart';
import '../about/about.dart';
import '../auth/signin.dart';
import '../bottom_bar.dart';
import '../editProfile/edit_profile.dart';
import '../favorites/favorites.dart';
import '../notifications/notifications.dart';
import '../policy/policy.dart';
import '../splash.dart';

class Profile extends StatefulWidget {

   Profile({
    Key key,
    this.profile,
    String token,
  }) : super(key: key);

  final UserModel profile;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  double height;
  double width;

  logOut() async {
    await Hive.box('global').clear();
    await UsersWebService().logout();
    if (mounted) {
      setState(() {
        API.USER = null;
        API.token = null;
      });
    }
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BottomBar()));
  }

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
    if (API.USER != null) {
      return Scaffold(
            extendBodyBehindAppBar: true,
        backgroundColor: Color(0xfff6e3e3),
            appBar: AppBar(
              automaticallyImplyLeading: false,
            ),
            body:  ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 50),
                children: [


                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.w),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white10.withOpacity(0.80),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: blackColor.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 2.h,
                          ),
                          detail(
                            ontap: () =>
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditProfile(profile: widget.profile)),
                                ),
                            title: Languages
                                .of(context)
                                .account_information,
                            image: 'assets/profilepic/profile.png',
                            color: blackColor,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          detail(
                            ontap: () =>
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Favorites()),
                                ),
                            title: Languages
                                .of(context)
                                .Favorites,
                            image: 'assets/icons/favorite.png',
                            color: blackColor,
                          ),
                          SizedBox(
                            height: 2.h,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.w),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white10.withOpacity(0.80),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: blackColor.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 2.h,
                          ),
                          detail(
                            ontap: () =>
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (
                                          context) =>  Notifications()),
                                ),
                            title: Languages
                                .of(context)
                                .notifications,
                            image: 'assets/icons/notification.png',
                            color: blackColor,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          detail(
                            ontap: () =>
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const About()),
                                ),
                            title: Languages
                                .of(context)
                                .about,
                            image: 'assets/icons/app icon-03.png',
                            color: blackColor,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          detail(
                            ontap: () =>
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Policy()),
                                ),
                            title: Languages
                                .of(context)
                                .terms,
                            image: 'assets/icons/app icon-02.png',
                            color: blackColor,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          detail(
                            ontap: () =>
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Privacy()),
                                ),
                            title: Languages
                                .of(context)
                                .privacy,
                            image: 'assets/icons/app icon-01.png',
                            color: blackColor,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.w),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white10.withOpacity(0.80),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: blackColor.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 2.h,
                          ),
                          detail(
                            ontap: () => _signout(),
                            title: Languages
                                .of(context)
                                .logout,
                            image: 'assets/profilepic/logout.png',
                            color: greyColor,
                          ),
                          SizedBox(
                            height: 2.h,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.w),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white10.withOpacity(0.80),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: blackColor.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 2.h,
                          ),
                          detail(
                            ontap: _delete,
                            title: Languages
                                .of(context)
                                .deleteaccount,
                            image: 'assets/new/delete.png',
                            color: greyColor,
                          ),
                          SizedBox(
                            height: 2.h,
                          )
                        ],
                      ),
                    ),
                  )
                ],

            ));
    } else {
      return Redirection_auth() ;
    }


  }






  detail({String title, String image, Color color, Function ontap}) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 2.h,
        ),
        child: Row(
          children: [
            Image.asset(
              image,
              color: primaryColor,

              height:  API.isPhone ? 20.0 : 35.0,
              width:  API.isPhone ? 20.0 : 35.0,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
              child: Text(
                title,
                style: TextStyle(
                    color: primaryColor,
                    fontSize: API.isPhone ? 20.0 : 35.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Calibri'),
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size:  API.isPhone ? 20.0 : 35.0,
                color: primaryColor,

            )
          ],
        ),
      ),
    );
  }

  logoutDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          backgroundColor: Colors.white.withOpacity(0.15),
          child: Container(
              height: 25.h,
              width: double.infinity,
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                      child: Text('Are You Sure You Want To Logout?',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: const Color(0xFF222B45),
                            fontFamily: 'SFProDisplay-Bold',
                          )),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              height: 5.h,
                              color: whiteColor,
                              mouseCursor: MouseCursor.defer,
                              textColor: Colors.white,
                              minWidth: double.infinity,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Cancel",
                                style: primaryColor15BoldTextStyle,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Expanded(
                            flex: 2,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              height: 5.h,
                              color: whiteColor,
                              mouseCursor: MouseCursor.defer,
                              textColor: Colors.white,
                              minWidth: double.infinity,
                              onPressed: () {},
                              child: Text(
                                "Logout",
                                style: primaryColor15BoldTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }

  divider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
      color: greyColor,
      height: 1,
      width: double.infinity,
    );
  }

  void delete_account() async {
    await Hive.box('global').clear();
    await UsersWebService().deleteaccount();
      API.USER = null;
      API.token = null;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Splash()));
  }


  _signout() {
    showDialog(context: context, builder: (context) => AlertDialog(
      elevation: 2,
      backgroundColor: whiteColor,
      title:  Text('Sign Out',style: TextStyle(
          color:  primaryColor,
          fontWeight: FontWeight.bold
      ),),
      content: Text('Do you want to sign out?',
        style: TextStyle(
          color:  primaryColor,
        ),),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child:
        Text('No',style: TextStyle(
            color:  primaryColor

        ),)),
        TextButton(
            onPressed: () {
              logOut();

            },
            child:  Text('Yes',style: TextStyle(
                color:  primaryColor
            ),)),
      ],
    ));
  }
  _delete() {
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor:whiteColor,
      title:  Text('Delete',style: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold
      ),),
      content: Text('Do you want to delete your account?',
        style: TextStyle(
          color:  primaryColor,
        ),),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child:
        Text('No',style: TextStyle(
            color:  primaryColor

        ),)),
        TextButton(
            onPressed: () {
              delete_account;

            },
            child:  Text('Yes',style: TextStyle(
                color:  primaryColor
            ),)),
      ],
    ));
  }

}

class _ProfileContent extends StatelessWidget {
  final ScrollController scrollController;
  final ProfileController controller;
  final BuildContext context;
  final String image;

  const _ProfileContent({ this.scrollController,
    this.controller,
    this.context,
  this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 1.h,
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // border: Border.all(color: primaryColor, width: 2)
                ),
                padding: const EdgeInsets.all(4),
                child: ClipOval(
                  child: image == null
                      ? _shimmer()
                      : CachedNetworkImage(
                    imageUrl: 'http://salonat.qa/' +
                        image,
                    errorWidget: (_, __, ___) =>
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: Icon(
                            Icons.broken_image_outlined,
                            size: 15.sp,
                          ),
                        ),
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 150,
          child: InkWell(
            onTap: () {
              _changePicture();
            },
            child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: const Icon(
                  Icons.edit,
                  color: Colors.black45,
                  size: 20,
                )),
          ),
        ),
      ],
    );
  }
  _changePicture() async {
    final paths = await ImagePickers.pickerPaths(
      galleryMode: GalleryMode.image,
      showCamera: true,
      selectCount: 1,
    );

    Get.back();

    if (paths.isNotEmpty) {
      await controller.updatePhoto
        (paths.first.path,);
    }
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
