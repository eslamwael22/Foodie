import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/utils/pref_helpers.dart';
import 'package:foodie/core/widgets/custom_contanier.dart';
import 'package:foodie/core/widgets/custom_text.dart';
import 'package:foodie/core/widgets/devider.dart';
import 'package:foodie/features/checkout/widgets/payment_methods.dart';
import 'package:foodie/features/profile/widgets/info_item.dart';
import 'package:foodie/features/profile/widgets/notification_icon.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String userName = '';
  String userEmail = '';
  File? imageFile;
  String selectedPayment = "Debit Card";

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final deliveryAddressController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
    _loadUserData();
  }

  Future<void> _loadProfileImage() async {
    final imagePath = await PrefHelpers.getProfileImagePath();

    if (!mounted || imagePath == null) return;

    final savedImage = File(imagePath);
    if (await savedImage.exists()) {
      PrefHelpers.profileImagePath.value = savedImage.path;
      setState(() {
        imageFile = savedImage;
      });
    } else {
      await PrefHelpers.clearProfileImage();
    }
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

  Future<void> saveProfileImage(File image) async {
    await PrefHelpers.saveProfileImage(image);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    deliveryAddressController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                const CustomText(
                  text: 'Profile',
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
                const Spacer(),
                const Notificationicon(),
              ],
            ),
          ),
        ),

        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    width: 125,
                    height: 125,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        // Avatar
                        Container(
                          width: 118,
                          height: 118,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary.withOpacity(0.08),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: imageFile != null
                              ? Image.file(imageFile!, fit: BoxFit.cover)
                              : const Icon(
                                  CupertinoIcons.person_fill,
                                  size: 58,
                                  color: AppColors.primary,
                                ),
                        ),

                        // Camera Button
                        Positioned(
                          right: -2,
                          bottom: 2,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(11),
                              border: Border.all(
                                color: AppColors.white,
                                width: 3,
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                final pickedImage = await pickimage();
                                if (pickedImage != null && mounted) {
                                  setState(() {
                                    imageFile = pickedImage;
                                  });
                                  await saveProfileImage(pickedImage);
                                }
                              },
                              child: const Icon(
                                CupertinoIcons.camera_fill,
                                color: AppColors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Gap(5),

                Center(
                  child: CustomText(
                    text: userName,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),

                const Gap(4),

                Center(
                  child: CustomText(
                    text: userEmail,
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),

                const Gap(25),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.07),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Title
                      CustomText(
                        text: 'Account Information',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),

                      const Gap(12),

                      // Name
                      buildInfoItem(
                        icon: Icons.person,
                        title: 'Name',
                        value: userName,
                      ),

                      const Devider(),

                      // Email
                      buildInfoItem(
                        icon: Icons.email,
                        title: 'Email',
                        value: userEmail,
                      ),

                      const Devider(),

                      // Address
                      buildInfoItem(
                        icon: Icons.location_on,
                        title: 'Delivery Address',
                        value: 'Tanta, Egypt',
                      ),

                      const Devider(),

                      // Password
                      buildInfoItem(
                        icon: Icons.lock,
                        title: 'Password',
                        value: '••••••••',
                      ),
                    ],
                  ),
                ),

                const Gap(10),

                CustomText(
                  text: 'Payment Method',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),

                const Gap(12),

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
                    if (value == null) return;

                    setState(() {
                      selectedPayment = value;
                    });
                  },
                ),

                const Gap(22),

                CustomContanier(
                  fontSize: 17,
                  icon: Icons.edit_outlined,
                  text: 'Edit Profile',
                  color: AppColors.primary,
                  height: 45,
                  radius: 10,
                  textColor: AppColors.white,
                  fontWeight: FontWeight.w600,
                  width: double.infinity,
                  onTap: () {},
                ),

                const Gap(12),

                // Logout
                CustomContanier(
                  fontSize: 17,
                  text: 'Logout',
                  icon: Icons.logout_outlined,
                  color: AppColors.paleRed,
                  height: 45,
                  radius: 10,
                  textColor: AppColors.errorRed,
                  fontWeight: FontWeight.w600,
                  width: double.infinity,
                  onTap: () {
                    context.go('/Login');
                  },
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

Future<File?> pickimage() async {
  final pickedImage = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );
  return pickedImage == null ? null : File(pickedImage.path);
}
