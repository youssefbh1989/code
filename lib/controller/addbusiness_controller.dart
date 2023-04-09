import 'dart:io';


import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salonat/constants/constants.dart';
import 'package:salonat/services/apiservice.dart';

import '../models/addbusinessmodel.dart';
import '../pages/bottom_bar.dart';


class PlaceFormController extends GetxController {

  final type = TextEditingController();
  final name = TextEditingController();
  final arabicName = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final crCopy = TextEditingController();
  final password = TextEditingController();
  final passwordConfirmation = TextEditingController();
  final _placeService  = WebService();

  Rx<File> image = Rx<File>(null);
  Rx<File> coverImage = Rx<File>(null);
  Rx<File> crcopy = Rx<File>(null);
  var isLoading = false.obs;

  final _picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  Future<void> pickCoverImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage.value = File(pickedFile.path);
    }
  }
  Future<void> pickCrcopy() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      crcopy.value = File(pickedFile.path);
    }
  }

  void save() async {
    try {
      // Show a waiting dialog
      Get.dialog(Center(child: CircularProgressIndicator(color: primaryColor,
        backgroundColor: Colors.transparent,)), barrierDismissible: false);

      final place = Busniss(
          type: type.value.text,
          name: name.value.text,
          arabicName: arabicName.value.text,
          email: email.value.text,
          phone: phone.value.text,
          cr_number: crCopy.value.text,
          password: password.value.text,
          passwordConfirmation: passwordConfirmation.value.text
      );
      final formData = dio.FormData.fromMap({
        'type': place.type,
        'name': place.name,
        'name_ar': place.arabicName,
        'email': place.email,
        'phone': place.phone,
        'cr_copy': place.cr_copy,
        'cr_number':place.cr_number,
        'password': place.password,
        'password_confirmation': place.passwordConfirmation,
        'image': await dio.MultipartFile.fromFile(image.value.path),
        'cover': await dio.MultipartFile.fromFile(coverImage.value.path),
        'cr_copy': await dio.MultipartFile.fromFile(crcopy.value.path),
      });
      final response =  await _placeService.createPlace(formData);
      print(response);

      // Close the waiting dialog
      Get.back();

      Get.snackbar(
        'Success',
        ' ${response.data['message']}',
        backgroundColor: Colors.green,
        duration: Duration(seconds: 5),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading.value = false;
      Get.off((()=>BottomBar()));
    } on DioError catch (e) {
      // Close the waiting dialog
      Get.back();

      final message = e.response.data['errors'];

      Get.snackbar(
        'Error',
        message,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 5),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }



  @override
  void dispose() {
    type.dispose();
    name.dispose();
    arabicName.dispose();
    email.dispose();
    phone.dispose();
    crCopy.dispose();
    password.dispose();
    passwordConfirmation.dispose();
    super.dispose();
  }
}
