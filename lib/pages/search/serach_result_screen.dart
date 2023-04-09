import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants.dart';
import '../../controller/search_controller.dart';
import '../../models/salonmodels.dart';
import '../../services/api.dart';
import '../common/screens/entity_details.dart';
import '../common/widgets/entity.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({Key key, this.keyword,this.text}) : super(key: key);
  final String keyword;
  final String text;

  @override
  createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  final _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();

    Get.find<SearchController>().search(widget.keyword);
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
        title: _searchWidget(),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: API.isPhone ? 20.0 : 25.0,
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
            scrollController: _scrollController,
            controller: controller,
          );
        },
      ),
    );
  }

  Widget _searchWidget() {
    return Hero(
      tag: 'search_bar',
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 1),
                  color: blackColor.withOpacity(0.1),
                  spreadRadius: 1.5,
                  blurRadius: 1.5,
                ),
              ],
            ),
            child: TextFormField(
              cursorColor: primaryColor,
              maxLines: 1,
              style: TextStyle(
                  color: primaryColor, fontFamily: 'Calibri',
                  fontSize: API.isPhone ? 15.0 : 30.0),
              initialValue: widget.keyword,
              textAlignVertical: TextAlignVertical.center,
              textInputAction: TextInputAction.send,
              onFieldSubmitted: (txt) {
                if (txt.removeAllWhitespace.isNotEmpty) {
                  FocusScope.of(context).unfocus();
                }
              },
              enabled: true,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Search here',
                hintStyle: const TextStyle(color: Color(0xff872b3f)),
                suffixIcon: InkWell(
                    onTap: () {},
                    child:  Icon(
                      Icons.search,
                      color: primaryColor,
                      size:  API.isPhone ? 25.0 : 35.0,
                    )),
                border: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchContent extends StatelessWidget {
  final SearchController controller;
  final ScrollController scrollController;

  _SearchContent({
    this.controller,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(indicatorColor: whiteColor, tabs: [
              if (controller.salons?.isNotEmpty ?? false)
                Tab(
                  child: Text(
                    'Salons',
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize:  API.isPhone ? 15.0 : 25.0,),
                  ),
                ),
              Tab(
                child: Text('Clinics',
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      fontSize:  API.isPhone ? 15.0 : 25.0)),
              ),
              Tab(
                child: Text(' Artist',
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize:  API.isPhone ? 15.0 : 25.0)),
              ),
              Tab(
                child: Text('Suppliers',
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize:  API.isPhone ? 15.0 : 25.0)),
              ),
            ]),
            Expanded(
                child: TabBarView(
              children: [
                ListView.separated(
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
                ),
                ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.clinics.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.w),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () =>
                            controller.clinics[index].openClose != 'Closed'
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EntityDetailScreen(
                                          entity: controller.clinics[index],
                                          clinics_id: controller
                                              .clinics[index].id
                                              .toString()),
                                    ),
                                  )
                                : Container(),
                        child: Entity(entity: controller.clinics[index]),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    width: 2.w,
                  ),
                ),
                ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.artist.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.w),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () =>
                            controller.artist[index].openClose != 'Closed'
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EntityDetailScreen(
                                          entity: controller.artist[index],
                                          clinics_id: controller
                                              .artist[index].id
                                              .toString()),
                                    ),
                                  )
                                : Container(),
                        child: Entity(entity: controller.artist[index]),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    width: 2.w,
                  ),
                ),
                ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.supplier.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.w),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () =>
                            controller.supplier[index].openClose != 'Closed'
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EntityDetailScreen(
                                          entity: controller.supplier[index],
                                          clinics_id: controller
                                              .supplier[index].id
                                              .toString()),
                                    ),
                                  )
                                : Container(),
                        child: Entity(entity: controller.supplier[index]),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    width: 2.w,
                  ),
                )
              ],
            ))
          ],
        ));
  }

  Widget _allResults() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      controller: scrollController,
      children: [
        // if (controller.result.users.isNotEmpty) ...[
        //   const Padding(
        //     padding:
        //     EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        //     child: Text(
        //       'Persons',
        //       style: TextStyle(
        //           fontFamily: 'arial',
        //           fontWeight: FontWeight.w900,
        //           fontSize: 25.0),
        //     ),
        //   ),
        //   ..._usersWidgets()
        // ],
        // if (controller.result.posts.isNotEmpty) ...[
        //   const Padding(
        //     padding:
        //     EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        //     child: Text(
        //       'Posts',
        //       style: TextStyle(
        //           fontFamily: 'arial',
        //           fontWeight: FontWeight.w900,
        //           fontSize: 25.0),
        //     ),
        //   ),
        //   ..._postsWidgets()
        // ],
        // if (controller.result.groups.isNotEmpty) ...[
        //   const Padding(
        //     padding:
        //     EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        //     child: Text(
        //       'Groups',
        //       style: TextStyle(
        //           fontFamily: 'arial',
        //           fontWeight: FontWeight.w900,
        //           fontSize: 25.0),
        //     ),
        //   ),
        //   ..._groupsWidgets(),
        // ]
      ],
    );
  }
}
