import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/core/widgets/custom_contanier.dart';
import 'package:foodie/core/widgets/custom_text.dart';
import 'package:foodie/features/cart/data/cart_model.dart';
import 'package:foodie/features/cart/widgets/counter_button.dart';
import 'package:foodie/features/cart/widgets/product_image.dart';
import 'package:foodie/features/home/data/models/product_model.dart';
import 'package:gap/gap.dart';

class CartItem extends StatelessWidget {
  final CartProduct item;
  final ProductModel? firebaseProduct;
  final double? displayPrice;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const CartItem({
    super.key,
    required this.item,
    this.firebaseProduct,
    this.displayPrice,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final unitPrice =
        displayPrice ??
        firebaseProduct?.price.toDouble() ??
        item.price.toDouble();
    final itemTotalPrice = unitPrice * item.count;

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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductImage(
                      imageUrl:
                          firebaseProduct?.imageUrl ?? item.product.imageCover,
                    ),
                    CustomText(
                      text: firebaseProduct?.name ?? item.product.title,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    const Gap(2),
                  ],
                ),
              ),
              const Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(14),
                  Row(
                    children: [
                      counterButton(
                        icon: CupertinoIcons.minus,
                        onTap: onDecrement,
                      ),
                      const Gap(24),
                      CustomText(
                        text: '${item.count}',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      const Gap(24),
                      counterButton(
                        icon: CupertinoIcons.add,
                        onTap: onIncrement,
                      ),
                    ],
                  ),
                  const Gap(14),
                  CustomText(
                    text: '$itemTotalPrice L.E',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  const Gap(12),
                  CustomContanier(
                    icon: CupertinoIcons.delete,
                    text: 'Remove',
                    width: 150,
                    height: 42,
                    radius: 10,
                    onTap: onRemove,
                    fontSize: 18,
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
