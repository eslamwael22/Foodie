import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:gap/gap.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Gap(300),
            SvgPicture.asset("assets/images/Hungry_.svg"),
            Spacer(),
            Image.asset("assets/images/image 1.png"),
          ],
        ),
      ),
    );
  }
}
