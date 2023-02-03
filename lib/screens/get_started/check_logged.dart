import 'package:MouTracker/screens/get_started/splash_screen_animation_page.dart';
import 'package:MouTracker/screens/home_page/new_nav_bar.dart';
import 'package:MouTracker/services/Firebase/fireauth/fireauth.dart';
import 'package:flutter/material.dart';

class CheckAuth extends StatelessWidget {
  const CheckAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool showSignIn = FireAuth().getCurrentUser() == null ? true : false;
    return showSignIn ? const AnimatedSplashScreenPage() : const NewNavBar();
  }
}
