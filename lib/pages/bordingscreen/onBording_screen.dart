import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:salonat/constants/constants.dart';
import 'package:salonat/localisation/language/language.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../bottom_bar.dart';

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({Key key}) : super(key: key);

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  final controller = PageController();
  bool islastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 8.h),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              islastPage = index == 4;
            });
          },
          children: [
            SizedBox(

              child: Image.asset(
                'assets/onbording/image1.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              child: Image.asset(
                'assets/onbording/image2.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              child: Image.asset(
                'assets/onbording/image3.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              child: Image.asset(
                'assets/onbording/image4.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              child: Image.asset(
                'assets/onbording/image5.jpeg',
                fit: BoxFit.cover,
              ),
            ),

          ],
        ),
      ),
      bottomSheet: islastPage
          ? TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  primary: Colors.white,
                  backgroundColor: primaryColor,
                  minimumSize: Size.fromHeight(8.h),
                  maximumSize: Size.fromHeight(10.h)),
              onPressed: () async {
                Get.to(() => BottomBar());
              },
              child: Text(Languages.of(context).getstarted))
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 1.h),
              height: 8.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () async{
                        Get.to(()=>BottomBar());
                      },
                      child: Text(
                        Languages.of(context).skip,
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      )),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 5,
                      effect: WormEffect(
                          spacing: 16,
                          activeDotColor: primaryColor,
                          dotColor: greyColor.withOpacity(.2)),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      child: Text(
                        Languages.of(context).next,
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
    );
  }
}
