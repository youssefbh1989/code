import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:salonat/constants/constants.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/search_controller.dart';
import '../../../services/api.dart';
import '../widgets/entity.dart';
import 'entity_details.dart';

class Search_Salon_Home extends StatefulWidget {
  const Search_Salon_Home({Key key, this.keyword, this.text}) : super(key: key);
  final String keyword;
  final String text;

  @override
  State<Search_Salon_Home> createState() => _Search_Salon_HomeState();
}

class _Search_Salon_HomeState extends State<Search_Salon_Home> {
  @override
  void initState() {
    super.initState();

    Get.find<SearchController>().searchsalonhome(widget.keyword, widget.text);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text('Search'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: API.isPhone ? 15.0 : 30.0,
          ),
        ),
      ),
      body: GetBuilder<SearchController>(
        builder: (controller) {
          if (controller.result == null) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            );
          }
          return _SearchContent(
            controller: controller,
          );
        },
      ),
    );
  }
}


class _SearchContent extends StatelessWidget {
  final SearchController controller;


  _SearchContent({
    this.controller,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
   
       Expanded(child: ListView.separated(
         physics: const BouncingScrollPhysics(),
         itemCount: controller.salons.length,
         itemBuilder: (context, index) {
           return Padding(
             padding:
             EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.w),
             child: InkWell(
               borderRadius: BorderRadius.circular(18),
               onTap: () =>
               controller.salons[index].openClose != 'Closed'
                   ? Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) => EntityDetailScreen(
                       entity: controller.salons[index],
                       clinics_id: controller
                           .salons[index].id
                           .toString()),
                 ),
               )
                   : Container(),
               child: Entity(entity: controller.salons[index]),
             ),
           );
         },
         separatorBuilder: (context, index) => SizedBox(
           width: 2.w,
         ),
       ))
      ],
    );
  }


}
