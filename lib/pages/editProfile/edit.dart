/*
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_pickers/image_pickers.dart';

import 'package:route_observer_mixin/route_observer_mixin.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/profile_controller.dart';
import '../../models/usermodel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key, this.user, this.profile}) : super(key: key);

  final UserModel user;
  final UserModel profile;

  @override
  createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with RouteAware, RouteObserverMixin {
  final _scrollController = ScrollController();

  bool _isMyProfile = false;

  @override
  void initState() {
    super.initState();

*/
/*    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final controller = Get.find<ProfileController>();
      //controller.setProfile(widget.user ?? Get.find<UserController>().user);
      _isMyProfile = controller.isMyProfile;
      _initForeignUser();
    });*//*



  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();

  }

  @override
  void didPush() {
    super.didPush();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileController>(builder: (controller) {
        return _ProfileContent(
          context: context,
          scrollController: _scrollController,
          controller: controller,
        );
      }),
    );
  }



  Future<void> _initForeignUser() async {
    final profileController = Get.find<ProfileController>();



    }
  }


class _ProfileContent extends StatelessWidget {
  final ScrollController scrollController;
  final ProfileController controller;
  final BuildContext context;

  const _ProfileContent(
      { this.scrollController,
         this.controller,
         this.context});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          _profileHeader(),
          const SizedBox(height: 10.0),

          const SizedBox(
            height: 10.0,
          ),

          const SizedBox(
            height: 10.0,
          ),

          if (controller.isFetchingPosts)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              ),
            )


        ],
      ),
    );
  }

  Widget _profileHeader() {

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 2),
          child: AspectRatio(
            aspectRatio: 1 / .40,
            child: GestureDetector(
              onTap: () => controller.isMyProfile
                  ? _onImageTap(isProfilePicture: false)
                  : _showImage(controller.profile.photo),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: controller.profile.photo ?? '',

                    errorWidget: (_, __, ___) => Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black,
                    ),
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  if (controller.isMyProfile)
                    Positioned(
                      bottom: 3.0,
                      right: 20.0,
                      child: Icon(
                        Icons.add_a_photo,
                        color: Colors.white60,
                        size: 35
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: .0,
          left: 10,
          child: GestureDetector(
            onTap: () => controller.isMyProfile
                ? _onImageTap()
                : _showImage(controller.profile.photo),
            child: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 1.0),
                    ),
                    margin: const EdgeInsets.only(right: 10.0),
                    child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: controller.profile.photo ?? '',

                          errorWidget: (_, __, ___) => Container(
                            width: 10,
                            height: 10,
                            color: Colors.black,
                          ),
                          width: 10,
                          height: 10,
                          fit: BoxFit.cover,
                        ))),
                if (controller.isMyProfile)
                  Positioned(
                    bottom: 6.0,
                    right: .0,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff0066FF),
                            ),
                            padding: EdgeInsets.all(1),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 30,
                            )),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
        Positioned(
            bottom:   -0.0 ,
            left: 240,
            child: Container(
                width: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100],
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo2.png',
                        height: 32,
                      ),

                    ],
                  ),
                )))
      ],
    );
  }









  _onImageTap({bool isProfilePicture = true}) {
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
                  enabled: (isProfilePicture &&
                      controller.profile?.photo != null) ||
                      (!isProfilePicture && controller.profile?.photo != null),
                  onTap: () {
                    Get.back();
                    _showImage(isProfilePicture
                        ? controller.profile.photo
                        : controller.profile.photo);
                  },
                  title: Text(
                      'See ${isProfilePicture ? 'profile picture' : 'cover photo'}'),
                ),
                const Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  onTap: () => _changePicture(isProfilePicture),
                  title: Text(
                      'Change ${isProfilePicture ? 'profile picture' : 'cover photo'}'),
                ),
              ],
            ),
          );
        });
  }

  void _showImage(String path) {
    showImageViewer(context, CachedNetworkImageProvider(path));
  }

  _changePicture(bool isProfilePicture) async {
    final paths = await ImagePickers.pickerPaths(
      galleryMode: GalleryMode.image,
      showCamera: true,
      selectCount: 1,
    );

    Get.back();

    if (paths.isNotEmpty) {
      await controller.updatePhoto(paths.first.path,'','');
    }
  }
}
*/
