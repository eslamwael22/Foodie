import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/widgets/custom_text.dart';

class CustomContanier extends StatelessWidget {
  final String? text;
  final VoidCallback? onTap;
  final double width;
  final Color? color;
  final double height;
  final Color? textColor;
  final double radius;
  final FontWeight? fontWeight;
  const CustomContanier({
    super.key,
    required this.text,
    this.onTap,
    required this.width,
    required this.height,
    required this.radius,
    this.fontWeight,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? AppColors.primary,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(
          child: CustomText(
            text: text!,
            fontSize: 20,
            fontWeight: fontWeight,
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
