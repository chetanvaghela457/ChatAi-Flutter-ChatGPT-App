
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  ///-----------------
  ///Save boolean values
  ///------------------
  static bool getBoolean(String key, SharedPreferences prefs) {
    return prefs.containsKey(key) ? prefs.getBool(key) : false;
  }

  static Future<bool> saveBoolean(
      String key, bool value, SharedPreferences prefs) {
    return prefs.setBool(key, value);
  }

  ///--------------------------
  /// SAVE STRINGS
  ///--------------------------
  static String getString(String key, SharedPreferences prefs) {
    return prefs.getString(key ?? '');
  }

  static Future<bool> setString(
      String key, String value, SharedPreferences prefs) {
    return prefs.setString(key, value);
  }

  ///--------------------------
  /// SAVE INTEGERS
  ///--------------------------
  static int getInt(String key, SharedPreferences prefs) {
    return prefs.getInt(key);
  }

  static Future<bool> setInt(String key, int value, SharedPreferences prefs) {
    return prefs.setInt(key, value);
  }

  ///--------------------------
  /// SAVE DOUBLE
  ///--------------------------
  static double getDouble(String key, SharedPreferences prefs) {
    return prefs.getDouble(key);
  }

  static Future<bool> setDouble(
      String key, double value, SharedPreferences prefs) {
    return prefs.setDouble(key, value);
  }

  static void removePreference(String key) async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    shared_User.remove(key);
  }

}
