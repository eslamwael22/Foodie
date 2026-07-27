import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/widgets/custom_text.dart';

class ToppingCard extends StatefulWidget {
  final String image;
  final String title;

  const ToppingCard({super.key, required this.image, required this.title});

  @override
  State<ToppingCard> createState() => _ToppingCardState();
}

class _ToppingCardState extends State<ToppingCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: Center(
              child: Image.asset(widget.image, height: 90, fit: BoxFit.contain),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xff433636),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: CustomText(
                    text: widget.title,
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    setState(() {});
                  },
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.add, color: Colors.white, size: 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
