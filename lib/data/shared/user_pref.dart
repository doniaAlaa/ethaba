import 'dart:convert';
import 'package:ethabah/models/User_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const String _userKey = 'user';
  static const String _tokenKey = 'token';

  // Save user information and token
  static Future<void> saveUser(User user, String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_userKey, jsonEncode(user.toJson()));
    prefs.setString(_tokenKey, token);
  }

  // Get user information
  static Future<User?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString(_userKey);
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  // Get token
  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Remove user information and token
  static Future<void> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_userKey);
    prefs.remove(_tokenKey);
  }
}
