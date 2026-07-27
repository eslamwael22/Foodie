import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/core/widgets/custom_text.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        child: Row(
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/image 4.png',
                  height: 250,
                  width: 250,
                ),
                CustomText(text: 'Hamburger'),
                CustomText(text: 'Veggie Burger'),
              ],
            ),

            Column(children: []),
          ],
        ),
      ),
    );
  }
}
