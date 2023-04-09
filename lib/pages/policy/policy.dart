import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:salonat/localisation/language/language.dart';
import 'package:salonat/models/terms.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:salonat/services/api.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants.dart';
import '../../localisation/locale_constant.dart';
import '../../services/apiservice.dart';
import '../../services/data_repository.dart';

class Policy extends StatefulWidget {
  const Policy({Key key}) : super(key: key);

  @override
  State<Policy> createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {



  @override
  void initState() {
    super.initState();


  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataReposotory>(context,listen: false);
    return Scaffold(
      backgroundColor: backgroundcolor,
      extendBodyBehindAppBar: false,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(Languages.of(context).terms),
        titleSpacing: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: API.isPhone ? 15.0 : 25.0,
          ),
        ),
        actions: [
          // PopupMenuButton<String>(
          //   color: whiteColor.withOpacity(0.5),
          //   shape: const RoundedRectangleBorder(
          //       borderRadius: BorderRadius.all(Radius.circular(15.0))),
          //   icon: ClipOval(
          //       child: Languages.of(context).labelSelectLanguage == "English"?
          //       Image.asset('assets/new/england.png')
          //           :Image.asset('assets/new/qatar.png')
          //   ),
          //   onSelected: (String result) {
          //     changeLanguage(context, result);
          //   },
          //   itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          //     PopupMenuItem<String>(
          //       value: 'ar',
          //       child: Text('العربية',
          //           style: GoogleFonts.cairo(
          //               fontWeight: FontWeight.w700, color: whiteColor)),
          //     ),
          //     PopupMenuItem<String>(
          //       value: 'en',
          //       child: Text('English',
          //           style: GoogleFonts.cairo(
          //               fontWeight: FontWeight.w700, color: whiteColor)),
          //     ),
          //   ],
          // ),
        ],
      ),
      body: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: dataProvider.termslist.length,
              itemBuilder: (context, index) {
                final item = dataProvider.termslist[index];

                return Padding(
                  padding: const EdgeInsets.all(
                    10.0,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.transparent,
                          spreadRadius: 2,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        heightSpace,
                        heightSpace,
                        heightSpace,
                        heightSpace,
                        // Text(
                        //   _removeAllHtmlTags(_terms[index].description),
                        //   style: black18SemiBoldTextStyle,
                        // ),
                        Html(
                          data: Languages.of(context).labelSelectLanguage ==
                                  'English'
                              ? dataProvider.termslist[index].description
                              : dataProvider.termslist[index].description_ar,

                          style: {
                            "body": Style(
                              color:   primaryColor,

                            ),
                            "li": Style(
                              color: primaryColor,
                            ),
                            "ol": Style(
                              fontWeight: FontWeight.bold,
                              color: primaryColor
                            ),
                          },

                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  String _removeAllHtmlTags(String htmlText) {
    if (htmlText == null) return 'N/A';
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }
}
