import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';

class ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData? icon;

  const ProfileTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      child: TextField(
        controller: controller,
        cursorColor: AppColors.black,
        style: const TextStyle(color: AppColors.textDark, fontSize: 18),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,

          suffixIcon: Icon(icon, color: AppColors.primary, size: 22),

          labelText: labelText,

          labelStyle: const TextStyle(color: AppColors.textGrey, fontSize: 18),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: AppColors.borderGrey),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
      ),
    );
  }
}
