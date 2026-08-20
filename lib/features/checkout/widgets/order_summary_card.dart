import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/features/checkout/widgets/checkout_card.dart';
import 'package:foodie/features/checkout/widgets/summary_row.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CheckoutCard(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: const Column(
        children: [
          SummaryRow(label: 'Order', value: '\$18.19'),
          SummaryRow(label: 'Taxes', value: '\$0.50'),
          SummaryRow(label: 'Delivery Fees', value: '\$5.00'),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: AppColors.borderGrey),
          ),
          SummaryRow(label: 'Total', value: '\$23.69', emphasized: true),
        ],
      ),
    );
  }
}
