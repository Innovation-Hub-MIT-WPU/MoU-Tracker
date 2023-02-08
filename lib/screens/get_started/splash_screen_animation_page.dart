// ignore_for_file: prefer_const_constructors

import 'package:MouTracker/screens/get_started/get_started_page.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

class AnimatedSplashScreenPage extends StatefulWidget {
  const AnimatedSplashScreenPage({Key? key}) : super(key: key);

  @override
  State<AnimatedSplashScreenPage> createState() =>
      _AnimatedSplashScreenPageState();
}

class _AnimatedSplashScreenPageState extends State<AnimatedSplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset('assets/images/app_icon.png'),
      nextScreen: GetStartedPage(),
      splashTransition: SplashTransition.scaleTransition,
      splashIconSize: MediaQuery.of(context).size.width * 0.3,
    );
  }
}
