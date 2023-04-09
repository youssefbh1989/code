
import 'package:flutter/material.dart';
import 'package:salonat/constants/constants.dart';
import 'package:salonat/pages/bottom_bar.dart';
import 'package:salonat/widget/image_list_view.dart';

import 'constants/colors.dart';
import 'constants/utils.dart';



class IntroScreen extends StatelessWidget {
  const IntroScreen({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // image transition
          Positioned(
            top: -10,
            left: -150,
            child: Row(
              children: const [
                ImageListView(startIndex: 0),
                ImageListView(startIndex: 1),
                ImageListView(startIndex: 2),
              ],
            ),
          ),

          // title


          // information screen
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.60,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.white60,
                    Colors.white,
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome To Salonat",
                    style: kNormalStyle.copyWith(fontSize: 30, height: 1.3),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Welcome to Salonat, the ultimate app for discovering the best salons , Beauty Clinics ,Fitness , \n Makeup Artist andBeauty Supplier in Qatar! Our app features a comprehensive list of salons across the country,\n making it easy for you to find the perfect one for your beauty needs",
                    style: kNormalStyle.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
             /*     Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: buildIndicators(),
                  ),*/
                ],
              ),
            ),
          ),

          // bottom button
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  BottomBar(),
                  ),
                ),
                child: const Text("Next"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
