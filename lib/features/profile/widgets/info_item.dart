import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/widgets/custom_text.dart';
import 'package:gap/gap.dart';

Widget buildInfoItem({
  required IconData icon,
  required String title,
  required String value,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
        Container(
          width: 48,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        Gap(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),

              const SizedBox(height: 4),

              CustomText(text: value, fontSize: 14, color: Colors.grey),
            ],
          ),
        ),

        Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.primary),
      ],
    ),
  );
}
