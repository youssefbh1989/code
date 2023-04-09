import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';


import 'package:salonat/pages/search/serach_result_screen.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants.dart';
import '../../services/api.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    {

  final _searchTextController = TextEditingController();
  final _focus = FocusNode();
  final RxList<String> _history = <String>[].obs;
  Box<String> _box;

  @override
  void initState() {
    super.initState();
    _initHive();

  }

  @override
  void dispose() {
    super.dispose();
    //_box.close();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
            size: API.isPhone ? 20.0 : 25.0,
          ),
        ),


        centerTitle: true,

        title: _searchWidget(),
      ),
      body: Obx(() => ListView.builder(
        itemCount: _history.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.history,color: primaryColor,),
            title: Text(_history[index],style: TextStyle(
              color: primaryColor,
              fontSize: API.isPhone ? 15.0 : 30.0
            ),),
            trailing: InkWell(
              onTap: () => _delete(index),
              child: const Icon(Icons.close,color: primaryColor,),
            ),
            onTap: () {
              _searchTextController.text = _history[index];
              _searchTextController.selection = TextSelection.fromPosition(
                  TextPosition(offset: _searchTextController.text.length));
            },
          );
        },
      )),
    );
  }



  Widget _searchWidget() {
    return Hero(
      tag: 'search_bar',
      child: Material(
        color: Colors.transparent,
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
          child: TextField(
            cursorColor: primaryColor,
            focusNode: _focus,
            controller: _searchTextController,

            style: TextStyle(
                color: primaryColor,
                fontFamily: 'Calibri',
                fontSize: API.isPhone ? 15.0 : 30.0),
            onChanged: (txt) {
              setState(() {
                _history
                  ..clear()
                  ..addAll(_box.values
                      .where((element) => element.contains(txt))
                      .take(20));
              });
            },
            maxLines: 1,
            textAlignVertical: TextAlignVertical.center,

            textInputAction: TextInputAction.search,
            onSubmitted: (txt) {
              if (txt.removeAllWhitespace.isNotEmpty) {
                _submit();
              }
            },
            decoration: InputDecoration(

              isDense: true,
              hintText: 'Search here',
              hintStyle: TextStyle(color:  primaryColor),


              suffixIcon:
              InkWell(onTap: _submit, child:  Icon(
                Icons.search,
                color:  primaryColor,
              size: API.isPhone ? 25.0 : 35.0,)),
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
    );
  }

  Future<void> _initHive() async {
    _box ??= await Hive.openBox<String>('search_history');
    setState(() {
      _history
        ..clear()
        ..addAll(_box.values.take(20));
    });
  }

  void _submit() {
    if (_searchTextController.text.isNotEmpty) {
      FocusScope.of(context).unfocus();
      Get.to(() => SearchResultScreen(keyword: _searchTextController.text));
      if (!(_box?.values.contains(_searchTextController.text) ?? false)) {
        _box?.add(_searchTextController.text);
      }
    }
  }

  _delete(int index) {
    showDialog(context: context, builder: (context) => AlertDialog(
        backgroundColor: whiteColor,
      title:  Text('Delete',style: TextStyle(
          color:  primaryColor,
        fontWeight: FontWeight.bold
      ),),
      content: Text('Do you want to delete "${_history[index]}" from history?',
      style: TextStyle(
        color:  primaryColor,
      ),),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child:
        Text('No',style: TextStyle(
            color:  primaryColor

        ),)),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              _history.removeAt(index);
              unawaited(_box?.deleteAt(index));
            },
            child:  Text('Yes',style: TextStyle(
                color:  primaryColor
            ),)),
      ],
    ));
  }
}