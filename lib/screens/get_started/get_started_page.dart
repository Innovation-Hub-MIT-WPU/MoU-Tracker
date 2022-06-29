// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:MouTracker/screens/login_signup/login_signup_page.dart';
import 'package:flutter/material.dart';

import '../../common_utils/utils.dart';
import '../../common_widgets/login_signup_widgets.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            //white part
            Container(
              height: 585,
              child: Center(
                child: Text("MOU Tracker", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 36,))
              )
            ),

            //blue part
            Container(
              width: double.infinity,
              height: 227,
              color: AppColors.darkBlue,
              child: Column(
                children: [
                  SizedBox(height: 40,),
                  //'Welcome to MOU' Tracker text
                  Text("Welcome to MOU Tracker !", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white,)),
                  SizedBox(height: 30,),
                  //'Get Started' button
                  AppButton("Get started", LogInSignUpPage(), context, fontSize: 24, buttonWidth: 315, buttonHeight: 58),
                  SizedBox(height: 40,),
                  //'Privacy policy . TOC . Content Policy'
                  footer(context)
                ]
              ),
            ),
          ],
        ),
      )
    );
  }
}