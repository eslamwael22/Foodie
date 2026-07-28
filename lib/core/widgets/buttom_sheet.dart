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
  final double horizontalPadding;
  const ButtomSheet({
    super.key,
    required this.onTap,
    required this.price,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.width,
    this.height,
    required this.horizontalPadding,
    required this.pricetext,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CustomText(
                text: pricetext,
                fontSize: fontSize ?? 32,
                fontWeight: fontWeight ?? FontWeight.bold,
              ),

              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '\$',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: fontSize ?? 32,
                        fontWeight: fontWeight ?? FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: price,
                      style: TextStyle(
                        color: color ?? Colors.black,
                        fontSize: fontSize ?? 32,
                        fontWeight: fontWeight ?? FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: CustomContanier(
            onTap: () {
              onTap();
            },
            text: text,
            width: width ?? 150,
            height: height ?? 55,
            radius: 18,
          ),
        ),
      ],
    );
  }
}
