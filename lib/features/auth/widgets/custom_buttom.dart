import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/widgets/custom_text.dart';

class CustomButom extends StatefulWidget {
  const CustomButom({
    super.key,
    required this.formKey,
    required this.text,
    this.onTap,
    this.color,
    this.textColor,
  });

  final GlobalKey<FormState> formKey;
  final String text;
  final Future<void> Function()? onTap;
  final Color? color;
  final Color? textColor;

  @override
  State<CustomButom> createState() => _CustomButomState();
}

class _CustomButomState extends State<CustomButom> {
  double get screenWidth => MediaQuery.sizeOf(context).width;
  bool _isLoading = false;

  Future<void> _handleTap() async {
    if (_isLoading) return;

    if (!widget.formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await widget.onTap?.call();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
        width: _isLoading ? 55 : screenWidth - 40,
        height: 55,
        decoration: BoxDecoration(
          color: widget.color ?? Colors.white,
          borderRadius: BorderRadius.circular(_isLoading ? 30 : 15),
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 700),
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: _isLoading
                ? SizedBox(
                    key: const ValueKey('loading'),
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: widget.textColor ?? AppColors.primary,
                    ),
                  )
                : CustomText(
                    key: const ValueKey('text'),
                    fontSize: 20,
                    text: widget.text,
                    color: widget.textColor ?? AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
          ),
        ),
      ),
    );
  }
}
