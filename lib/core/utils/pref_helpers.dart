import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foodie/features/orderHistory/data/order_model.dart';

class PrefHelpers {
  static const String _tokenKey = 'auth_token';
  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';
  static const String _profileImagePathKey = 'profile_image_path';
  static const String _ordersKey = 'paid_orders';

  static final ValueNotifier<String?> profileImagePath = ValueNotifier(null);

  // ================= TOKEN =================

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

  // ================= USER DATA =================

  static Future<void> saveUserData({
    required String name,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_userNameKey, name);
    await prefs.setString(_userEmailKey, email);
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }

  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey);
  }

  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_userNameKey);
    await prefs.remove(_userEmailKey);
  }

  // ================= PROFILE IMAGE =================

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

  static Future<void> savePaidOrder(OrderModel order) async {
    final prefs = await SharedPreferences.getInstance();
    final orders = await getPaidOrders();
    orders.insert(0, order);
    await prefs.setString(
      _ordersKey,
      jsonEncode(orders.map((item) => item.toJson()).toList()),
    );
  }

  static Future<List<OrderModel>> getPaidOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final ordersJson = prefs.getString(_ordersKey);
    if (ordersJson == null || ordersJson.isEmpty) return [];

    final decoded = jsonDecode(ordersJson);
    if (decoded is! List) return [];

    return decoded
        .whereType<Map<String, dynamic>>()
        .map(OrderModel.fromJson)
        .toList();
  }

  static Future<void> deletePaidOrder(String orderId) async {
    final prefs = await SharedPreferences.getInstance();
    final orders = await getPaidOrders();
    orders.removeWhere((order) => order.id == orderId);
    await prefs.setString(
      _ordersKey,
      jsonEncode(orders.map((item) => item.toJson()).toList()),
    );
  }
}
