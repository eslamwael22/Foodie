import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodie/core/constants/app_colors.dart';
import 'package:foodie/core/widgets/custom_text.dart';
import 'package:foodie/core/widgets/custom_text_field.dart';
import 'package:foodie/features/auth/widgets/custom_buttom.dart';
import 'package:gap/gap.dart';

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
                  const Gap(200),
                  SvgPicture.asset("assets/images/Hungry_.svg"),

                  const Gap(20),

                  const CustomText(
                    text: 'Welcome Back, Discover More Delicious Dishes',
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),

                  const Gap(50),

                  CustomTextField(
                    keyboardType: TextInputType.emailAddress,
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
                    hintStyle: Colors.grey,
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
                  const Gap(20),
                  CustomButom(formKey: _formKey, text: 'Log In'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
