// ignore_for_file: prefer_const_constructors

/* Authentication page - Login & sign-up
* Custom Tab bar - Container + rounded border
* */

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
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.darkBlue,
      appBar: AppBar(
        centerTitle: true,
        title: Text("MOU TRACKER", style: TextStyle(fontSize: 36, fontWeight: FontWeight.w300, color: Colors.white,)),
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
            padding: const EdgeInsets.only(bottom: 20),
            child: footer(context),
          )
        ],
      ),
    );
  }
}
