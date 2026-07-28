import 'package:flutter/cupertino.dart';
import 'package:foodie/core/widgets/custom_text.dart';

class CustomOrderSummary extends StatelessWidget {
  final String text;
  final String price;
  final FontWeight? fontWeight;
  final double? fontSize;
  const CustomOrderSummary({
    super.key,
    required this.text,
    required this.price,
    this.fontWeight,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: text, fontSize: 18, fontWeight: fontWeight),
          CustomText(text: price, fontSize: 18, fontWeight: fontWeight),
        ],
      ),
    );
  }
}
