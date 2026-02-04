import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

class StorageService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get prefs {
    final prefs = _prefs;
    if (prefs == null) {
      throw Exception(
        'StorageService not initialized. Call StorageService.init() first.',
      );
    }
    return prefs;
  }

  // Auth related storage
  static Future<void> saveToken(String token) async {
    await prefs.setString(AppConstants.authTokenKey, token);
  }

  static String? getToken() {
    return prefs.getString(AppConstants.authTokenKey);
  }

  static Future<void> removeToken() async {
    await prefs.remove(AppConstants.authTokenKey);
  }

  static Future<void> saveUser(String userJson) async {
    await prefs.setString(AppConstants.userDataKey, userJson);
  }

  static String? getUser() {
    return prefs.getString(AppConstants.userDataKey);
  }

  static Future<void> removeUser() async {
    await prefs.remove(AppConstants.userDataKey);
  }

  // App settings
  static Future<void> saveTheme(String theme) async {
    await prefs.setString(AppConstants.themeKey, theme);
  }

  static String getTheme() {
    return prefs.getString(AppConstants.themeKey) ?? 'light';
  }

  static Future<void> saveLanguage(String language) async {
    await prefs.setString(AppConstants.languageKey, language);
  }

  static String getLanguage() {
    return prefs.getString(AppConstants.languageKey) ?? 'en';
  }

  // Clear all data
  static Future<void> clearAll() async {
    await prefs.clear();
  }

  static bool get isLoggedIn {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }

  // Temporary JSON helper (useful for onboarding-like flows)
  static Future<void> saveTemporaryJson(
    String key,
    Map<String, dynamic> data,
  ) async {
    await prefs.setString(key, jsonEncode(data));
  }

  static Map<String, dynamic>? getTemporaryJson(String key) {
    final jsonString = prefs.getString(key);
    if (jsonString == null) return null;
    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  static Future<void> clearTemporaryJson(String key) async {
    await prefs.remove(key);
  }
}

