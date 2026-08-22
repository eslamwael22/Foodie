import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;

  const ProductImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return Image.asset(
        'assets/images/image 4.png',
        height: 100,
        width: 140,
        fit: BoxFit.contain,
      );
    }

    return Image.network(
      imageUrl,
      height: 100,
      width: 140,
      fit: BoxFit.contain,

      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }

        return SizedBox(
          height: 100,
          width: 140,
          child: Center(
            child: LoadingAnimationWidget.dotsTriangle(
              color: AppColors.primary,
              size: 30,
            ),
          ),
        );
      },

      // لو الصورة فشلت
      errorBuilder: (context, error, stackTrace) {
        return const SizedBox(
          height: 100,
          width: 140,
          child: Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              color: Colors.red,
              size: 30,
            ),
          ),
        );
      },
    );
  }
}
