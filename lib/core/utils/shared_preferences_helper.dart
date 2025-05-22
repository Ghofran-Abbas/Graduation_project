import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/login/data/models/login_secretary_model.dart';

class SharedPreferencesHelper {
  static const _jwtTokenKey = 'jwt_token';
  static const _userRoleKey = 'role_const';
  static const _userIdKey = 'id_const';

  static const _fcmTokenKey = 'fcm_token';

  static Future<void> saveFcmToken(String fcmToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fcmTokenKey, fcmToken);
  }

  static Future<String?> getFcmToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_fcmTokenKey);
  }

  static Future<void> saveJwtToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_jwtTokenKey, token);
  }

  static Future<String?> getJwtToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_jwtTokenKey);
  }

  static Future<void> clearJwtToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_jwtTokenKey);
  }
  static Future<void> clearFcmToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_fcmTokenKey);
  }



  static Future<bool> isLoggedIn() async {
    final token = await getJwtToken();
    return token != null && token.isNotEmpty;
  }

  static Future<void> saveUserRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userRoleKey, role);
  }

  static Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userRoleKey);
  }

  static Future<void> clearUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userRoleKey);
  }

  static Future<void> saveUserID(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userIdKey, id);
  }

  static Future<int?> getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userIdKey);  // Corrected key
  }

  static Future<void> clearUserID() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);  // Corrected key
  }

  static Future<void> saveLoginModel(LoginSecretaryModel model) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(model.toJson());
    await prefs.setString('login_model', jsonString);
  }

  static Future<LoginSecretaryModel?> getLoginModel() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('login_model');

    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return LoginSecretaryModel.fromJson(jsonMap);
    }

    return null;
  }

  static Future<void> clearLoginModel() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('login_model');
  }
}
