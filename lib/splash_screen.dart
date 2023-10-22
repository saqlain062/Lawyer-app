

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:myfirst_flutter_project/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: AnimatedSplashScreen(
        duration: 1000,
        splash: Image.asset('images/lawyerIcon.png'),
        nextScreen: const LogIn(),
        )
    );
  }
}