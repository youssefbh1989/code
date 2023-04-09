import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:salonat/models/appointments.dart';
import 'package:salonat/models/cart.dart';
import 'package:salonat/models/category.dart';
import 'package:salonat/models/entity.dart';
import 'package:salonat/models/notificationmodel.dart';
import 'package:salonat/models/privacymodels.dart';
import 'package:salonat/models/salonmodels.dart';
import 'package:salonat/models/service_filter.dart';
import 'package:salonat/models/servicesfiltermodels.dart';
import 'package:salonat/models/staffmodel.dart';
import 'package:salonat/models/terms.dart';
import 'package:salonat/models/vendormodel.dart';

import '../models/SalonappointementsModel.dart';
import '../models/about.dart';
import '../models/addbusinessmodel.dart';
import '../models/artistmodel.dart';
import '../models/cartemodel.dart';
import '../models/cat.dart';
import '../models/clinicsmodel.dart';
import '../models/favoritemodel.dart';
import '../models/filtercategories.dart';
import '../models/search.dart';
import '../models/slider_model.dart';
import '../models/usermodel.dart';
import 'base.dart';

class WebService extends BaseWebService {
/*  Future<List<SalonModel>> getsalon(
      {String query, String type, int page, String category}) async {
    final response = (await dio.get('index?page=$page&type=$type')).data;


    return List.of(response['salons'])
        .map((e) => SalonModel.fromJson(e))
        .toList();
  }*/
  Future<List<SalonModel>> getsalon(
      {int page , String query, String type,String category}) async {
    final data = {'page': page};
    final response = (await dio.get('index?page=$page&type=$type', queryParameters: data)).data;
    return List.of(response['salons'])
        .map((e) => SalonModel.fromJson(e))
        .toList();
  }

  Future<List<SalonModel>> getsalonbycategoryandtype(

      {String query, String type, int page, String category,String service_available})
  async {
    final response =
        (await dio.get("index?page=$page&category=$category&type=$type&service_available=$service_available",)).data;

    return List.of(response['salons'])
        .map((e) => SalonModel.fromJson(e))
        .toList();
  }

  Future<List<SalonModel>> getall(
      {String query, String type, int page, String category}) async {
    final response =
        (await dio.get("index?category=$category&type=$type")).data;


    return List.of(response['salons'])
        .map((e) => SalonModel.fromJson(e))
        .toList();
  }
  Future<SearchModel> search(String keyword, ) async {
    final response = (await dio.get('services?search=$keyword')).data;
    return SearchModel.fromJson(response);
  }
  Future<SearchModel> searchsalonhome(String keyword, String text) async {
    final response = (await dio.get('services?search=$keyword&service_available=$text')).data;
    print('youssef search salon home$response');
    return SearchModel.fromJson(response);
  }

  Future<SearchModel> filter(String min,String max, String service_available) async {
    final response = (await dio.get('services?min=$min&max=$max&service_available=$service_available')
    ).data;
    print('youssef is is is ${response['salons']}');
    return SearchModel.fromJson(response);
  }

  Future<List<SalonModel>> getsalonbycategories(
      {String query, String type, String page, String salon_id}) async {
    final response = (await dio.get('index?salon_id=$salon_id')).data;

    return List.of(response['salons'])
        .map((e) => SalonModel.fromJson(e))
        .toList();
  }

  Future<List<VendorModel>> getvendor({
    String query,
    String category,
    String type,
  }) async {
    Map<String, dynamic> data = {'category': category, 'type': type};

    try {
      final response =
          (await dio.get('index?type=$type', queryParameters: data)).data;
      List<VendorModel> vendor = [];

      for (final vendors in List.of(response['salons'])) {
        if (vendors != null) {
          vendor.add(VendorModel.fromJson(vendors));
        }
      }
      return vendor;
    } on DioError {
      return [];
    }
  }

  Future<List<ClinicModel>> getclinics(
      {String query, String type, int page}) async {
    Map<String, dynamic> data = {'type': type};

    try {
      final response = (await dio.get('index', queryParameters: data)).data;
      List<ClinicModel> clinics = [];
      for (final salon in List.of(response['salons'])) {
        if (salon != null) {
          clinics.add(ClinicModel.fromJson(salon));
        }
      }
      return clinics;
    } on DioError {
      return [];
    }
  }

  Future<List<ArtistModel>> getartist({
    String query,
    String type,
    String page,
  }) async {
    Map<String, dynamic> data = {'page': page};
    final response = (await dio.get('index?type=$type')).data;

    return List.of(response['salons'])
        .map((e) => ArtistModel.fromJson(e))
        .toList();
  }
  Future<List<ArtistModel>> getfitness({
    String query,
    String type,
    String page,
  }) async {
    Map<String, dynamic> data = {'page': page};
    final response = (await dio.get('index?type=$type')).data;

    return List.of(response['salons'])
        .map((e) => ArtistModel.fromJson(e))
        .toList();
  }

  Future<List<Cat>> getcategory({String query}) async {
    Map<String, dynamic> data = {};
    if (query != null) {
      data['search'] = query;
    }
    try {
      final response =
          (await dio.get('categories', queryParameters: data)).data;
      print('youssef cats${response}');
      List<Cat> categories = [];
      for (final cat in List.of(response['categories'])) {
        if (cat != null) {
          categories.add(Cat.fromJson(cat));
        }
      }
      return categories;
    } on DioError {
      return [];
    }
  }

  Future<List<CategoryModel>> getservices({String query}) async {
    Map<String, dynamic> data = {};
    if (query != null) {
      data['search'] = query;
    }
    try {
      final response = (await dio.get('services', queryParameters: data)).data;
      List<CategoryModel> categories = [];
      for (final cat in List.of(response['services'])) {
        if (cat != null) {
          categories.add(CategoryModel.fromJson(cat));
        }
      }
      return categories;
    } on DioError {
      return [];
    }
  }

  Future<List<AppointmentsModel>> getappointements(
      {int page, String query}) async {
    Map<String, dynamic> data = {'page': page};
    if (query != null) {
      data['search'] = query;
    }
    try {
      final response =
          (await dio.get('app_appointment', queryParameters: data)).data;
      print('youssef issss$response');
      List<AppointmentsModel> appointements = [];
      for (final appointement in List.of(response['appointments'])) {
        if (appointement != null) {
          appointements.add(AppointmentsModel.fromJson(appointement));
        }
      }
      return appointements;
    } on DioError catch (e){
      print(e.message);
      return [];
    }
  }

  Future<List<Services>> getoffersservices({int page, String query}) async {
    Map<String, dynamic> data = {'page': page};
    if (query != null) {
      data['search'] = query;
    }
    try {
      final response = (await dio.get('services', queryParameters: data)).data;
      List<Services> appointements = [];
      for (final offersservices in List.of(response['services'])) {
        if (offersservices != null) {
          appointements.add(Services.fromJson(offersservices));
        }
      }
      return appointements;
    } on DioError {
      return [];
    }
  }

  Future<List<StaffModel>> getstaff({int id}) async {
    final response = (await dio.get('staff/$id')).data;

    return List.of(response['staff'])
        .map((e) => StaffModel.fromJson(e))
        .toList();
  }

  Future<List<SalonModel>> getfiltersalon({String category}) async {
    final response = (await dio.get('index?$category')).data;

    return List.of(response['salons'])
        .map((e) => SalonModel.fromJson(e))
        .toList();
  }

  Future<List<SalonModel>> getsinglesalon({int id}) async {
    final response = (await dio.get('index?salon_id=$id')).data;

    return List.of(response['salons'])
        .map((e) => SalonModel.fromJson(e))
        .toList();
  }

  Future<List<SalonModel>> getgategorysalon(
      {int category_id, int idsalon}) async {
    final response = (await dio.get('index?salon_id=$idsalon?')).data;

    return List.of(response['salons'])
        .map((e) => SalonModel.fromJson(e))
        .toList();
  }

  Future<List<SalonModel>> getgategorysalonbycategory({
    int category_id,
  }) async {
    final response = (await dio.get('index?category=$category_id?')).data;

    return List.of(response['salons'])
        .map((e) => SalonModel.fromJson(e))
        .toList();
  }

  Future<List<UserModel>> getupdate() async {
    final response = (await dio.get('updateProfile')).data;

    return List.of(response['user']).map((e) => UserModel.fromJson(e)).toList();
  }

  Future<List<FilterCategories>> getgategorysalonbyservice(
      {int category_id}) async {
    final response = (await dio.get('services?category=$category_id')).data;

    return List.of(response['services'])
        .map((e) => FilterCategories.fromJson(e))
        .toList();
  }

  Future<List<AboutModel>> getcontent({int page, String query}) async {
    Map<String, dynamic> data = {'page': page};
    if (query != null) {
      data['search'] = query;
    }
    try {
      final response = (await dio.get('pages', queryParameters: data)).data;
      List<AboutModel> about = [];
      for (final aboutdescription in List.of(response['about'])) {
        if (aboutdescription != null) {
          about.add(AboutModel.fromJson(aboutdescription));
        }
      }
      return about;
    } on DioError {
      return [];
    }
  }

  Future<List<TermsModel>> getcontentterms({int page, String query}) async {
    Map<String, dynamic> data = {'page': page};
    if (query != null) {
      data['search'] = query;
    }
    try {
      final response = (await dio.get('pages', queryParameters: data)).data;
      List<TermsModel> terms = [];
      for (final termsdescription in List.of(response['terms'])) {
        if (termsdescription != null) {
          terms.add(TermsModel.fromJson(termsdescription));
        }
      }
      return terms;
    } on DioError {
      return [];
    }
  }

  Future<List<PrivacyModel>> getcontentprivacy({int page, String query}) async {
    Map<String, dynamic> data = {'page': page};
    if (query != null) {
      data['search'] = query;
    }
    try {
      final response = (await dio.get('pages', queryParameters: data)).data;
      List<PrivacyModel> privacy = [];
      for (final privacydesc in List.of(response['privacy'])) {
        if (privacydesc != null) {
          privacy.add(PrivacyModel.fromJson(privacydesc));
        }
      }
      return privacy;
    } on DioError {
      return [];
    }
  }

  Future<List<CarteModel>> getcart(int page, {String query}) async {
    Map<String, dynamic> data = {'page': page};
    if (query != null) {
      data['search'] = query;
    }
    try {
      final response = (await dio.get('getCart', queryParameters: data)).data;
      List<CarteModel> carte = [];
      for (final salon in List.of(response['services'])) {
        if (salon != null) {
          carte.add(CarteModel.fromJson(salon));
        }
      }
      return carte;
    } on DioError {
      return [];
    }
  }

  Future<Salonappointementsmodel> new_appointement(
      {String email,
      String name,
      String phone,
      String date,
      String time}) async {
    final data = {
      'email': email,
      'name': name,
      'phone': phone,
      'date': date,
      'time': time,
    };

    final response =
        (await dio.post('app_appointment', data: FormData.fromMap(data))).data;
  }

  Future<List<SalonModel>> getfilter(
      {String category_id,
      String salon_id,
      String search,
      String type,
      String min,
      String max}) async {
    final response = (await dio.get(
      'services?category_id=$category_id&salon_id=$salon_id&search=$search&type=$type&min=$min&max=$max',
    ))
        .data;
    print(response);

    List<SalonModel> fliter = [];

    for (final filterresult in List.of(response['services'])) {
      if (filterresult != null) {
        fliter.add(SalonModel.fromJson(filterresult));
      }
    }
    return fliter;
  }

  Future<List<EntityModel>> getsalonfilter(
      {String category_id,
      String salon_id,
      String search,
      String type,
      String min,
      String max}) async {
    final response = (await dio.get(
      'services?category_id=$category_id&salon_id=$salon_id&search=$search&type=$type&min=$min&max=$max',
    ))
        .data;

    List<EntityModel> fliter = [];

    for (final filterResult in List.of(response['salons'])) {
      if (filterResult != null) {
        fliter.add(filterResult['type'] == 'Vendor'
            ? VendorModel.fromJson(filterResult)
            : SalonModel.fromJson(filterResult));
      }
    }
    return fliter;
  }

  Future<List<ServiceFilterModel>> getfil(
      {String category_id,
      String salon_id,
      String search,
      String type,
      String min,
      String max}) async {
    final response = (await dio.get(
      'services?category_id=$category_id&salon_id=$salon_id&search=$search&type=$type&min=$min&max=$max',
    ))
        .data;

    List<ServiceFilterModel> fliter = [];

    for (final filterresult in List.of(response['services'])) {
      if (filterresult != null) {
        fliter.add(ServiceFilterModel.fromJson(filterresult));
      }
    }
    return fliter;
  }

  Future<List<ServiceFilterModel>> getcategoryclinics(
      {String category_id,
      String salon_id,
      String search,
      String type,
      String min,
      String max}) async {
    final response = (await dio.get(
      'services?category_id=$category_id&salon_id=$salon_id&search=$search&type=$type&min=$min&max=$max',
    ))
        .data;

    List<ServiceFilterModel> fliter = [];

    for (final filterresult in List.of(response['services'])) {
      if (filterresult != null) {
        fliter.add(ServiceFilterModel.fromJson(filterresult));
      }
    }
    return fliter;
  }

  Future<List<ServiceFilterModel>> getservice({
    String category_id,
  }) async {
    final response = (await dio.get(
      'services?category_id=$category_id',
    ))
        .data;

    List<ServiceFilterModel> fliter = [];
    for (final filterresult in List.of(response['services'])) {
      if (filterresult != null) {
        fliter.add(ServiceFilterModel.fromJson(filterresult));
      }
    }
    return fliter;
  }

  Future<List<ServiceFilterModel>> getcategorybysalonid({
    String salon_id,
  }) async {
    final response = (await dio.get(
      'services?salon_id=$salon_id',
    ))
        .data;

    List<ServiceFilterModel> fliter = [];
    for (final filterresult in List.of(response['services'])) {
      if (filterresult != null) {
        fliter.add(ServiceFilterModel.fromJson(filterresult));
      }
    }
    return fliter;
  }

  Future<Salonappointementsmodel> addtocart({
    String service_id,
    String quantity,
  }) async {
    final data = {
      'service_id': service_id,
      'quantity': quantity,
    };

    final response =
        (await dio.post('addToCart', data: FormData.fromMap(data))).data;

    if (kDebugMode) {
      print(response['message']);
    }
  }

  Future<List<Notificationmodel>> getnotification() async {
    Map<String, dynamic> data = {};

    try {
      final response =
          (await dio.get('notifications', queryParameters: data)).data;
      List<Notificationmodel> salons = [];
      for (final salon in List.of(response['notifications'])) {
        if (salon != null) {
          salons.add(Notificationmodel.fromJson(salon));
        }
      }
      return salons;
    } on DioError {
      return [];
    }
  }

  Future<List<FavoriteModel>> getfavorites({String query}) async {
    Map<String, dynamic> data = {};
    if (query != null) {
      data['search'] = query;
    }
    try {
      final response =
          (await dio.get('favorite-list', queryParameters: data)).data;
      List<FavoriteModel> favorites = [];
      for (final cat in List.of(response['favorite_salons'])) {
        if (cat != null) {
          favorites.add(FavoriteModel.fromJson(cat));
        }
      }
      return favorites;
    } on DioError {
      return [];
    }
  }

  Future<bool> updateFav({
    String id,
  }) async {
    final response = (await dio.post('like-salon/$id', data: {})).data;
    print(response['like']);
    print(response['message']);

    return response['message'].toString().startsWith('Added');
  }

  Future<EntityModel> getEntityById({EntityModel entity}) async {
    final response = (await dio.get('index?salon_id=${entity.id}')).data;

    final json = response['salons'][0];

    try {
      final EntityModel et = entity is ClinicModel
          ? ClinicModel.fromJson(json)
          : entity is SalonModel
              ? SalonModel.fromJson(json)
              : entity is ArtistModel
                  ? ArtistModel.fromJson(json)
                  : VendorModel.fromJson(json);
      print(et.categories.length);
      return et;
    } catch (e) {
      return null;
    }
  }

  Future<List<ClinicModel>> getclinicsbyid({int clinics_id}) async {
    final response = (await dio.get('index?salon_id=$clinics_id?')).data;

    return List.of(response['clinics'])
        .map((e) => ClinicModel.fromJson(e))
        .toList();
  }

  Future<List<SliderModel>> getclinicssliders(int type) async {
    try {
      final params = {
        'type': 'Clinic',
      };
      final response =
          (await dio.get('sliders?type=Clinic', queryParameters: params)).data;

      return List.of(response['sliders'])
          .map((banner) => SliderModel.fromJson(banner))
          .toList();
    } on DioError catch (e) {
      if (e.response != null) print(e.response.statusCode);

      print('dio error:   $e');
      return null;
    }
  }

  Future<List<SliderModel>> getslidersalon(int type) async {
    try {
      final params = {
        'type': 'Salon',
      };
      final response =
          (await dio.get('sliders?type=Salon', queryParameters: params)).data;

      return List.of(response['sliders'])
          .map((banner) => SliderModel.fromJson(banner))
          .toList();
    } on DioError catch (e) {
      if (e.response != null) print(e.response.statusCode);

      print('dio error:   $e');
      return null;
    }
  }

  Future<List<SliderModel>> getindividualslider(int type) async {
    try {
      final params = {
        'type': 'Artist',
      };
      final response =
          (await dio.get('sliders?type=Artist', queryParameters: params)).data;

      return List.of(response['sliders'])
          .map((banner) => SliderModel.fromJson(banner))
          .toList();
    } on DioError catch (e) {
      if (e.response != null) print(e.response.statusCode);

      print('dio error:   $e');
      return null;
    }
  }

  Future<List<SliderModel>> getvendorsslider(
    int type,
  ) async {
    try {
      final params = {
        'type': 'Vendor',
      };
      final response =
          (await dio.get('sliders?type=Vendor', queryParameters: params)).data;

      return List.of(response['sliders'])
          .map((banner) => SliderModel.fromJson(banner))
          .toList();
    } on DioError catch (e) {
      if (e.response != null) print(e.response.statusCode);

      print('dio error:   $e');
      return null;
    }
  }

  Future<bool> addToCart(CartModel cart) async {
    try {
      final response =
          (await dio.post('app_appointment', data: cart.toRequest())).data;
      return true;
    } on DioError catch (e) {
      print(e.response.data);
      return false;
    }
  }
/*  Future<Map<String, List<Notificationmodel>>> getNotifications() async {
    final response = (await dio.get('notifications')).data['notifications'];
    final notifs =
    List.of(response).map((e) => Notificationmodel.fromJson(e)).toList();
    Map<String, List<Notificationmodel>> notifications = {};
    while (notifs.isNotEmpty) {
      if (!notifications.containsKey(notifs.first)) {
        notifications[notifs.first.text] = [];
      }
      notifications[notifs.first.text]
          .addAll(notifs.where((element) => element.text == notifs.first.text));
      notifs.removeWhere((element) => element.text == notifs.first.text);
    }
    return notifications;
  }*/
  Future<Map<String, List<Notificationmodel>>> getNotifications() async {
    final response = (await dio.get('notifications')).data['notifications'];
    final notifs =
    List.of(response).map((e) => Notificationmodel.fromJson(e)).toList();
    Map<String, List<Notificationmodel>> notifications = {};
    while (notifs.isNotEmpty) {
      if (!notifications.containsKey(notifs.first.id)) {
        notifications[notifs.first.id] = [];
      }
      notifications[notifs.first.id]
          .addAll(notifs.where((element) => element.id == notifs.first.id));
      notifs.removeWhere((element) => element.id == notifs.first.id);
    }

    return notifications;
  }
 /* Future<void> readNotification() async {
    final response =await dio.get('markAsRead}');
    print(response);
  }*/
  Future<Notificationmodel> readNotification() async {


    final response =
        (await dio.get('markAsRead')).data;
    print(response);
  }

  Future updateProfile(File path) async {
    try {
      final response = await dio.put(
        'updateProfile',
        data: {

          'image': path,
        },
      );
    /*  final formData = FormData();
      formData.files.add(MapEntry(isProfilePicture ? 'image' : 'cover',
          await MultipartFile.fromFile(path)));
      final response = (await dio.post('updateCover', data: formData)).data;
      return response['cover'];*/
      if (response.statusCode == 200) {


      } else {

      }
    } catch (e) {

    }
  }


  Future<Response> createPlace(FormData formData) async {
    try {
      return await dio.post('https://salonat.qa/api/register-business',
          data: formData);
    } catch (error) {
      print(error.response.data);
      throw error;
    }
  }
}





