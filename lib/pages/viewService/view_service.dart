import 'package:flutter/material.dart';
import 'package:salonat/models/category.dart';


import '../../constants/constants.dart';




class ViewService extends StatefulWidget {
  const ViewService({Key key, this.categories}) : super(key: key);

  final CategoryModel categories;

  @override
  _ViewServiceState createState() => _ViewServiceState();
}

class _ViewServiceState extends State<ViewService> {
  int selectedHairWash = 0;
  int selectedHairColoring = 0;
  int selectedHairCutting = 0;

  CategoryModel _categories;

  @override
  void initState() {
    _categories = widget.categories;
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Choose Your Service ',
          style: black18SemiBoldTextStyle,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
        children: [
          service(),
          heightSpace,
        ],
      ),
      bottomNavigationBar: continueButton(),
    );
  }

  service() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        heightSpace,
        heightSpace,
        heightSpace,
        ListView.builder(
          shrinkWrap: true,
          itemCount: _categories.services.length,
          itemBuilder: (context, index) {
            final item = _categories.services[index];
            return InkWell(
              onTap: () {
                setState(() {
                  selectedHairWash = index;
                });
              },
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _categories.services[index].name,
                              style: black14MediumTextStyle,
                            ),
                            heightSpace,
                            heightSpace,
                            Text(
                              _categories.services[index].nameAr,
                              style: grey14RegularTextStyle,
                            ),
                            // Text(
                            //   _categories.services[index].description,
                            //   style: grey13RegularTextStyle,
                            // ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: selectedHairWash == index
                                  ? whiteColor
                                  : greyColor.withOpacity(0.3),
                              border: Border.all(
                                color: selectedHairWash == index
                                    ? primaryColor
                                    : Colors.transparent,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: selectedHairWash == index
                                ? Container(
                                    height: 6,
                                    width: 6,
                                    decoration: const BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                  )
                                : Container(),
                          ),
                          widthSpace,
                          widthSpace,
                          Text(
                            _categories.services[index].price,
                            style: TextStyle(
                              color: selectedHairWash == index
                                  ? primaryColor
                                  : greyColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  divider(),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  continueButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            fixPadding * 2.0,
            0,
            fixPadding * 2.0,
            fixPadding * 2.0,
          ),
          child: InkWell(
         /*   onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>   const ScheduleAppointment(


                  )),
            ),*/
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(fixPadding * 1.5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Text(
                'Continue',
                style: white18SemiBoldTextStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  divider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: fixPadding * 1.5),
      color: greyColor,
      height: 1,
      width: double.infinity,
    );
  }
}
