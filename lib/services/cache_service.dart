
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';

class CacheService {
  late SharedPreferences _prefs;

  static const String _themeKey = 'isDark';

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> saveTheme(bool isDarkMode) async {
    try {
      return await _prefs.setBool(_themeKey, isDarkMode);
    } catch (e) {
      print('Error saving theme: $e');
      return false;
    }
  }

  bool getTheme() {
    try {
      return _prefs.getBool(_themeKey) ?? false;
    } catch (e) {
      print('Error getting theme: $e');
      return false;
    }
  }

  Future<bool> saveUsers(List<User> users) async {
    try {
      final List<String> userJsonList =
      users.map((user) => jsonEncode(user.toJson())).toList();
      return await _prefs.setStringList(AppConstants.userCacheKey, userJsonList);
    } catch (e) {
      print('Error saving users to cache: $e');
      return false;
    }
  }

  List<User> getUsers() {
    try {
      final List<String>? userJsonList =
      _prefs.getStringList(AppConstants.userCacheKey);
      if (userJsonList == null) return [];

      return userJsonList
          .map((jsonString) => User.fromJson(jsonDecode(jsonString)))
          .toList();
    } catch (e) {
      print('Error retrieving users from cache: $e');
      return [];
    }
  }
}