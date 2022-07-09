import 'package:MouTracker/screens/home_page/main_tabs/approvals_page/approvals_page.dart';
import 'package:MouTracker/screens/home_page/main_tabs/profile_page/profile_tab.dart';
import 'package:MouTracker/screens/home_page/main_tabs/stats_page/stats_page.dart';
import 'package:flutter/material.dart';

import 'main_tabs/notifications_page/notifications_tab_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

// Todo - bottomNavigationBar needs better design
class _HomePageState extends State<HomePage> {
  int curr = 0;

  static const List<Widget> _widgetList = [
    ApprovalsPage(),
    Notifications(),
    StatsPage(),
    ProfileTab(),
  ];
  List<String> navBarItems = [
    'assets/images/bnb1.png',
    'assets/images/bnb2.png',
    'assets/images/bnb3.png',
    'assets/images/bnb4.png'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetList.elementAt(curr),
      bottomNavigationBar: _bottomNavbar(curr),
    );
  }

  void _onItemTapped(int index) {
    setState(() => curr = index);
  }

  Widget _bottomNavbar(int index) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      decoration: const BoxDecoration(
        color: Color(0xff2D376E),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navBarIcon(0),
          _navBarIcon(1),
          _navBarIcon(2),
          _navBarIcon(3),
        ],
      ),
    );
  }

  IconButton _navBarIcon(int index) {
    return IconButton(
      enableFeedback: false,
      onPressed: () {
        setState(() => curr = index);
      },
      icon: Image.asset(navBarItems[index]),
    );
  }
}
