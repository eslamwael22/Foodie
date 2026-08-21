import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/widgets/custom_text.dart';
import 'package:foodie/features/home/data/models/product_model.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Carditem extends StatefulWidget {
  final ProductModel product;

  const Carditem({super.key, required this.product});

  @override
  State<Carditem> createState() => _CarditemState();
}

class _CarditemState extends State<Carditem> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      shadowColor: AppColors.white,
      elevation: 5,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= IMAGE =================
            Center(
              child: SizedBox(
                height: 130,
                width: 165,
                child: CachedNetworkImage(
                  imageUrl: widget.product.imageUrl,
                  fit: BoxFit.contain,

                  // Loading
                  placeholder: (context, url) {
                    return Center(
                      child: LoadingAnimationWidget.fallingDot(
                        color: AppColors.primary,
                        size: 40,
                      ),
                    );
                  },

                  // Error
                  errorWidget: (context, url, error) {
                    return const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 45,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),

            const Gap(7),

            // ================= NAME =================
            CustomText(
              text: widget.product.name,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const Gap(5),

            // ================= SUBTITLE =================
            CustomText(
              text: widget.product.subtitle,
              fontSize: 16,
              fontWeight: FontWeight.w300,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const Gap(5),

            // ================= PRICE + RATING + FAVORITE =================
            Row(
              children: [
                CustomText(
                  text: '\EGP${widget.product.price.toStringAsFixed(1)}',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),

                const Gap(3),

                Icon(Icons.star, color: Colors.yellow.shade600, size: 18),

                const Gap(1),

                CustomText(
                  text: widget.product.rating.toString(),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),

                const Spacer(),

                SizedBox(
                  width: 23,
                  height: 40,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
