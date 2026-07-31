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
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Material(
        color: tilecolor,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(image, height: 70, width: 50),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: title,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: textcolor,
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        CustomText(
                          text: subtitle!,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ],
                    ],
                  ),
                ),
                Radio<String?>(
                  enabled: true,
                  focusColor: Colors.yellowAccent,
                  hoverColor: Colors.yellowAccent,
                  activeColor: Colors.white,
                  value: value,
                  groupValue: groupValue,
                  onChanged: onChanged,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
