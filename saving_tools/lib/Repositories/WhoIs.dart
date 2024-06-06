//This class it's reposiotry to know what is the acutal user account
// should save in application preferences the actual or last username
// Doing an logout will put the actual user as "default"

import 'package:shared_preferences/shared_preferences.dart';

class WhoIs {

  static final String _preferencesKey = "ActualUser"; 

  static Future<String> getActualUsername () async => await _getFromPreferences();

  static Future<void> setActualUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_preferencesKey, username);
  }

  static Future<String> _getFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_preferencesKey) ?? "default";
  }

}