import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonat/localisation/language/language.dart';
import 'package:sizer/sizer.dart';

import '../services/api.dart';

const Color primaryColor = Color(0xFFED3D7B);
const Color yellowColor = Color(0xffffb400);
const Color whiteColor = Colors.white;
const Color blackColor = Colors.black;
const Color greyColor = Colors.grey;
const Color backgroundcolor=Color(0xFFFFECF2);
Color catcolor = Colors.white10.withOpacity(0.30);

const double fixPadding = 8.0;

const SizedBox heightSpace = SizedBox(height: 5.0);
const SizedBox widthSpace = SizedBox(width: 5.0);

TextStyle primaryColor18SemiBoldTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 15.sp,
  fontWeight: FontWeight.w600,
);

TextStyle black18SemiBoldTextStyle = TextStyle(
  color: blackColor,
  fontSize: 15.sp,
  fontFamily: 'SFProDisplay-Semibold',
  fontWeight: FontWeight.w600,
);

TextStyle white18SemiBoldTextStyle =
    black18SemiBoldTextStyle.copyWith(color: whiteColor);

TextStyle black12SemiBoldTextStyle = TextStyle(
  color: Color(0xFFFFECF2),
  fontSize: 9.sp,
  fontFamily: 'SFProDisplay-Semibold',
  fontWeight: FontWeight.w600,
);

TextStyle black18BoldTextStyle = TextStyle(
  color: blackColor,
  fontSize: 25.sp,
  fontWeight: FontWeight.w700,
);

TextStyle black16SemiBoldTextStyle = TextStyle(
  color: blackColor,
  fontSize: 16,
  fontFamily: 'SFProDisplay-Semibold',
);

TextStyle white16SemiBoldTextStyle =
    black16SemiBoldTextStyle.copyWith(color: Colors.white);

TextStyle blackSemiBoldTextStyle = TextStyle(
  color: whiteColor,
  fontSize: 15.sp,
  fontFamily: 'SFRPro',
);
TextStyle semiBoldTextStyle = TextStyle(
  color: blackColor,
  fontSize: 25.sp,
  fontWeight: FontWeight.w600,
);

TextStyle black16MediumTextStyle = TextStyle(
  color: blackColor,
  fontSize: 25.sp,
  fontWeight: FontWeight.w500,
);

TextStyle grey16SemiBoldTextStyle = TextStyle(
  color: whiteColor,
  fontSize: 10.sp,
  fontWeight: FontWeight.normal,
);

TextStyle white16BoldTextStyle =
    black16BoldTextStyle.copyWith(color: whiteColor);

TextStyle black16BoldTextStyle = TextStyle(
    color: blackColor, fontSize: 12.sp, fontFamily: 'SFProDisplay-semiBold');
TextStyle whiteBoldTextStyle = TextStyle(
    color: whiteColor, fontSize: 12.sp, fontFamily: 'SFProDisplay-semiBold');

TextStyle black15MediumTextStyle = TextStyle(
    color: blackColor, fontSize: 11.sp, fontFamily: 'SFProDisplay-Medium');

TextStyle get white15MediumTextStyle =>
    black15MediumTextStyle.copyWith(color: whiteColor);

TextStyle black15RegularTextStyle = TextStyle(
  color: blackColor,
  fontSize: 25.sp,
  fontWeight: FontWeight.w400,
);

TextStyle black15SemiBoldTextStyle = TextStyle(
  color: blackColor,
  fontSize: 10.sp,
  fontWeight: FontWeight.w600,
);

TextStyle primaryColor15BoldTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 15.sp,
  fontWeight: FontWeight.w700,
);
TextStyle primaryBoldTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 30.sp,
  fontWeight: FontWeight.w700,
);
TextStyle primaryBoldTextStylewhite = TextStyle(
  color: whiteColor,
  fontSize: 30.sp,
  fontWeight: FontWeight.w700,
);

TextStyle primaryColor15SemiBoldTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 10.sp,
  fontWeight: FontWeight.w600,
);

TextStyle grey15BoldTextStyle = TextStyle(
  color: greyColor,
  fontSize: 25.sp,
  fontWeight: FontWeight.w700,
);

TextStyle grey15MediumTextStyle =
    TextStyle(color: whiteColor, fontSize: 10.sp, fontFamily: 'SFRPro');

TextStyle black14SemiBoldTextStyle = TextStyle(
  color: whiteColor,
  fontSize: 25.sp,
  fontWeight: FontWeight.w600,
);

TextStyle black14MediumTextStyle = TextStyle(
    color: blackColor, fontSize: 15.sp, fontFamily: 'SFProDisplay-semiBold');

TextStyle black14RegularTextStyle = TextStyle(
  color: blackColor,
  fontSize: 25.sp,
  fontWeight: FontWeight.w400,
);

TextStyle white14MediumTextStyle = TextStyle(
  color: whiteColor,
  fontSize: 25.sp,
  fontWeight: FontWeight.w500,
);

TextStyle white14BoldTextStyle = TextStyle(
  color: whiteColor,
  fontSize: 20.sp,
  fontWeight: FontWeight.w700,
);

TextStyle primaryColor14MediumTextStyle =
    TextStyle(color: whiteColor, fontSize: 12.sp, fontFamily: 'SFRProMedium');

TextStyle primaryColor14RegularTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 20.sp,
  fontWeight: FontWeight.w400,
);

TextStyle grey14MediumTextStyle = TextStyle(
  color: greyColor,
  fontSize: 20.sp,
  fontWeight: FontWeight.w500,
);

TextStyle grey14RegularTextStyle = TextStyle(
  color: greyColor,
  fontSize: 20.sp,
  fontWeight: FontWeight.w400,
);

TextStyle white14SemiBoldTextStyle = TextStyle(
  color: whiteColor,
  fontSize: 20.sp,
  fontWeight: FontWeight.w600,
);

TextStyle black13SemiBoldTextStyle = TextStyle(
  color: whiteColor,
  fontSize: 12.sp,
  fontWeight: FontWeight.w600,
);

TextStyle white13RegularTextStyle =
    black13RegularTextStyle.copyWith(color: whiteColor);

TextStyle black13RegularTextStyle = TextStyle(
  color: blackColor,
  fontSize: API.isPhone ? 20.0 : 30.0,
  fontFamily: 'SFProDisplay-Regular',
  fontWeight: FontWeight.w400,
);

TextStyle black13MediumTextStyle = TextStyle(
  color: blackColor,
  fontSize: 10.sp,
  fontFamily: 'SFProDisplay-Medium',
  fontWeight: FontWeight.w500,
);

TextStyle white13MediumTextStyle =
    black13MediumTextStyle.copyWith(color: whiteColor);

TextStyle white13SemiBoldTextStyle = const TextStyle(
  color: blackColor,
  fontSize: 15,
  fontFamily: 'SFProDisplay-semiBold',
  fontWeight: FontWeight.w600,
);

TextStyle white10SFProMedium = const TextStyle(
  color: blackColor,
  fontSize: 10,
  fontFamily: 'SFRProMedium',
  fontWeight: FontWeight.w500,
);

TextStyle grey13MediumTextStyle =
    TextStyle(color: whiteColor, fontSize: 10.sp, fontFamily: 'SFRPro');

TextStyle grey13RegularTextStyle = TextStyle(
    color: blackColor, fontSize: 10.sp, fontFamily: 'SFProDisplay-Regular');

TextStyle grey13RegularTextHintStyle =
    TextStyle(color: greyColor, fontSize: 10.sp, fontFamily: 'Calibri');
TextStyle greyTextStyle = TextStyle(
    color: const Color(0xFF9B16A1),
    fontSize: 20.sp,
    fontFamily: 'SFRProRegular');
TextStyle greyRegular =
    TextStyle(color: greyColor, fontSize: 20.sp, fontFamily: 'SFRProRegular');
TextStyle greyRegularTextStyle =
    TextStyle(color: blackColor,   fontSize: API.isPhone ? 20.0 : 30.0, fontFamily: 'Calibri');

TextStyle primaryColor13SemiBoldTextStyle = const TextStyle(
  color: Color(0xFF9B16A1),
  fontSize: 25,
  fontWeight: FontWeight.w600,
);

TextStyle primaryColor13MediumTextStyle = TextStyle(
  color: primaryColor,
  fontSize: 10.sp,
  fontWeight: FontWeight.w500,
);

TextStyle primaryColor13BoldTextStyle = TextStyle(
  color: const Color(0xFF9B16A1),
  fontSize: 10.sp,
  fontWeight: FontWeight.w700,
);

TextStyle green13BoldTextStyle = TextStyle(
  color: Colors.green[800],
  fontSize: 20.sp,
  fontWeight: FontWeight.w700,
);

TextStyle black12RegularTextStyle = TextStyle(
  color: blackColor,
  fontSize: 12.sp,
  fontWeight: FontWeight.w400,
);

TextStyle white12SemiBoldTextStyle = TextStyle(
  color: whiteColor,
  fontSize: 15.sp,
  fontWeight: FontWeight.w600,
);

TextStyle white12RegularTextStyle = TextStyle(
  color: blackColor,
  fontSize: 15.sp,
  fontWeight: FontWeight.w400,
);

TextStyle grey12RegularTextStyle = TextStyle(
  color: const Color(0xFF2E3A59),
  fontSize: 15.sp,
  fontWeight: FontWeight.w400,
);
TextStyle grey12TextStyle = TextStyle(
  color: const Color(0xFF2E3A59),
  fontSize: 10.sp,
  fontWeight: FontWeight.w400,
);

TextStyle grey12SemiBoldTextStyle = TextStyle(
  color: greyColor,
  fontSize: 15.sp,
  fontWeight: FontWeight.w600,
);

TextStyle grey12MediumTextStyle = TextStyle(
  color: greyColor,
  fontSize: 25.sp,
  fontWeight: FontWeight.w500,
);

TextStyle primaryColor12BoldTextStyle = TextStyle(
  color: const Color(0xFF9B16A1),
  fontSize: 15.sp,
  fontWeight: FontWeight.w700,
);

TextStyle grey11RegularTextStyle = TextStyle(
  color: greyColor,
  fontSize: 15.sp,
  fontWeight: FontWeight.w400,
);

TextStyle primaryColor11SemiBoldTextStyle = TextStyle(
  color: const Color(0xFF9B16A1),
  fontSize: 15.sp,
  fontWeight: FontWeight.w600,
);

TextStyle primaryColor11RegularTextStyle = TextStyle(
  color: const Color(0xFF9B16A1),
  fontSize: 15.sp,
  fontWeight: FontWeight.w400,
);

TextStyle white10BoldTextStyle = TextStyle(
  color: whiteColor,
  fontSize: 25.sp,
  fontWeight: FontWeight.w700,
);

TextStyle black10SemiBoldTextStyle = TextStyle(
  color: blackColor,
  fontSize: 10.sp,
  fontFamily: 'SFProDisplay-Regular',
  fontWeight: FontWeight.w600,
);

TextStyle grey10SemiBoldTextStyle = TextStyle(
  color: greyColor,
  fontSize: 25.sp,
  fontWeight: FontWeight.w600,
);

TextStyle primaryColor9BoldTextStyle = TextStyle(
  color: const Color(0xFF9B16A1),
  fontSize: 25.sp,
  fontWeight: FontWeight.w700,
);

showSuccessDialog({bool success = true}) async {
  final content = success
      ? Languages.of(Get.context).bookedsucces
      : Languages.of(Get.context).Error;
  await Get.dialog(
      Dialog(
      backgroundColor: whiteColor,
      child: SizedBox(
      width: Get.width * .4,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.rotate(
                angle: success ? 0 : 0.785398,
                child: Icon(
                  success ? Icons.check_circle :
                  Icons.add_circle,
                  color: success ?
                  Colors.green :
                  primaryColor,
                  size: 50,
                )
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              content,
              style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    ),
  ),

  );
}
