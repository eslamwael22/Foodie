import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/widgets/custom_text.dart';

class ToppingCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final VoidCallback onAdd;

  const ToppingCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: Center(
              child: Image.asset(image, height: 90, fit: BoxFit.contain),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            height: 46,
            decoration: const BoxDecoration(
              color: AppColors.darkBrown,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: title,
                        color: AppColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 2,
                        ),
                        child: CustomText(
                          text: '\$$price',
                          color: AppColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: onAdd,
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: AppColors.errorRed,
                    child: Icon(Icons.add, color: AppColors.white, size: 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
