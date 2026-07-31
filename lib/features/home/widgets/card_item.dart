import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/widgets/custom_text.dart';
import 'package:gap/gap.dart';

class Carditem extends StatefulWidget {
  final String title;
  final String subtitle;
  final String rating;
  final String image;

  const Carditem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.image,
  });

  @override
  State<Carditem> createState() => _CarditemState();
}

class _CarditemState extends State<Carditem> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.white,
      elevation: 5,
      child: Container(
        width: 180,
        height: 225,
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(widget.image, height: 110)),
            Gap(7),
            CustomText(
              text: widget.title,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            CustomText(
              text: widget.subtitle,
              fontSize: 16,
              fontWeight: FontWeight.w300,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow.shade600),
                Gap(5),
                CustomText(
                  text: widget.rating,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? AppColors.primary : AppColors.primary,
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
