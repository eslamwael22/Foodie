import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/widgets/buttom_sheet.dart';
import 'package:foodie/core/widgets/custom_text.dart';
import 'package:foodie/features/product_details/data/options_data.dart';
import 'package:foodie/features/product_details/data/toping_data.dart';
import 'package:foodie/features/product_details/widgets/CustomSlider.dart';
import 'package:foodie/features/product_details/widgets/toping_card.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsview extends StatefulWidget {
  const ProductDetailsview({super.key});

  @override
  State<ProductDetailsview> createState() => _ProductDetailsviewState();
}

class _ProductDetailsviewState extends State<ProductDetailsview> {
  static const double basePrice = 18.19;
  double totalPrice = basePrice;

  void _addItemPrice(String price) {
    setState(() {
      totalPrice += double.parse(price);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(CupertinoIcons.back, size: 30),
                ),
              ),
            ),
            Row(
              children: [
                Image.asset('assets/images/pngwing 12.png', height: 250),
                Gap(20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Customize',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' Your Burger\n'
                                    'to Your Tastes. Ultimate\n'
                                    'Experience',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(10),
                        CustomText(
                          text: 'Spicy',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        Transform.translate(
                          offset: const Offset(-18, 0),
                          child: CustomSlider(),
                        ),
                        Gap(5),
                        Row(
                          children: [
                            Image.asset('assets/images/🥶.png'),
                            Gap(160),
                            Image.asset('assets/images/🌶️.png'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Gap(15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: CustomText(
                  text: 'Add Toppings',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 126,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: toppings.length,
                  itemBuilder: (context, index) {
                    return ToppingCard(
                      image: toppings[index]["image"]!,
                      title: toppings[index]["title"]!,
                      price: toppings[index]["price"]!,
                      onAdd: () => _addItemPrice(toppings[index]["price"]!),
                    );
                  },
                ),
              ),
            ),
            Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: CustomText(
                  text: 'Add Options',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Gap(10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: SizedBox(
                height: 126,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return ToppingCard(
                      image: options[index]["image"]!,
                      title: options[index]["title"]!,
                      price: options[index]["price"]!,
                      onAdd: () => _addItemPrice(options[index]["price"]!),
                    );
                  },
                ),
              ),
            ),
            Gap(50),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.grey.shade200,
        child: SafeArea(
          top: false,
          child: ButtomSheet(
            text: 'Add to Cart',
            onTap: () {
              context.push('/Cart');
            },
            price: totalPrice.toStringAsFixed(2),
            pricetext: 'Total',
          ),
        ),
      ),
    );
  }
}
