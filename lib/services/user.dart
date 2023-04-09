import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:salonat/models/reviewmodel.dart';
import 'package:salonat/models/usermodel.dart';

import '../models/contactus.dart';
import 'api.dart';
import 'base.dart';

class UsersWebService extends BaseWebService {
  Future<UserModel> login({String mail, String password}) async {
    try {
      final data = {'email': mail, 'password': password};
      final response =
          (await dio.post('login', data: FormData.fromMap(data))).data;
      if (kDebugMode) {
        print(response['errors']);
      }
      if (kDebugMode) {
        print(response['user']);
      }
      API.token = response['token'];

      final user = UserModel.fromJson(response['user']);
      user.token = API.token;
      final box = Hive.box('global');
      await box.put('user', user);
      await box.put('token', API.token);

      return user;
    } on DioError catch (_) {}
  }

  Future<void> logout() async {
    final response = await dio.post('logout');
    if (kDebugMode) {
      print(response.statusCode);
    }
  }

  Future<void> deleteaccount() async {
    final response = await dio.delete('delete-account');
    print(response.statusCode);
  }

  Future<ContactusModel> contactus(
      {String email, String name, String subject, String message}) async {
    final data = {
      'email': email,
      'name': name,
      'subject': subject,
      'message': message
    };

    final response =
        (await dio.post('contactUs', data: FormData.fromMap(data))).data;
  }

  Future<UserModel> signup(
      {String email,
      String name,
      String phone,
      String password,
      String confirmpsw}) async {
    {
      final data = {
        'email': email,
        'name': name,
        'phone': phone,
        'password': password,
        'password_confirmation': confirmpsw
      };

      final response =
          (await dio.post('register', data: FormData.fromMap(data))).data;

      API.token = response['token'];

      final user = UserModel.fromJson(response['user']);

      user.token = API.token;

      final box = Hive.box('global');
      await box.put('user', user);
      await box.put('token', API.token);
      return user;
    }
  }

  Future<UserModel> verificationmail({String verification_code}) async {

    try {
      final response = (await dio.post('verifyPhone/$verification_code')).data;
    }
    on DioError catch (e){
      print('youssef${e.response.statusMessage}');
    }

  }

  void tryToken(String token) {}

  Future<UserModel> update(
      {String email, String name, String phone, String image}) async {
    final data = {
      'email': email,
      'name': name,
      'phone': phone,
      'image': image,
    };

    final response =
        (await dio.post('updateProfile', data: FormData.fromMap(data))).data;

    return UserModel.fromJson(response['user']);
  }

  Future<UserModel> updatepassword({
    String old_password,
    String new_password,
  }) async {
    final data = {
      'old_password': old_password,
      'password': new_password,
    };

    final response =
        (await dio.post('updatePassword', data: FormData.fromMap(data))).data;
    print(response);
  }

  Future<ReviewModel> addreview({
    String review,
    String salon_id,
    String rating,
  }) async {
    final data = {
      'review': review,
      'rating': rating,
      'salon_id': salon_id,
    };

    final response =
        (await dio.post('review', data: FormData.fromMap(data))).data;
  }

  Future<UserModel> email_verification({
    String code,
    String email,
  }) async {
    final data = {
      'email': email,
    };

    final response =
        (await dio.post('forgotPassword', data: FormData.fromMap(data))).data;
  }

  Future<UserModel> resendcode({
    String code,
    String email,
  }) async {
    final data = {
      'email': email,
    };

    final response =
        (await dio.post('forgotPassword', data: FormData.fromMap(data))).data;
  }

  Future<UserModel> code_verification({
    String code,
    String email,
  }) async {
    final data = {
      'email': email,
      'code': code,
    };
  try {
  final response = (await dio.post('verifyCode', data: FormData.fromMap(data)))
      .data;
  print(response);
}on DioError catch(e){
    print(e.message);
  }

  }

  Future<UserModel> new_password_user({
    String password,
    String password_confirmation,
    String email,
  }) async {
    final data = {
      'password': password,
      'password_confirmation': password_confirmation,
      'email': email
    };

    final response =
        (await dio.post('resetPassword', data: FormData.fromMap(data))).data;
  }

  Future<void> resend_code() async {
    final response = (await dio.get('resendSendPhoneCode'));
    if (kDebugMode) {}
  }
  Future<UserModel> updateProfile(UserModel user) async {
    try {

      final response = (await dio.post('updateProfile',
          data: user.toRequest())).data;
      final User = UserModel.fromJson(response['user']);
      print(User);

      print("youssef${response}");
    }catch  (e){

    }

  }
  Future<void> updateProfilepicture(String path,String name,String email,String mobile) async {
    final data = {
      'path': path,
      'name':name,
      'email':email,
      'mobile':mobile
    };

    try {
      final response = (await dio.post('updateProfile',data:data )).data;

      print("youssef${response}");
    }catch  (e){
      print(e);

    }

  }
  Future<UserModel> getUser(int userId) async {
    final response = (await dio.get('user/$userId')).data;
    return UserModel.fromJson(response['user']);
  }
  Future<String> updatePasswd(String old, String passwd) async {
    try {
      final response = (await dio.post('updatePassword',
          data: {'old_password': old, 'password': passwd}))
          .data;
      if (!response['message'].toString().contains('successfully')) {
        return response['message'];
      }
    } on DioError catch (e) {
      if (e.response.data != null) {
        return e.response.data['message'];
      }

      return 'Something went wrong. Please try again later';
    }
    return null;
  }
  Future<void> cancelappointement(String id) async {
    final response = await dio.post('cancelAppointment/$id');
    if (kDebugMode) {
      print(response.statusCode);
    }
  }
  Future<Map<String, dynamic>> updatePhoto(
      String path, ) async {
    final formData = FormData();
    formData.files.add(MapEntry( 'image' ,await MultipartFile.fromFile(path)));
    print('here');

  }
}
