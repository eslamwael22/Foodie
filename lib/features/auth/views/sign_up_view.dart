import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/widgets/custom_text_field.dart';
import 'package:foodie/features/auth/widgets/custom_buttom.dart';
import 'package:gap/gap.dart';

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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Gap(100),
                  SvgPicture.asset("assets/images/Hungry_.svg"),
                  const Gap(30),
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
                  Gap(20),
                  CustomButom(formKey: _formKey, text: 'Sign Up'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
