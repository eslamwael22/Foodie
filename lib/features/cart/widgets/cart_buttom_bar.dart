import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:foodie/core/widgets/custom_text.dart';
import 'package:foodie/features/cart/widgets/checkout_ani.dart';
import 'package:gap/gap.dart';

class CartButtomBar extends StatelessWidget {
  final double totalPrice;

  const CartButtomBar({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 110,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: 'Total',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  DottedLine(
                    direction: Axis.horizontal,
                    lineLength: 210,
                    lineThickness: 1.5,
                    dashLength: 5,
                    dashColor: Colors.grey,
                  ),
                  CustomText(
                    text: '$totalPrice L.E',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              Gap(20),
              Align(
                alignment: Alignment.center,
                child: AnimatedCheckoutButton(totalPrice: totalPrice),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
