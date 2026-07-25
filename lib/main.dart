import 'package:flutter/material.dart';
import 'package:foodie/core/routes/app_routers.dart';
import 'package:foodie/features/auth/views/log_in_view.dart';
import 'package:foodie/features/auth/views/sign_up_view.dart';
import 'package:foodie/splash_view.dart';

void main() {
  runApp(const Foodie());
}

class Foodie extends StatelessWidget {
  const Foodie({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Foodie',
      routerConfig: appRouter,
    );
  }
}
