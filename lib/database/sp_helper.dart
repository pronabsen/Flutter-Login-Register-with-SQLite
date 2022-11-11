import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {

  // Write DATA
  static setString(String key, String value)  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }
  static setBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }
  static setInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  //Return String
  static getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? 'null';
  }

  static getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

  static getBool(String key) async {
    SharedPreferences loginCheck = await SharedPreferences.getInstance();
    return loginCheck.getBool(key);
  }

}