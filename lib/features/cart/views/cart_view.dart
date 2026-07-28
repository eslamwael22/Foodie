import 'package:flutter/material.dart';
import 'package:foodie/core/widgets/custom_contanier.dart';
import 'package:foodie/core/widgets/custom_text.dart';
import 'package:foodie/features/cart/widgets/cart_item.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(backgroundColor: Colors.white, scrolledUnderElevation: 0),

      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 120),
        itemCount: 4,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: CartItem(),
          );
        },
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Container(
            height: 90,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(text: 'Total', fontSize: 20),
                    const Gap(5),
                    CustomText(
                      text: '\$18.19',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),

                const Spacer(),

                CustomContanier(
                  onTap: () {
                    context.push('/Checkout');
                  },
                  text: 'Checkout',
                  width: 160,
                  height: 50,
                  radius: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
