import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/widgets/CUSTOM_TEXT.DART';
import 'package:gap/gap.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Gap(200), SvgPicture.asset("assets/images/Hungry_.svg")],
        ),
      ),
    );
  }
}
