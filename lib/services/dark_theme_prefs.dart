import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePrefs {
  static const tHEMESTATUS = "THEMESTATUS";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(tHEMESTATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(tHEMESTATUS) ?? false;
  }
}
