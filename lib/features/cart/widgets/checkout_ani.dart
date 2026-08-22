import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AnimatedCheckoutButton extends StatefulWidget {
  final double totalPrice;

  const AnimatedCheckoutButton({super.key, required this.totalPrice});

  @override
  State<AnimatedCheckoutButton> createState() => _AnimatedCheckoutButtonState();
}

class _AnimatedCheckoutButtonState extends State<AnimatedCheckoutButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconPosition;
  late Animation<double> _textOpacity;

  static const double _buttonWidth = 170;
  static const double _iconSize = 23;
  static const double _iconStartLeft = 20; // مكان الأيقونة الأول (جنب النص)
  static const double _iconEndLeft =
      _buttonWidth - _iconSize - 20; // أقصى اليمين

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _iconPosition = Tween<double>(
      begin: _iconStartLeft,
      end: _iconEndLeft,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _textOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          0.5,
          curve: Curves.easeOut,
        ), // النص يختفي بسرعة في أول نص الأنيميشن
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    await _controller.forward();

    if (!mounted) return;

    context.push('/Checkout', extra: widget.totalPrice);

    _controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: _buttonWidth,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // النص بيختفي تدريجيًا
                Opacity(
                  opacity: _textOpacity.value,
                  child: const Text(
                    'Checkout',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // الأيقونة بتتحرك من الشمال للجنب/اليمين
                Positioned(
                  left: _iconPosition.value,
                  child: const Icon(
                    Icons.shopping_cart_checkout,
                    color: AppColors.white,
                    size: _iconSize,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
