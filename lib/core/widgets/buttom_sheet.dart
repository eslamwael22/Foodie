import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/widgets/custom_contanier.dart';
import 'package:foodie/core/widgets/custom_text.dart';

class ButtomSheet extends StatelessWidget {
  final String pricetext;
  final String text;
  final VoidCallback onTap;
  final String price;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final double? width;
  final double? height;

  const ButtomSheet({
    super.key,
    required this.onTap,
    required this.price,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.width,
    this.height,
    required this.pricetext,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: pricetext,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 5),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '\$',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: fontSize ?? 20,
                        fontWeight: fontWeight ?? FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: price,
                      style: TextStyle(
                        color: color ?? Colors.black,
                        fontSize: fontSize ?? 20,
                        fontWeight: fontWeight ?? FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Spacer(),

          CustomContanier(
            icon: Icons.payments,
            onTap: onTap,
            text: text,
            width: width ?? 160,
            height: height ?? 55,
            radius: 18,
          ),
        ],
      ),
    );
  }
}
