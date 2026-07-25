import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/features/cart/views/cart_view.dart';
import 'package:foodie/features/home/views/home_view.dart';
import 'package:foodie/features/orderHistory/views/orderHistory.dart';
import 'package:foodie/features/profile/views/profile_view.dart';

class Roots extends StatefulWidget {
  const Roots({super.key});

  @override
  State<Roots> createState() => _RootsState();
}

class _RootsState extends State<Roots> {
  int currentIndex = 0;
  final pages = [HomeView(), Orderhistory(), CartView(), ProfileView()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
        child: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.shade600,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          backgroundColor: AppColors.primary,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_restaurant_outlined),
              label: 'Order History',
            ),

            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_alt_circle),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
