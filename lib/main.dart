import 'package:flutter/material.dart';
import 'package:foodie/core/routes/app_routers.dart';

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
