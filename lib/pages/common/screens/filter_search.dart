import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';
import 'package:salonat/controller/filtercontroller.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/constants.dart';
import '../../../controller/search_controller.dart';
import '../../../services/api.dart';
import '../widgets/entity.dart';
import 'entity_details.dart';

class Filter_search extends StatefulWidget {
  const Filter_search({
    Key key,
    this.keyword,
    this.service,
    this.minprice,
    this.maxprice,
  }) : super(key: key);
  final String keyword;
  final String minprice;
  final String maxprice;
  final String service;

  @override
  createState() => _Filter_searchState();
}

class _Filter_searchState extends State<Filter_search> {
  final _scrollController = ScrollController();

  final scrollController = ScrollController();
  bool _isloadingmore = false;
  int page = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    Get.find<FilterController>().filter(widget.minprice, widget.maxprice, widget.service,page);
  }
  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        _isloadingmore = true;
      });
      print('Scroll called by youssef');

      page = page + 1;
      await Get.find<FilterController>().filter(widget.minprice, widget.maxprice, widget.service,page);
      setState(() {
        _isloadingmore = false;
      });
    } else {
      print('Scroll called by mariem');
    }
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
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: API.isPhone ? 20.0 : 30.0,
          ),
        ),
        title: Text('Filter',),
      ),
      body: GetBuilder<FilterController>(
        builder: (controller) {
          if (controller.result == null) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            );
          }
          return ListView.separated(


            physics: const BouncingScrollPhysics(),
            itemCount: _isloadingmore ? controller.result.salon.length + 1 : controller.result.salon.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.w),
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () => controller.result.salon[index].openClose != 'Closed'
                      ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EntityDetailScreen(
                          entity: controller.result.salon[index],
                          clinics_id:
                          controller.result.salon[index].id.toString()),
                    ),
                  )
                      : Container(),
                  child: Entity(entity: controller.result.salon[index]),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              width: 2.w,
            ),
          );
        },
      ),
    );
  }


}

/*class _SearchContent extends StatelessWidget {
  final FilterController controller;


  const _SearchContent({
    this.controller,

  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: ,

      physics: const BouncingScrollPhysics(),
      itemCount: controller.result.salon.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.w),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () => controller.result.salon[index].openClose != 'Closed'
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EntityDetailScreen(
                          entity: controller.result.salon[index],
                          clinics_id:
                              controller.result.salon[index].id.toString()),
                    ),
                  )
                : Container(),
            child: Entity(entity: controller.result.salon[index]),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        width: 2.w,
      ),
    );
  }


}*/
