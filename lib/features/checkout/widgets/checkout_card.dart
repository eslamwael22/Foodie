import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';

class CheckoutCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const CheckoutCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
