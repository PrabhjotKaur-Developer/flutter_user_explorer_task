
import 'package:flutter/material.dart';

class AppConstants {

  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String usersEndpoint = '/users';
  static const String userListUrl = '$baseUrl$usersEndpoint';

  static const String userCacheKey = 'cachedUserList';

  static const String userListRoute = '/';
  static const String userDetailsRoute = '/details';

  static const Color gradientTopLeft = Color(0xFF6B8EF5);
  static const Color gradientTopRight = Color(0xFF5DD5D5);
  static const Color gradientBottom = Color(0xFFE8F0FF);

  static const Color darkGradientTopLeft = Color(0xFF1a1a2e);
  static const Color darkGradientTopRight = Color(0xFF16213e);
  static const Color darkGradientBottom = Color(0xFF0f0f1e);

  static const Color avatarGreen = Color(0xFF7FD9C7);
  static const Color avatarOrange = Color(0xFFFFB59A);
  static const Color avatarPurple = Color(0xFFA49BF5);
  static const Color avatarBlue = Color(0xFF92C7FF);

  static const Color iconCyan = Color(0xFF6DD5D5);
  static const Color iconGreen = Color(0xFF7FD9C7);
  static const Color iconOrange = Color(0xFFFFB59A);

  static const Color textDark = Color(0xFF2C3E50);
  static const Color textGrey = Color(0xFF95A5A6);
  static const Color textWhite = Color(0xFFFFFFFF);

  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF2C2C3E);
  static const Color containerLight = Color(0xFFF8F9FA);
  static const Color containerDark = Color(0xFF1E1E2E);

  static const Color offlineBadgeStart = Colors.blue;
  static const Color offlineBadgeEnd = Colors.blue;

  static const Color errorColor = Color(0xFFE74C3C);
  static const Color successColor = Color(0xFF2ECC71);
  static const Color primaryColor = Color(0xFF6B8EF5);
  static const Color accentColor = Color(0xFF5DD5D5);

}