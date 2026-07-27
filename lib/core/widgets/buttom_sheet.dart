import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/widgets/custom_contanier.dart';
import 'package:foodie/core/widgets/custom_text.dart';
import 'package:go_router/go_router.dart';

class ButtomSheet extends StatelessWidget {
  const ButtomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CustomText(
                text: 'Total Price',
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),

              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '\$',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '18.19',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CustomContanier(
            onTap: () {
              context.push('/Cart');
            },
            text: 'Add to Cart',
            width: 200,
            height: 70,
            radius: 18,
          ),
        ),
      ],
    );
  }
}
