import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/network/api_errors.dart';
import 'package:foodie/core/widgets/custom_snak_bar.dart';
import 'package:foodie/core/widgets/custom_text.dart';
import 'package:foodie/core/widgets/custom_text_field.dart';
import 'package:foodie/features/auth/data/auth_repo.dart';
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
  final phoneController = TextEditingController();
  AuthRepo authRepo = AuthRepo();
  Future<void> signUp() async {
    try {
      final user = await authRepo.signUp(
        namecontroller.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
        confirmpasswordController.text.trim(),
      );

      if (mounted && user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );

        await Future.delayed(const Duration(seconds: 2));

        if (mounted) {
          context.go('/Login');
        }
      }
    } catch (e) {
      if (mounted) {
        String message = 'Something went wrong';

        if (e is ApiError) {
          message = e.message;
        }

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(customSnackBar(message: message));
      }
    }
  }

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
                  const Gap(60),
                  SvgPicture.asset(
                    "assets/images/Hungry_.svg",
                    color: AppColors.yellow,
                  ),
                  Gap(20),
                  const CustomText(
                    text: 'Create an account & discover delicious dishes',
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
                    keyboardType: TextInputType.visiblePassword,
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
                    keyboardType: TextInputType.visiblePassword,
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
                  Gap(20),
                  const Gap(30),
                  CustomButom(
                    formKey: _formKey,
                    text: 'Sign Up',
                    onTap: signUp,
                    color: AppColors.yellow,
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
                            color: AppColors.yellow,
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
                            color: AppColors.yellow,
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
