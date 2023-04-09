



import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:salonat/models/notificationmodel.dart';

import '../models/salonmodels.dart';
import '../services/apiservice.dart';

class HomeController extends GetxController{


  final salons = <SalonModel>[];
  int page = 0;
  bool _isLoadingMore = false;
  bool canLoadMore = true;
  bool errorLoading = false;
  bool isLoadingNotifications = true;
  bool _initialized = false;

  RxMap<String, List<Notificationmodel>> notifications =
      <String, List<Notificationmodel>>{}.obs;

  void reload() {
    errorLoading = false;


    initialize();
  }

  @override
  void onInit() {
    super.onInit();

  }

  @override
  void onClose() {

    super.onClose();
  }

  void close() {

    page = 0;

    _initialized = false;
    _isLoadingMore = false;
    canLoadMore = true;

    errorLoading = false;
    isLoadingNotifications = true;
    notifications.clear();
  }

  void readNotification(Notificationmodel notification) {
    /*notifications.forEach((key, value) {
      if (value.contains(notification)) {
        value.remove(notification);
      }
    });*/
    //notifications.removeWhere((key, value) => value.isEmpty);
    if (!notification.isRead) {
      WebService().readNotification();
    }
    notification.isRead = true;
    notifications.refresh();
    update(['notifications']);
  }


  Future<void> getNotifications() async {
    try {
      final data = await WebService().getNotifications();
      notifications.clear();
      notifications.addAll(data);

    } on DioError {}
    isLoadingNotifications = false;
    update(['notifications']);
  }

  initialize() {
    if (!_initialized) {
      _initialized = true;
      isLoadingNotifications = true;
      update(['notifications']);
      getNotifications();
    }
  }

}