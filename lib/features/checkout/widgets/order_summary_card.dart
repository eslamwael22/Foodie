import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/features/checkout/widgets/checkout_card.dart';
import 'package:foodie/features/checkout/widgets/summary_row.dart';

class OrderSummaryCard extends StatelessWidget {
  final double orderTotal;
  final double taxes;
  final double deliveryFees;

  const OrderSummaryCard({
    super.key,
    required this.orderTotal,
    this.taxes = 5.00,
    this.deliveryFees = 5.00,
  });

  @override
  Widget build(BuildContext context) {
    return CheckoutCard(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Column(
        children: [
          SummaryRow(
            label: 'Order',
            value: 'L.E ${orderTotal.toStringAsFixed(2)}',
          ),
          SummaryRow(label: 'Taxes', value: 'L.E ${taxes.toStringAsFixed(2)}'),
          SummaryRow(
            label: 'Delivery Fees',
            value: 'L.E ${deliveryFees.toStringAsFixed(2)}',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: AppColors.borderGrey),
          ),
          SummaryRow(
            label: 'Total',
            value:
                'L.E ${(orderTotal + taxes + deliveryFees).toStringAsFixed(2)}',
            emphasized: true,
          ),
        ],
      ),
    );
  }
}
