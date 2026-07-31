import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/widgets/custom_text.dart';
import 'package:foodie/core/widgets/custom_text_field.dart';
import 'package:foodie/features/auth/widgets/custom_buttom.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final namecontroller = TextEditingController();
  final confirmpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Gap(40),
                  SvgPicture.asset(
                    "assets/images/Hungry_.svg",
                    color: const Color(0xFFF4D03F),
                  ),
                  Gap(20),
                  const CustomText(
                    text:
                        'Create an account to Start Ordering Your Favourite Food',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                  const Gap(40),
                  CustomTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name is required";
                      }
                      if (!RegExp(r'^[A-Z]').hasMatch(value)) {
                        return "First letter must be capital";
                      }
                      return null;
                    },
                    controller: namecontroller,
                    hintText: ' Name',
                    obscureText: false,
                    keyboardType: TextInputType.name,
                  ),
                  Gap(20),
                  CustomTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      }

                      if (!value.contains("@")) {
                        return "Enter a valid email";
                      }

                      return null;
                    },
                    controller: emailController,
                    hintText: ' Email Address',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  Gap(20),
                  CustomTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }

                      if (value.length < 8) {
                        return "Password must be at least 8 characters";
                      }

                      return null;
                    },
                    suffixIcon: CupertinoIcons.eye,
                    controller: passwordController,
                    hintText: ' Password',
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  Gap(20),
                  CustomTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return " Confirm Password is required";
                      }

                      if (value.length < 8) {
                        return "Password must be at least 8 characters";
                      }
                      if (value != passwordController.text) {
                        return "Password does not match";
                      }
                      return null;
                    },
                    suffixIcon: CupertinoIcons.eye,
                    controller: confirmpasswordController,
                    hintText: ' Confirm Password',
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const Gap(30),
                  CustomButom(
                    formKey: _formKey,
                    text: 'Sign Up',
                    onTap: () {},
                    color: const Color(0xFFF4D03F),
                    textColor: AppColors.primary,
                  ),
                  Gap(20),
                  Row(
                    children: [
                      Expanded(
                        child: DottedLine(
                          lineLength: 130,
                          dashLength: 6,
                          dashGapLength: 4,
                          lineThickness: 1,
                          dashColor: AppColors.yellow,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          "OR",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: DottedLine(
                          lineLength: 130,
                          dashLength: 5,
                          dashGapLength: 4,
                          lineThickness: 1,
                          dashColor: AppColors.yellow,
                        ),
                      ),
                    ],
                  ),
                  Gap(20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Gap(5),
                      GestureDetector(
                        onTap: () {
                          context.push('/Login');
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: const Color(0xFFF4D03F),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
