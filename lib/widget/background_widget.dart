import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned.fill(child: Image.asset("assets/new/back.png", fit: BoxFit.fill,),);
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
          color: Color(0xff9c5e25),
        )),
        Positioned(
          top: size.height * .2,
          left: -(size.width * .4),
          child: ClipOval(
            child: Container(
              width: size.width * .9,
              height: size.width * .9,
              decoration: BoxDecoration(
                  gradient: RadialGradient(colors: [
                    Color(0xff607e4a),
                    Color(0x76607e4a),
                  ])),
            ),
          ),
        ),
        Positioned(
          bottom: - (size.width * .4),
          left: - (size.width * .5),
          child: ClipOval(
            child: Container(
              width: size.width * 1.2,
              height: size.width * 1.2,
              decoration: BoxDecoration(
                  gradient: RadialGradient(colors: [
                Color(0xff2b3d6a),
                Color(0x762b3d6a),
              ])),
            ),
          ),
        ),
        Positioned(
          bottom: - (size.width * .2),
          right: - (size.width * .38),
          child: ClipOval(
            child: Container(
              width: size.width * 1.0,
              height: size.width * 1.1,
              decoration: BoxDecoration(
                  gradient: RadialGradient(colors: [
                Color(0xff923557),
                Color(0x76923557),
              ])),
            ),
          ),
        ),
        Positioned.fill(
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20,),
                blendMode: BlendMode.src,
                child: Container(
                  color: Color(0x4c573618),
                ),
              ),
            )),
      ],
    );
  }
}
