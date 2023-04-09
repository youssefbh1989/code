import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/usermodel.dart';
import '../services/user.dart';

class ProfileController extends GetxController {
  UserModel profile;
  bool isMyProfile = false;
  bool isFetchingPosts = true;
  bool isLoadingMore = false;
  bool canLoadMore = true;
  bool isLoadingBlockedUsers = false;
  int page = 0;
  Future<void> updatePhoto(String path ) async {
    final response = await UsersWebService().updatePhoto(path);
    return response;
  }


}
