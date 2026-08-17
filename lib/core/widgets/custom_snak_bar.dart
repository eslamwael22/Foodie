import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:gap/gap.dart';

SnackBar customSnackBar({required String message}) {
  return SnackBar(
    content: Row(
      children: [
        const Icon(Icons.error_outline_outlined, color: Colors.white),
        const Gap(7),
        Expanded(
          child: Text(
            message,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
    backgroundColor: AppColors.errorRed,
  );
}
