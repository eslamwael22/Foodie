import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';

Widget counterButton({required IconData icon, required VoidCallback onTap}) {
  return Container(
    height: 42,
    width: 35,
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(10),
    ),
    child: IconButton(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white, size: 22),
    ),
  );
}
