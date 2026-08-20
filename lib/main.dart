import 'package:flutter/material.dart';
import 'package:foodie/core/routes/app_routers.dart';
import 'package:foodie/firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Foodie());
}

class Foodie extends StatelessWidget {
  const Foodie({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(fontFamily: GoogleFonts.pridi().fontFamily),
      debugShowCheckedModeBanner: false,
      title: 'Foodie',
      routerConfig: appRouter,
    );
  }
}
