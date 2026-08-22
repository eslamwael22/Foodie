import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/utils/pref_helpers.dart';
import 'package:foodie/core/widgets/custom_text.dart';
import 'package:foodie/features/home/data/models/product_model.dart';
import 'package:foodie/features/home/data/services/product_service.dart';
import 'package:foodie/features/home/widgets/card_item.dart';
import 'package:foodie/features/home/widgets/search_Text_Filed.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String userName = '';
  String userEmail = '';
  List<String> categories = ['All', 'Burgers', 'Sandwiches', 'Pizzas'];
  int currentIndex = 0;
  String searchQuery = '';
  final ProductService _productService = ProductService();
  late Future<List<ProductModel>> _productsFuture;

  @override
  void initState() {
    super.initState();

    _loadUserData();
    _loadProfileImage();

    _productsFuture = _productService.getProducts();
  }

  Future<void> _loadProfileImage() async {
    final imagePath = await PrefHelpers.getProfileImagePath();

    if (!mounted || imagePath == null || !await File(imagePath).exists()) {
      return;
    }

    PrefHelpers.profileImagePath.value = imagePath;
  }

  Future<void> _loadUserData() async {
    final name = await PrefHelpers.getUserName();
    final email = await PrefHelpers.getUserEmail();

    if (!mounted) return;

    setState(() {
      userName = name ?? '';
      userEmail = email ?? '';
    });
  }

  bool _matchesCategory(ProductModel product) {
    if (currentIndex == 0) return true;

    final category = product.category;
    final searchableText = '${product.name} ${product.subtitle} $category'
        .toLowerCase();

    switch (categories[currentIndex]) {
      case 'Burgers':
        return searchableText.contains('burger') || category.contains('slider');
      case 'Sandwiches':
        return searchableText.contains('sandwich') ||
            searchableText.contains('sandwitch') ||
            category.contains('sand');
      case 'Pizzas':
        return searchableText.contains('pizza') || category.contains('pizz');
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),

                // ================= HEADER =================
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/Hungry_.svg',
                      width: 110,
                      height: 30,
                      color: AppColors.primary,
                    ),

                    const Spacer(),

                    ValueListenableBuilder<String?>(
                      valueListenable: PrefHelpers.profileImagePath,
                      builder: (context, imagePath, child) {
                        return CircleAvatar(
                          radius: 25,
                          backgroundColor: AppColors.primary,
                          backgroundImage: imagePath == null
                              ? null
                              : FileImage(File(imagePath)),
                          child: imagePath == null
                              ? const Icon(Icons.person, color: Colors.white)
                              : null,
                        );
                      },
                    ),
                  ],
                ),

                const Gap(2),

                // ================= HELLO =================
                CustomText(
                  text: 'Hello, $userName',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),

                const Gap(15),

                // ================= SEARCH =================
                Searchtextfiled(
                  hintText: 'Search for food ..',
                  icon: Icons.search,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.trim().toLowerCase();
                    });
                  },
                ),

                const Gap(25),

                // ================= CATEGORIES =================
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

                const Gap(15),

                // ================= PRODUCTS =================
                Expanded(
                  child: FutureBuilder<List<ProductModel>>(
                    future: _productsFuture,
                    builder: (context, snapshot) {
                      // Loading
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: LoadingAnimationWidget.dotsTriangle(
                            color: AppColors.primary,
                            size: 80,
                          ),
                        );
                      }

                      // Error
                      if (snapshot.hasError) {
                        return Center(
                          child: CustomText(
                            text: 'Something went wrong\n${snapshot.error}',
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        );
                      }

                      // Data
                      final products = snapshot.data ?? [];

                      // Empty
                      if (products.isEmpty) {
                        return const Center(
                          child: CustomText(
                            text: 'No products found',
                            fontSize: 18,
                          ),
                        );
                      }

                      final filteredProducts = products.where((product) {
                        final name = product.name.toLowerCase();
                        final subtitle = product.subtitle.toLowerCase();

                        final matchesSearch =
                            name.contains(searchQuery) ||
                            subtitle.contains(searchQuery);

                        return matchesSearch && _matchesCategory(product);
                      }).toList();

                      if (filteredProducts.isEmpty) {
                        return const Center(
                          child: CustomText(
                            text: 'No products found...',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      }

                      return GridView.builder(
                        itemCount: filteredProducts.length,
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 9,
                              childAspectRatio: 0.68,
                            ),
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];

                          return InkWell(
                            onTap: () {
                              context.push('/Proudcts', extra: product);
                            },
                            child: Carditem(product: product),
                          );
                        },
                      );
                    },
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
