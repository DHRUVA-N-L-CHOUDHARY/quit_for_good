import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Db {
  static late SharedPreferences prefs;
  static const String userLoggedInKey = "LOGGEDINKEY";
  static const String userNameKey = "USERNAMEKEY";
  static const String userEMailKey = "USEREMAILKEY";

  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserName(String userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(userNameKey, userName);
  }

  static Future<bool> saveUserEmail(String userEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(userEMailKey, userEmail);
  }

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getBool(userLoggedInKey);
  }

  static Future<String?> getUserEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getString(userEMailKey);
  }

  static Future<String?> getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getString(userNameKey);
  }
}
