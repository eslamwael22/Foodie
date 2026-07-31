import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/widgets/custom_text.dart';
import 'package:foodie/core/widgets/custom_text_field.dart';
import 'package:foodie/features/auth/widgets/custom_buttom.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LogInView extends StatefulWidget {
  LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            reverse: true,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Gap(130),
                  SvgPicture.asset(
                    "assets/images/Hungry_.svg",
                    color: const Color(0xFFF4D03F),
                  ),

                  const Gap(40),

                  const CustomText(
                    text: 'Welcome Back, Discover More Delicious Dishes',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),

                  const Gap(50),

                  CustomTextField(
                    keyboardType: TextInputType.visiblePassword,
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
                    hintText: 'Email Address',
                    hintStyle: const Color(0xFF9E9E9E),
                    obscureText: false,
                  ),
                  const Gap(30),
                  CustomTextField(
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }

                      if (value.length < 8) {
                        return "Password must be at least 8 characters";
                      }

                      return null;
                    },
                    obscureText: true,
                    suffixIcon: CupertinoIcons.eye,
                    controller: passwordController,
                    hintText: 'Password',
                    hintStyle: Colors.grey,
                  ),
                  Gap(10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomText(
                      onTap: () {},
                      text: 'Forgot Password?',
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Gap(20),
                  CustomButom(
                    formKey: _formKey,
                    text: 'Log In',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context.go('/Roots');
                      }
                    },
                    color: const Color(0xFFF4D03F),
                    textColor: const Color(0xFF8E244D),
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Gap(5),
                      GestureDetector(
                        onTap: () {
                          context.push('/signup');
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: const Color(0xFFF4D03F),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
                          dashColor: const Color(0xFFFFE7A3),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          "OR",
                          style: TextStyle(
                            color: const Color(0xFFFFE7A3),
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
                          dashColor: const Color(0xFFFFE7A3),
                        ),
                      ),
                    ],
                  ),

                  Gap(20),
                  GestureDetector(
                    onTap: () => context.go('/Roots'),
                    child: CustomText(
                      text: 'Continue as Guest ?',
                      fontSize: 15,
                      color: Color(0xffF4D03F),
                      fontWeight: FontWeight.w700,
                    ),
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
