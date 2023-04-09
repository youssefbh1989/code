import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:salonat/controller/update_profile_picture.dart';
import 'package:salonat/localisation/language/language.dart';
import 'package:salonat/models/usermodel.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants.dart';
import '../../controller/user_controllet.dart';

import '../../services/api.dart';
import '../../services/apiservice.dart';
import '../../services/user.dart';
import '../bottom_bar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    Key key,
    this.profile,
  }) : super(key: key);
  final UserModel profile;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File personalPhoto;
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  Rx<File> coverImage = Rx<File>(null);

  Rx<File> image = Rx<File>(null);

  @override
  void InitState() {
    super.initState();
    Get.put(UpdateProfileController());

  }




  Future pickImage() async {

      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      final imageTemporary = File(image.path);
      setState(() {
        this.personalPhoto = imageTemporary;
      });


  }
  Future<void> pickCoverImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage.value = File(pickedFile.path);
    }
  }

  Future Takepicture() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      final imageTemporary = File(image.path);

      setState(() {
        this.personalPhoto = imageTemporary;
      });
    } on PlatformException catch (e) {}
  }

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _oldpasswordController = TextEditingController();
  final _newpasswordController = TextEditingController();

  bool _isloading = false;
  final bool _isRequesting = false;
  final bool _showAcceptError = false;
  List<UserModel> _userupdate = [];
  UserModel tempUser;
  final user = Get.find<UserController>().user;

  @override
  void initState() {
    final user = Get.find<UserController>().user;

    tempUser = widget.profile;
    _nameController.text = tempUser.name ?? '';
    _emailController.text = tempUser.email ?? '';
    _phoneNumberController.text = tempUser.phone ?? '';



    //user.name=_nameController.text;
    //_emailController.text=user.email;
    //_phoneNumberController.text=user.phone;

    print('youssef$tempUser');
    super.initState();
  }


  Future<void> updateProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {});
      _formKey.currentState?.save();
      try {
        final user = await UsersWebService().updateProfile(tempUser);
        Get.back();
        Get.snackbar(
          'Profile Update :',
          'Profile updated',
          snackPosition: SnackPosition.BOTTOM,
          colorText: primaryColor,
          backgroundColor: backgroundcolor,
        );
      } on DioError catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Error'),
                  content: Text(e.response?.data.toString() ??
                      'Something went wrong.\nPlease try again later'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Ok')),
                  ],
                )
        );
      } finally {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroundcolor,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,

          ),
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontSize:  API.isPhone ? 20.0 : 35.0,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 20),
          children: [
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                child: Container(
                  width: 124,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // border: Border.all(color: primaryColor, width: 2)
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Stack(
                    children: [
                      InkWell(
                          onTap: () => changeProfilePick(context),
                          child: personalPhoto != null
                              ? ClipOval(
                                  child: widget.profile.photo == null
                                      ? _shimmer()
                                      : Image.file(
                                          personalPhoto,
                                          height: 15.h,
                                          width: 35.w,
                                          fit: BoxFit.fill,
                                        ),
                                )
                              : ClipOval(
                                  child: CachedNetworkImage(
                                  imageUrl: 'https://salonat.qa/' +
                                      widget.profile.photo,
                                  errorWidget: (_, __, ___) => Container(
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
                                ))),
                      Positioned(
                        bottom: 0,
                        right: 5,
                        child: InkWell(
                          onTap: ()  {
                            pickImage();
                            Get.find<UpdateProfileController>().updateProfilePicture((personalPhoto));

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
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
              child: Container(
                //height: 30.h,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      onSaved: (txt) {
                        tempUser.name = txt;
                      },
                      cursorColor: primaryColor,
                      style: const TextStyle(
                          color: Colors.black, fontFamily: 'SFProRegular'),
                      decoration: InputDecoration(
                        floatingLabelStyle: TextStyle(
                          color: primaryColor,
                          fontSize:  API.isPhone ? 15.0 : 25.0,
                          fontFamily: 'SFPro',
                        ),
                        labelText: Languages.of(context).name,
                        labelStyle: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                        border: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 1.5)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 1.5)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 1.5)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      cursorColor: primaryColor,
                      onSaved: (txt) {
                        tempUser.email = txt;
                      },
                      style: const TextStyle(
                          color: Colors.black, fontFamily: 'SFProRegular'),
                      decoration: InputDecoration(
                        floatingLabelStyle: TextStyle(
                          color: primaryColor,
                         fontSize:  API.isPhone ? 15.0 : 25.0,
                          fontFamily: 'SFPro',
                        ),
                        labelText: Languages.of(context).email,
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: primaryColor),
                        border: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 1.5)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 1.5)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 1.5)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      cursorColor: primaryColor,
                      onSaved: (txt) {
                        tempUser.phone = txt;
                      },
                      style: const TextStyle(
                          color: Colors.black, fontFamily: 'SFProRegular'),
                      decoration: InputDecoration(
                        floatingLabelStyle:  TextStyle(
                          color: primaryColor,
                          fontSize:  API.isPhone ? 15.0 : 25.0,
                          fontFamily: 'SFPro',
                        ),
                        labelText: Languages.of(context).mobile,
                        labelStyle: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                        border: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 1.5)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 1.5)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 1.5)),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    TextButton(
                        onPressed: updateProfile,
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(primaryColor)),
                        child: Text(
                          Languages.of(context).update_profile,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize:  API.isPhone ? 15.0 : 30.0),
                        ))
                  ],
                ),
              ),
            ),
            /*Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
              child: InkWell(
                onTap: _update,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Text(Languages.of(context).update_profile,
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 15.sp,
                          fontFamily: 'Calibri')),
                ),
              ),
            ),*/
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextFormField(
                      controller: _oldpasswordController,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      cursorColor: primaryColor,
                      style: const TextStyle(
                          color: Colors.black, fontFamily: 'SFProRegular'),
                      decoration: InputDecoration(
                        floatingLabelStyle:  TextStyle(
                          color: primaryColor,
                          fontSize:  API.isPhone ? 15.0 : 25.0,
                          fontFamily: 'SFPro',
                        ),
                        labelText: Languages.of(context).currentpassword,
                        labelStyle: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                        border: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 1.5)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 1.5)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 1.5)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _newpasswordController,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      cursorColor: primaryColor,
                      style: const TextStyle(
                          color: Colors.black, fontFamily: 'SFProRegular'),
                      decoration: InputDecoration(
                        floatingLabelStyle:  TextStyle(
                          color: primaryColor,
                           fontSize:  API.isPhone ? 15.0 : 25.0,
                          fontFamily: 'SFPro',
                        ),
                        labelText: Languages.of(context).newpassword,
                        labelStyle: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                        border: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 1.5)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 1.5)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: greyColor, width: 1.5)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: _updatepassword,
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(primaryColor)),
                        child: Text(
                          Languages.of(context).update_profile,
                          style: TextStyle(
                              color: primaryColor, fontWeight: FontWeight.bold,
                              fontSize:  API.isPhone ? 15.0 : 30.0),
                        ))
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  changeProfilePick(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: whiteColor,
          child: Wrap(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 4.w),
                child: Column(
                  children: <Widget>[
                    Text(
                      Languages.of(context).ChooseOption,
                      textAlign: TextAlign.center,
                      style: black15SemiBoldTextStyle,
                    ),
                    heightSpace,
                    heightSpace,
                    InkWell(
                      onTap: () {
                        Takepicture();
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.camera_alt,
                            color: blackColor,
                            size: 20.sp,
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Text(
                            Languages.of(context).takepicture,
                            style: black14MediumTextStyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    InkWell(
                      onTap: () {
                        pickImage();
                        Navigator.of(context).pop();
                        setState(() {});
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.photo_library,
                            color: blackColor,
                            size: 20.sp,
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Text(
                            Languages.of(context).getfromgallery,
                            style: black14MediumTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _update() async {
    setState(() {});

    setState(() {});

    final join = await UsersWebService().update(
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneNumberController.text,
      image: personalPhoto.path,
    );

    _logoutupdateDialog();
  }

  Future<void> _updatepassword() async {
    try {
      final update = await UsersWebService().updatepassword(
        old_password: _oldpasswordController.text,
        new_password: _newpasswordController.text,
      );
      Get.back();
      Get.snackbar('Password Update', 'Your Password has been updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          colorText: primaryColor,
          backgroundColor: backgroundcolor);
    } on DioError catch (e) {
      print(e.response.toString());
      Get.snackbar('The given data was invalid', 'Password does not match',
          snackPosition: SnackPosition.BOTTOM,
          colorText: primaryColor,
          backgroundColor: backgroundcolor);

    }
  }



  _logoutupdateDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          backgroundColor: Colors.white.withOpacity(0.15),
          child: Container(
            height: 18.h,
            width: MediaQuery.of(context).size.width,
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
            child: Wrap(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.h, vertical: 1.w),
                        child: Center(
                          child: Text("Account has beed updated successully!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: blackColor,
                                  fontFamily: 'SFProDisplay-Bold',
                                  fontSize: 15.sp)),
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: InkWell(
                              //onTap: ()=>Navigator.pop(context),
                              onTap: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomBar())).then((_) => {}),
                              child: Container(
                                height: 5.h,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 1.h, vertical: 1.w),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  border: Border.all(color: primaryColor),
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryColor.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'OK',
                                  style: primaryColor18SemiBoldTextStyle,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
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
  /*_onImageTap({bool isProfilePicture = true}) {
    showModalBottomSheet(
        isScrollControlled: false,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            )),
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.fullscreen),

                  onTap: () {
                    Get.back();
                    _showImage('http://salonat.qa/' +
                        widget.profile.photo,
                   );
                  },
                  title: Text(
                      'See ${ 'profile picture' }'),
                ),
                const Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  onTap: () => _changePicture(),
                  title: Text(
                      'Change ${isProfilePicture ? 'profile picture' : 'cover photo'}'),
                ),
              ],
            ),
          );
        });
  }*/
 /* void _showImage(String path) {
    showImageViewer(context, CachedNetworkImageProvider(path));
  }*/
  /*_changePicture( ) async {
    final paths = await ImagePickers.pickerPaths(
      galleryMode: GalleryMode.image,
      showCamera: true,
      selectCount: 1,
    );

    Get.back();

  *//*  if (paths.isNotEmpty) {
      controller.setProfile(await controller.updatePhoto(paths.first.path!, isProfilePicture));
    }*//*
  }*/
}
