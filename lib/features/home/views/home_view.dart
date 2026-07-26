import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/widgets/custom_text.dart';
import 'package:foodie/features/home/widgets/search_Text_Filed.dart';
import 'package:gap/gap.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> categories = ['All', 'compos', 'sliders', 'classic', 'pizzas'];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/Hungry_.svg',
                      width: 110,
                      height: 30,
                      color: AppColors.primary,
                    ),

                    const Spacer(),

                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.greenAccent,
                    ),
                  ],
                ),

                const Gap(2),

                const CustomText(
                  text: 'Hello, Eslam Wael',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),

                const Gap(15),

                Searchtextfiled(
                  hintText: 'Search for food ..',
                  icon: Icons.search,
                ),
                const Gap(25),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      categories.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: currentIndex == index
                                  ? AppColors.primary
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            child: CustomText(
                              text: categories[index],
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: currentIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
