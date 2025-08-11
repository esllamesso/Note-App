import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static late SharedPreferences _prefs;
  static final String  _languageCodeKey = 'languageCode';



  static Future<void> setLocale(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageCodeKey, code);
  }

  static Future<String?> getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageCodeKey);
  }

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool getIsLoggedIn() {
    return _prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<void> setIsLoggedIn(bool value) async {
    await _prefs.setBool('isLoggedIn', value);
  }

  static Future<void> clear() async {
    await _prefs.clear();
  }

  static Future<void> clearLoginData() async {
    await _prefs.remove('isLoggedIn');

  }

}
