import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'api.dart';

class BaseWebService {
  Dio dio;
  static AlertDialog dialog;

  BaseWebService() {
    dio = Dio(BaseOptions(baseUrl: API.baseurl, headers: {'accept': 'application/json', 'Authorization': 'Bearer '
        '${API.token}'},));
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

}