import 'package:shared_preferences/shared_preferences.dart';

import '../../injection_container.dart';

const String LAGUAGE_CODE = 'languageCode';

//languages code
const String ENGLISH = 'en';
const String INDONESIA = 'id';

Future<void> setLocale(String languageCode) async {
  final _prefs = sl.get<SharedPreferences>();
  await _prefs.setString(LAGUAGE_CODE, languageCode);
}

Future<String> getLocaleCode() async {
  final _prefs = sl.get<SharedPreferences>();
  String languageCode = _prefs.getString(LAGUAGE_CODE) ?? "en";
  return languageCode;
}
