// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:MouTracker/globals.dart';
import 'package:MouTracker/screens/login_signup/login_signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common_utils/utils.dart';
import '../../common_widgets/login_signup_widgets.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

//Text("MOU Tracker", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 36,)),

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
              padding: EdgeInsets.only(top: screenHeight*0.36),
              child: Center(
                  child: Text(APP_TITLE,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 36,
                      )))),

          //APP_LOGO aligned to screen's center
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: Image.asset(
              'assets/images/app_icon.png',
              height: 100,
              width: 100,
            )),
          ),

          //blue part
          Align(
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight*0.72),
              child: Container(
                width: double.infinity,
                height: 227,
                color: AppColors.darkBlue,
                child: Column(children: [
                  SizedBox(
                    height: 40,
                  ),
                  //'Welcome to MOU' Tracker text
                  Text("Welcome to MOU Tracker !",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  //'Get Started' button
                  appButton("Get started", LogInSignUpPage(), context),
                  SizedBox(
                    height: 50,
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
