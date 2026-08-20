import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/widgets/custom_text.dart';
import 'package:foodie/features/checkout/widgets/checkout_card.dart';
import 'package:foodie/features/checkout/widgets/delivery_icon.dart';

class DeliveryTimeCard extends StatelessWidget {
  const DeliveryTimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const CheckoutCard(
      child: const Row(
        children: [
          DeliveryIcon(),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Estimated Delivery',
                  fontSize: 14,
                  color: AppColors.textGrey,
                ),
                SizedBox(height: 3),
                CustomText(
                  text: '15 - 30 min',
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ],
            ),
          ),
          Icon(
            CupertinoIcons.chevron_forward,
            size: 18,
            color: AppColors.textGrey,
          ),
        ],
      ),
    );
  }
}
