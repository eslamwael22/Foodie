import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({super.key});

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double value = 50;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        overlayShape: const RoundSliderOverlayShape(
          overlayRadius: 15, // صغرها زي ما تحب
        ),
        trackHeight: 5,
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: Colors.green.shade200,
        thumbColor: const Color(0xff0B4D2C),
        overlayColor: Colors.green.shade300,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
      ),
      child: Slider(
        min: 0,
        max: 100,
        value: value,
        onChanged: (newValue) {
          setState(() {
            value = newValue;
          });
        },
      ),
    );
  }
}
