// ignore_for_file: prefer_const_constructors

import 'package:MouTracker/globals.dart';
import 'package:flutter/material.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common_utils/utils.dart';
import 'auth_page_utlis/login_signup_widgets.dart';
import 'login_tab.dart';
import 'signup_tab.dart';

class LogInSignUpPage extends StatefulWidget {
  const LogInSignUpPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LogInSignUpPageState createState() => _LogInSignUpPageState();
}

class _LogInSignUpPageState extends State<LogInSignUpPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    //initializing tab controller
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: AppBar(
        centerTitle: true,
        title: PText(APP_TITLE,
            style: GoogleFonts.figtree(
              fontSize: screenWidth * 0.08,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            )),
        backgroundColor: AppColors.darkBlue,
        elevation: 10.0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04, vertical: screenHeight * 0.022),
            child: Container(
              height: screenHeight * 0.05,
              decoration: BoxDecoration(
                color: AppColors.darkBlue,
              ),
              child: TabBar(
                indicatorColor: AppColors.buttonYellow,
                controller: _tabController,
                labelColor: Colors.white,
                tabs: const [
                  Tab(
                    text: "SIGN IN",
                  ),
                  Tab(text: "SIGN UP"),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                LogIn(),
                SignUp(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: screenHeight * 0.01, top: screenHeight * 0.01),
            child: footer(context, screenWidth),
          )
        ],
      ),
    );
  }
}
