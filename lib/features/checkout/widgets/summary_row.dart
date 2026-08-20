import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/widgets/custom_text.dart';

class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool emphasized;

  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.emphasized = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: label,
            fontSize: emphasized ? 17 : 15,
            fontWeight: emphasized ? FontWeight.w600 : FontWeight.w400,
            color: emphasized ? AppColors.textDark : AppColors.textGrey,
          ),
          CustomText(
            text: value,
            fontSize: emphasized ? 19 : 15,
            fontWeight: emphasized ? FontWeight.w700 : FontWeight.w500,
            color: emphasized ? AppColors.primary : AppColors.textDark,
          ),
        ],
      ),
    );
  }
}
