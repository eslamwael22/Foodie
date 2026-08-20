import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefHelpers {
  static const String _tokenKey = 'auth_token';
  static const String _profileImagePathKey = 'profile_image_path';
  static final ValueNotifier<String?> profileImagePath = ValueNotifier(null);

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  static Future<void> saveProfileImage(File image) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileImagePathKey, image.path);
    profileImagePath.value = image.path;
  }

  static Future<String?> getProfileImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_profileImagePathKey);
  }

  static Future<void> clearProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_profileImagePathKey);
    profileImagePath.value = null;
  }
}
