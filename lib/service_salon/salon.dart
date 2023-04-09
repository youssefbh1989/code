import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:salonat/service_salon/api.dart';
import 'package:salonat/service_salon/base.dart';
import 'package:salonat/service_salon/shared_salon.dart';
import '../models/SalonModel.dart';

class SalonWebService extends BaseWebService {
  Future<SalonM> login({String mail, String password}) async {
    try {
      final data = {'email': mail, 'password': password};
      final response =
          (await dio.post('login', data: FormData.fromMap(data))).data;
      print(response['message']);
      API.token = response['token'];
      SharedPref.SaveToken(API.token);
      return SalonM.fromJson(response['salon']);
    } on DioError {
      rethrow;
    }
  }

  Future<void> logout() async {
    final response = await dio.post('logout');
  }

  Future<SalonM> updatepassword({
    String old_password,
    String new_password,
  }) async {
    final data = {
      'old_password': old_password,
      'password': new_password,
    };
    try {
      final response =
          (await dio.post('updatePassword', data: FormData.fromMap(data))).data;
    } on DioError catch(e){
      if (kDebugMode) {
        print(e.response.data);
      }

    }
  }

  Future<SalonM> verification_email({
    String email,
  }) async {
    final data = {
      'email': email,
    };

    final response =
        (await dio.post('forgotPassword', data: FormData.fromMap(data))).data;
  }

  Future<SalonM> verification_code({String email, String code}) async {
    final data = {
      'email': email,
      'code': code,
    };

    final response =
        (await dio.post('verifyCode', data: FormData.fromMap(data))).data;
  }

  Future<SalonM> new_salon_pass(
      {String email, String password, String password_confirmation}) async {
    final data = {
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
    };

    final response =
        (await dio.post('resetPassword', data: FormData.fromMap(data))).data;
  }

  Future<SalonM> resend_code({String email}) async {
    final data = {
      'email': email,
    };

    final response =
        (await dio.post('forgotPassword', data: FormData.fromMap(data))).data;
  }
}
