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
  String selectedPayment = "Debit Card";

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final deliveryAddressController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white,

        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          iconTheme: const IconThemeData(color: AppColors.white),
        ),

        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const Gap(25),

                CircleAvatar(
                  radius: 62,
                  backgroundColor: AppColors.primary,
                  child: const CircleAvatar(
                    radius: 59,
                    backgroundColor: AppColors.white,
                    child: Icon(
                      Icons.person,
                      size: 70,
                      color: AppColors.primary,
                    ),
                  ),
                ),

                const Gap(30),

                ProfileTextField(
                  controller: nameController,
                  labelText: 'Name',
                  icon: CupertinoIcons.person_fill,
                ),

                const Gap(15),

                ProfileTextField(
                  controller: emailController,
                  labelText: 'Email',
                  icon: CupertinoIcons.mail,
                ),

                const Gap(15),

                ProfileTextField(
                  controller: deliveryAddressController,
                  labelText: 'Delivery Address',
                  icon: CupertinoIcons.location_fill,
                ),

                const Gap(15),

                ProfileTextField(
                  controller: passwordController,
                  labelText: 'Password',
                  icon: CupertinoIcons.lock_fill,
                ),

                const Gap(25),

                const Divider(
                  color: AppColors.borderGrey,
                  thickness: 1.5,
                  indent: 20,
                  endIndent: 20,
                ),

                const Gap(15),

                PaymentMethods(
                  image: 'assets/images/image 13.png',
                  title: 'Debit Card',
                  subtitle: '**** **** **** 1234',
                  value: 'Debit Card',
                  groupValue: selectedPayment,
                  tilecolor: AppColors.primary,
                  textcolor: Colors.black,
                  onTap: () {
                    setState(() {
                      selectedPayment = 'Debit Card';
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      selectedPayment = value!;
                    });
                  },
                ),

                const Gap(20),

                Row(
                  children: [
                    Expanded(
                      child: CustomContanier(
                        text: 'Edit Profile',
                        color: AppColors.primary,
                        height: 55,
                        radius: 15,
                        textColor: Colors.white,
                        fontWeight: FontWeight.w600,
                        onTap: () {},
                        width: double.infinity,
                      ),
                    ),

                    const Gap(15),

                    Expanded(
                      child: CustomContanier(
                        text: 'Logout',
                        color: AppColors.paleRed,
                        height: 55,
                        radius: 15,
                        textColor: AppColors.errorRed,
                        fontWeight: FontWeight.w600,
                        onTap: () {},
                        width: double.infinity,
                      ),
                    ),
                  ],
                ),

                const Gap(30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
