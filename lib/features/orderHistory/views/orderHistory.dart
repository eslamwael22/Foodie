import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/core/widgets/custom_contanier.dart';
import 'package:foodie/core/widgets/custom_text.dart';
import 'package:gap/gap.dart';

class Orderhistory extends StatelessWidget {
  const Orderhistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: CustomText(
            text: 'Order History',
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 120),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Card(
              elevation: 2,
              color: Colors.white,
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
                        CustomText(
                          text: 'Hamburger',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        Gap(2),
                        CustomText(text: 'Veggie Burger'),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Code:#123456',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        Gap(2),
                        CustomText(text: 'Quantity: X 2'),
                        Gap(2),
                        CustomText(text: 'Total: \$18.19'),
                        Gap(20),
                        CustomContanier(
                          text: 'Reorder',
                          onTap: () {},
                          width: 170,
                          height: 50,
                          radius: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
