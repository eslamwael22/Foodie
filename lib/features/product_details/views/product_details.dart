import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/network/api_errors.dart';
import 'package:foodie/core/network/api_service.dart';
import 'package:foodie/core/widgets/buttom_sheet.dart';
import 'package:foodie/core/widgets/custom_text.dart';
import 'package:foodie/features/cart/data/cart_repository.dart';
import 'package:foodie/features/home/data/models/product_model.dart';
import 'package:foodie/features/product_details/data/options_data.dart';
import 'package:foodie/features/product_details/data/toping_data.dart';
import 'package:foodie/features/product_details/widgets/CustomSlider.dart';
import 'package:foodie/features/product_details/widgets/FlyToCartController.dart';
import 'package:foodie/features/product_details/widgets/toping_card.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsview extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsview({super.key, required this.product});

  @override
  State<ProductDetailsview> createState() => _ProductDetailsviewState();
}

class _ProductDetailsviewState extends State<ProductDetailsview> {
  late double totalPrice;
  final CartRepository _cartRepository = CartRepository(ApiService());
  final GlobalKey _cartIconKey = GlobalKey();
  final GlobalKey _addToCartKey = GlobalKey();

  int cartCount = 0;

  @override
  void initState() {
    super.initState();
    totalPrice = widget.product.price;
  }

  void _addItemPrice(String price) {
    setState(() {
      totalPrice += double.parse(price);
    });
  }

  Future<void> _handleAddToCart() async {
    try {
      final response = await _cartRepository.addToCart(
        widget.product.apiProductId,
      );

      debugPrint('Add to cart response: $response');

      if (!mounted) return;

      FlyToCartController.fly(
        context: context,
        fromKey: _addToCartKey,
        toKey: _cartIconKey,
        flyingWidget: Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.shopping_bag, color: Colors.white, size: 18),
        ),
        onComplete: () {
          if (!mounted) return;

          setState(() {
            cartCount++;
          });

          context.push('/Cart');
        },
      );
    } catch (e) {
      debugPrint('================ CART ERROR ================');
      debugPrint(e.toString());
      debugPrint('============================================');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e is ApiError ? e.message : e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              const Spacer(),
              IconButton(
                key: _cartIconKey,
                onPressed: () {
                  context.push('/Cart');
                },
                icon: Badge(
                  backgroundColor: AppColors.primary,
                  label: Text(
                    '$cartCount',
                    style: const TextStyle(color: Colors.white),
                  ),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 140),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
          child: Container(
            key: _addToCartKey,
            child: ButtomSheet(
              text: 'Add to Cart',
              onTap: _handleAddToCart,
              price: totalPrice.toString(),
              pricetext: 'Total',
            ),
          ),
        ),
      ),
    );
  }
}
