import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/widgets/custom_text.dart';

class CheckoutSectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const CheckoutSectionTitle({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 8),
          CustomText(
            text: title,
            color: AppColors.textDark,
            fontSize: 19,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
