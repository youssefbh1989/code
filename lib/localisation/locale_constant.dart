


import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../main.dart';

const String prefSelectedLanguageCode = "SelectedLanguageCode";

final _box = Hive.box('global');

Future<Locale> setLocale(String languageCode) async {
  await _box.put(prefSelectedLanguageCode, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  String languageCode = _box.get(prefSelectedLanguageCode, defaultValue: 'en');
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  return languageCode != null && languageCode.isNotEmpty
      ? Locale(languageCode, '')
      : const Locale('en', '');
}

void changeLanguage(BuildContext context, String selectedLanguageCode) async {
  var _locale = await setLocale(selectedLanguageCode);
  MyApp.setLocale(context, _locale);
}