import 'package:flutter/material.dart';
import 'package:salonat/localisation/language/language.dart';
import 'package:salonat/services/api.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants.dart';
import '../../models/notificationmodel.dart';
import '../../services/apiservice.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../widget/redirection_auth.dart';



class Notifications extends StatefulWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<Notificationmodel> _notification = [];
  bool _isloading = true;

  @override
  void initState() {
    super.initState();
   // Get.find<HomeController>().getNotifications();
    WebService().getnotification().then((value) {
      if (mounted)
        setState(() {
          _notification = value;
          _isloading = false;
        });
    });

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return API.USER != null?Scaffold(
      backgroundColor: backgroundcolor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        centerTitle: true,
        titleSpacing: 0,
     /*   leading: IconButton(
          onPressed: ()
          {
            WebService().readNotification();
            Get.to(()=>BottomBar());

          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 15.sp,
          ),
        ),*/
        title: Text(
          Languages.of(context).notifications,
          style: TextStyle(
              color: whiteColor, fontSize: API.isPhone ? 15.0 : 30.0, fontFamily: 'Calibri_bold'),
        ),
      ),
      body: _isloading
          ? const Center(
              child: CircularProgressIndicator(
              color: primaryColor,

            ))
          : _notification.isEmpty
              ? notificationListEmpty()
              : notifications(),
    ):Redirection_auth();
  }

  notificationListEmpty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Icon(
            Icons.notifications_off_outlined,
            color: primaryColor,
            size: 35.sp,
          ),
        ),
        Text(
          'Notification List Is Empty',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: primaryColor, fontSize: 15.sp, fontFamily: 'Calibri_bold'),
        )
      ],
    );
  }

  notifications() {
    return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _notification.length,
                itemBuilder: (context, index) {
                  final item = _notification[index];
                  return GestureDetector(
                    onTap: (){
                      WebService().readNotification();
                      },
                    child: Dismissible(
                      key: Key('$_notification[index]'),
                      background: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 1.h, vertical: 2.w),
                          color: primaryColor),
                      onDismissed: (direction) {
                        setState(() {
                          WebService().readNotification();
                          _notification.removeAt(index);

                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "${_notification[index].text} dismissed",
                              style: TextStyle(color: whiteColor),
                            )));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.h, vertical: 2.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 1.h,
                                    vertical: 1.w),
                                child: Container(
                                  height:  API.isPhone ? 80.0 : 120.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: _notification[index].isRead?Colors.white :Colors.grey.withOpacity(.3),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceAround,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.h, vertical: 1.w),
                                        child: Text(_notification[index].text.toString(),
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontSize: API.isPhone ? 20.0 : 35.0,
                                                fontWeight: FontWeight.bold),
                                            maxLines: 2,
                                            overflow: TextOverflow.clip),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.h, vertical: 1.w),
                                        child: Text(
                                          timeago.format(_notification[index].createdAt)

                                              .toString(),
                                          style: TextStyle(color: primaryColor,
                                            fontSize: API.isPhone ? 10.0 : 20.0,),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },

          );
  }
}
