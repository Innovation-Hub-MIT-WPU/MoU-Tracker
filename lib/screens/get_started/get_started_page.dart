// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/globals.dart';
import 'package:MouTracker/screens/login_signup/login_signup_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/common_utils/utils.dart';
import '../login_signup/auth_page_utlis/login_signup_widgets.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          //APP_ICON header
          Container(
              padding: EdgeInsets.only(top: screenHeight * 0.36),
              child: Center(
                  child: PText(APP_TITLE,
                      style: GoogleFonts.figtree(
                        fontWeight: FontWeight.w600,
                        fontSize: screenWidth * 0.08,
                      )))),

          //APP_LOGO aligned to screen's center
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: Image.asset(
              'assets/images/app_icon.png',
              height: MediaQuery.of(context).size.width * 0.3,
            )),
          ),

          //blue part
          Align(
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.72),
              child: Container(
                width: double.infinity,
                height: screenHeight * 0.5,
                color: AppColors.darkBlue,
                child: Column(children: [
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  //'Welcome to MOU' Tracker text
                  PText("Welcome to MOU Tracker !",
                      style: GoogleFonts.figtree(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      )),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  //'Get Started' button
                  appButton("Get started", LogInSignUpPage(), context),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  //'Privacy policy . TOC . Content Policy'
                  footer(context, screenWidth)
                ]),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
