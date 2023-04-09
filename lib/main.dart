import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:salonat/models/SalonModel.dart';
import 'package:salonat/models/cart.dart';
import 'package:salonat/models/usermodel.dart';
import 'package:salonat/pages/splash.dart';
import 'package:salonat/services/data_repository.dart';
import 'package:salonat/services/getx_controllers_binding.dart';
import 'package:sizer/sizer.dart';
import 'constants/constants.dart';
import 'controller/home_controller.dart';
import 'localisation/locale_constant.dart';
import 'localisation/localisation_delegate.dart';
import 'models/service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/api.dart';


Future<void>  main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive
    ..registerAdapter(UserModelAdapter())
    ..registerAdapter(SalonMAdapter())
    ..registerAdapter(CartModelAdapter())
    ..registerAdapter(ImageCartAdapter())
    ..registerAdapter(ServiceModelAdapter());
  await Hive.openBox('global');
  await Hive.openBox('cart');
  await Hive.openBox('user');
  Get.put(HomeController(), permanent: true);
  runApp(ChangeNotifierProvider(create: (context) => DataReposotory(), child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  bool isLoading = true;
  String isBoadrdingScreen;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  void didChangeDependencies() async {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    getLocale().then((locale) {
      setState(() {
        _locale = locale;
        isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    API.isPhone = Device.get().isPhone;
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          initialBinding: ControllersBinding(),
          title: 'Salon',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor:  Color(0xff872b3f),
            fontFamily: 'Fahkwang',
            scaffoldBackgroundColor: whiteColor,
            appBarTheme: const AppBarTheme(
              color: Colors.transparent,
              elevation: 0.0,
              iconTheme: IconThemeData(color: blackColor),
            ),
          ),
          locale: _locale,
          supportedLocales: const [
            Locale('en', ''),
            Locale('ar', ''),
          ],
          localizationsDelegates: const [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale?.languageCode == locale?.languageCode &&
                  supportedLocale?.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales?.first;
          },
          home: const Splash(),
        );
      },
    );
  }
}
