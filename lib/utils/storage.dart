import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Future<SharedPreferences> getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  // Serialize and store a Map<String, dynamic> as a JSON-encoded string
  static setValue(String key, dynamic value) async {
    SharedPreferences prefs = await getPrefs();

    if (value is String) {
      prefs.setString(key, value);
    } else if (value is int) {
      prefs.setInt(key, value);
    } else if (value is double) {
      prefs.setDouble(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else if (value is List<String>) {
      prefs.setStringList(key, value);
    } else if (value is Map<String, dynamic>) {
      prefs.setString(key, jsonEncode(value));
    }
  }

  // getValue, generic method to get any type of value
  static Future<dynamic> getValue(String key) async {
    SharedPreferences prefs = await getPrefs();
    return prefs.get(key);
  }

  // removeValue, generic method to remove any type of value
  static removeValue(String key) async {
    SharedPreferences prefs = await getPrefs();
    prefs.remove(key);
  }

  // clear, method to clear all values
  static clear() async {
    SharedPreferences prefs = await getPrefs();
    prefs.clear();
  }
}
