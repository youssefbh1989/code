

import 'package:flutter/material.dart';
import 'package:salonat/pages/auth/signin.dart';

import '../../constants/constants.dart';
import '../../localisation/language/language.dart';

class VerificationFinal extends StatefulWidget {
  const VerificationFinal({Key key}) : super(key: key);

  @override
  State<VerificationFinal> createState() => _VerificationFinalState();
}

class _VerificationFinalState extends State<VerificationFinal> {
  @override
  Widget build(BuildContext context) {
    Future<void> _showDialog() async {
      return showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              backgroundColor: Colors.white.withOpacity(0.15),
              actionsPadding:
              const EdgeInsets.only(bottom: 8, left: 16, right: 16),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    height: 50,
                    color: whiteColor,
                    mouseCursor: MouseCursor.defer,
                    textColor: Colors.white,
                    minWidth: double.infinity,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  const Signin()),
                      );
                    },
                    child: Text(
                      Languages.of(context).ok,
                      style: primaryColor15BoldTextStyle,
                    ),
                  ),
                ),
              ],
              content: Container(
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(15)),
                alignment: Alignment.center,
                height: 230,
                child: Column(
                  children: <Widget>[
                    Image.asset("assets/new/verification.png",
                        height: 75, width: 75),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Verified !',
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 28,
                            fontFamily: 'SFProDisplay-Bold')),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Yalla! You have successfully verified the account.",
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 13,
                        color: whiteColor,
                        fontFamily: 'SFProDisplay-Bold',
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }
    return Container(
        child: Column(
          children: const [],
        )


    );
  }
}
