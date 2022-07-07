// ignore_for_file: prefer_const_constructors

import 'package:MouTracker/globals.dart';
import 'package:flutter/material.dart';

import '../../common_utils/utils.dart';
import '../../common_widgets/login_signup_widgets.dart';
import 'login_tab.dart';
import 'signup_tab.dart';

class LogInSignUpPage extends StatefulWidget {
  const LogInSignUpPage({Key? key}) : super(key: key);

  @override
  _LogInSignUpPageState createState() => _LogInSignUpPageState();
}

class _LogInSignUpPageState extends State<LogInSignUpPage> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    //initializing tab controller
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: AppBar(
        centerTitle: true,
        title: Text(APP_TITLE, style: TextStyle(fontSize: 36, fontWeight: FontWeight.w300, color: Colors.white,)),
        backgroundColor: AppColors.darkBlue,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kTabBarHorizontal,vertical: kTabBarVertical),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: AppColors.darkBlue,
              ),
              child: TabBar(
                indicatorColor: AppColors.buttonYellow,
                controller: _tabController,
                labelColor: Colors.white,
                tabs: const [
                  Tab(text: "SIGN IN",),
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
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: footer(context),
          )
        ],
      ),
    );
  }
}
