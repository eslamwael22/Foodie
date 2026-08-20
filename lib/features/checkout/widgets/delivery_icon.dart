import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';

class DeliveryIcon extends StatelessWidget {
  const DeliveryIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.paleYellow,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Icon(CupertinoIcons.clock, color: AppColors.secondary),
    );
  }
}
