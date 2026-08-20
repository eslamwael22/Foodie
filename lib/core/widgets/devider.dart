import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';

class Devider extends StatelessWidget {
  const Devider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColors.borderGrey,
      thickness: 0.5,
      indent: 10,
      endIndent: 10,
    );
  }
}
