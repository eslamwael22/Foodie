import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/widgets/custom_text.dart';

class PaymentMethods extends StatelessWidget {
  final String image;
  final String title;
  final String value;
  final String? subtitle;
  final String groupValue;
  final VoidCallback? onTap;
  final ValueChanged<String?> onChanged;
  final bool showRadio;

  const PaymentMethods({
    super.key,
    required this.image,
    required this.title,
    required this.value,
    this.onTap,
    required this.onChanged,
    required this.groupValue,
    this.subtitle,
    required Color tilecolor,
    this.showRadio = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue; // 👈 بنحدد الحالة هنا

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Material(
        color: isSelected
            ? AppColors
                  .primary // ✅ مختار → لون التطبيق الأساسي
            : AppColors.white, // ✅ غير مختار → أبيض مع حدود
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: isSelected
                  ? null
                  : Border.all(
                      color: AppColors.primary.withOpacity(0.25),
                      width: 1.2,
                    ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(image, height: 70, width: 50),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: title,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? AppColors.white : Colors.black87,
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        CustomText(
                          text: subtitle!,
                          fontSize: 14,
                          color: isSelected
                              ? AppColors.white.withOpacity(0.75)
                              : Colors.grey.shade600,
                        ),
                      ],
                    ],
                  ),
                ),
                if (showRadio)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.white
                            : AppColors.primary.withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                    child: isSelected
                        ? Center(
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.white,
                              ),
                            ),
                          )
                        : null,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
