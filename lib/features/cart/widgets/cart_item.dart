import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/core/widgets/custom_contanier.dart';
import 'package:foodie/core/widgets/custom_text.dart';
import 'package:foodie/features/cart/widgets/counter_button.dart';
import 'package:gap/gap.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int quantity = 1;

  void increment() {
    setState(() {
      quantity++;
    });
  }

  void decrement() {
    setState(() {
      if (quantity > 1) quantity--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 185,
      child: Card(
        color: Colors.white,
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/image 4.png',
                    height: 100,
                    width: 150,
                    fit: BoxFit.contain,
                  ),
                  const CustomText(
                    text: 'Hamburger',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  const Gap(2),
                  const CustomText(text: 'Veggie Burger'),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(20),
                  Row(
                    children: [
                      counterButton(
                        icon: CupertinoIcons.minus,
                        onTap: decrement,
                      ),
                      const Gap(30),
                      CustomText(
                        text: '$quantity',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      const Gap(30),
                      counterButton(icon: CupertinoIcons.add, onTap: increment),
                    ],
                  ),
                  const Gap(20),
                  CustomContanier(
                    text: 'Remove',
                    width: 150,
                    height: 45,
                    radius: 30,
                    onTap: () {},
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
