import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/widgets/custom_text.dart';

class PaymentMethods extends StatelessWidget {
  final String image;
  final String title;
  final String value;
  final String? subtitle;
  final Color textcolor;
  final Color tilecolor;
  final String groupValue;
  final VoidCallback? onTap;

  final ValueChanged<String?> onChanged;
  const PaymentMethods({
    super.key,
    required this.image,
    required this.title,
    required this.value,
    required this.tilecolor,
    this.onTap,
    required this.onChanged,
    required this.groupValue,
    required this.textcolor,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Center(
        child: ListTile(
          onTap: onTap,
          minTileHeight: 80,
          textColor: textcolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          tileColor: tilecolor,
          leading: Image.asset(image, height: 70, width: 50),
          title: Column(
            mainAxisAlignment: subtitle == null
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              if (subtitle != null)
                CustomText(text: subtitle!, fontSize: 14, color: Colors.grey),
            ],
          ),
          trailing: Radio<String?>(
            enabled: true,
            focusColor: Colors.yellowAccent,
            hoverColor: Colors.yellowAccent,
            activeColor: Colors.white,
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ),
    );
  }
}
