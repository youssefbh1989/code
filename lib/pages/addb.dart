import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:salonat/services/api.dart';
import 'package:sizer/sizer.dart';
import '../constants/constants.dart';
import '../controller/addbusiness_controller.dart';
import '../localisation/language/language.dart';

class PlaceFormPage extends StatefulWidget {
  @override
  State<PlaceFormPage> createState() => _PlaceFormPageState();
}

class _PlaceFormPageState extends State<PlaceFormPage> {
  final PlaceFormController _placeFormController =
      Get.put(PlaceFormController());

  final List<String> types = ['Salon', 'Vendor', 'Clinic', 'Fitness'];

  String dropdownValue = 'Salon';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _placeFormController.name.clear();
    _placeFormController.arabicName.clear();
    _placeFormController.email.clear();
    _placeFormController.phone.clear();
    _placeFormController.crCopy.clear();
    _placeFormController.password.clear();
    _placeFormController.passwordConfirmation.clear();
    _placeFormController.coverImage.value = null;
    _placeFormController.crcopy.value = null;
    _placeFormController.image.value = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Your Busniss'),
        backgroundColor: primaryColor,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  isDense: true,
                  value: dropdownValue,
                  onChanged: (String newValue) {
                    setState(() {
                      _placeFormController.type.text = newValue;
                      dropdownValue = _placeFormController.type.text;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: primaryColor)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: primaryColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.circular(10.0)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: primaryColor)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: primaryColor)),
                  ),
                  dropdownColor: whiteColor,
                  iconEnabledColor: primaryColor,
                  style: TextStyle(color: Colors.blue),
                  items: <String>['Salon', 'Vendor', 'Clinic', 'Fitness']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: primaryColor),
                      ),
                    );
                  }).toList(),
                ),
              ),
              /*   _buildTextField(
                label: 'Type',
                controller: _placeFormController.type,
              ),*/
              _buildTextField(
                label: 'Name',
                validator: _validateNotEmpty,
                controller: _placeFormController.name,
              ),
              _buildTextField(
                label: 'Name in arabic',
                validator: _validateNotEmpty,
                controller: _placeFormController.arabicName,
              ),
              _buildTextField(
                label: 'Email',
                validator: _validateNotEmpty,
                controller: _placeFormController.email,
              ),
              _buildTextField(
                label: 'Phone',
                validator: _validateNotEmpty,
                controller: _placeFormController.phone,
              ),
              const SizedBox(height: 16),
              Obx(
                () => _placeFormController.image.value == null
                    ? SizedBox.shrink()
                    : Image.file(_placeFormController.image.value),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: _placeFormController.pickImage,
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primaryColor)),
                  child: Text('Select Image Profile'),
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => _placeFormController.coverImage.value == null
                    ? SizedBox.shrink()
                    : Image.file(_placeFormController.coverImage.value),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: _placeFormController.pickCoverImage,
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primaryColor)),
                  child: Text('Select Image Cover'),
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'CR Number',
                validator: _validateNotEmpty,
                controller: _placeFormController.crCopy,
              ),
              const SizedBox(height: 16),
              Obx(
                () => _placeFormController.crcopy.value == null
                    ? SizedBox.shrink()
                    : Image.file(_placeFormController.crcopy.value),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: _placeFormController.pickCrcopy,
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primaryColor)),
                  child: Text('Select CR  Copy'),
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Password',
                validator: _validateNotEmpty,
                controller: _placeFormController.password,
                obscureText: true,
              ),
              _buildTextField(
                label: 'Confirm Password',
                validator: _validateNotEmpty,
                controller: _placeFormController.passwordConfirmation,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _placeFormController.save();
                              };
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(primaryColor)),
                            child: Text('Add'),
                          ),

              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    @required String label,
    @required TextEditingController controller,
    bool obscureText = false,
    String Function(String) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: validator,
        style: TextStyle(
            color: primaryColor,
            fontFamily: 'Calibri',
            fontSize: API.isPhone ? 20.0 : 20.0),
        decoration: InputDecoration(
          labelText: label,
          contentPadding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: primaryColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: primaryColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(10.0)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: primaryColor)),
          disabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: primaryColor)),
        ),
        controller: controller,
        obscureText: obscureText,
      ),
    );
  }

  String _validateNotEmpty(String value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

}
