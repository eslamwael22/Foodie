import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/widgets/custom_contanier.dart';
import 'package:foodie/features/checkout/widgets/payment_methods.dart';
import 'package:foodie/features/profile/widgets/profile_text_filed.dart';
import 'package:gap/gap.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isChecked = false;
  String selectedPayment = "Cash on Delivery";
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final DeliveryaddressController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          scrolledUnderElevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: CircleAvatar(
                    radius: 60,

                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        CupertinoIcons.person_fill,
                        size: 80,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              Gap(20),
              ProfileTextField(
                controller: nameController,
                labelText: 'Name',
                icon: CupertinoIcons.person_fill,
              ),
              ProfileTextField(
                controller: emailController,
                labelText: 'Email',
                icon: CupertinoIcons.mail,
              ),
              ProfileTextField(
                icon: CupertinoIcons.location_fill,
                controller: DeliveryaddressController,
                labelText: 'Delivery Address',
              ),
              ProfileTextField(
                icon: CupertinoIcons.lock_fill,
                controller: passwordController,
                labelText: 'Password',
              ),
              Gap(20),
              Divider(
                color: Colors.grey,
                thickness: 2,
                indent: 40,
                endIndent: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: PaymentMethods(
                  onTap: () {
                    setState(() {
                      selectedPayment = 'Debit Card';
                    });
                  },
                  image: 'assets/images/image 13.png',
                  title: 'Debit Card',
                  subtitle: '**** **** **** 1234',
                  value: 'Debit Card',
                  tilecolor: Color(0xffF3F4F6),
                  onChanged: (value) {
                    setState(() {
                      selectedPayment = value!;
                    });
                  },
                  groupValue: selectedPayment,
                  textcolor: Colors.black,
                ),
              ),
              Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomContanier(
                      text: 'Edit profile',
                      width: 150,
                      color: AppColors.white,
                      height: 55,
                      radius: 15,
                      fontWeight: FontWeight.w500,
                      textColor: Colors.black,
                      onTap: () {},
                    ),

                    CustomContanier(
                      text: 'Logout',
                      width: 150,
                      color: AppColors.white,
                      height: 55,
                      radius: 15,
                      fontWeight: FontWeight.w500,
                      textColor: AppColors.primary,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
