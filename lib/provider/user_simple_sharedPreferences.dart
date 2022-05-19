import 'dart:ffi';
import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences{
  static late SharedPreferences _preferences;

  static const _keyUsername = 'username';
  static const _mode = 'light';
  static const _seen = 'seen';
  static const _listOfTime = 'list of time';


 static Future init() async => _preferences = await SharedPreferences.getInstance();


 static Future setUsername(String username) async => await _preferences.setString(_keyUsername, username);
 static Future setListOfTime(List<String> listOfTime) async => await _preferences.setStringList(_listOfTime, listOfTime);
 static Future setMode(String mode) async => await _preferences.setString(_mode, mode);
 static Future setSeen(String seen) async => await _preferences.setString(_seen, seen);


 static String? getUsername() => _preferences.getString(_keyUsername);
 static String? getMode() => _preferences.getString(_mode);
 static String? getSeen() => _preferences.getString(_seen);
 static List<String>? getListOfTime() => _preferences.getStringList(_listOfTime);

}