import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/widgets/custom_text.dart';

class CustomButom extends StatelessWidget {
  const CustomButom({
    super.key,
    required this._formKey,
    required this.text,
    this.onTap,
    this.color,
    this.textColor,
  });

  final GlobalKey<FormState> _formKey;
  final String text;
  final VoidCallback? onTap;
  final Color? color;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          print('Form is valid');
          onTap!();
        }
      },
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color ?? Colors.white,
        ),
        child: Center(
          child: CustomText(
            fontSize: 20,
            text: text,
            color: textColor ?? AppColors.primary,
            fontWeight: FontWeight.bold,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
