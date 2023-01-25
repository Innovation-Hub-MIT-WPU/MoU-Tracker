import 'package:MouTracker/globals.dart';
import 'package:MouTracker/screens/home_page/main_tabs/approvals_page/approvals_page.dart';
import 'package:MouTracker/screens/home_page/main_tabs/profile_page/profile_tab.dart';
import 'package:MouTracker/screens/home_page/main_tabs/stats_page/stats_page.dart';
import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import '../../services/Firebase/fcm/notification_service.dart';
import 'main_tabs/notifications_page/notifications_tab_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

// Todo - bottomNavigationBar needs better design
class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int curr = 0;
  late TabController _tabController;
  int _bottomNavIndex = 0;

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

  List<IconData> navBarIconData = [
    Icons.check_box_outlined,
    Icons.notifications_outlined,
    Icons.picture_as_pdf_outlined,
    Icons.person_outline,
  ];
  @override
  void initState() {
    super.initState();
    NotificationService().requestPermission();
    NotificationService().getToken();
    NotificationService().checkNotifications(context);
    NotificationService().onOpenBackNotification(context);

    _tabController = TabController(
      animationDuration: const Duration(seconds: 0),
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    _tabController.addListener(
      () {
        if (_tabController.previousIndex != _tabController.index) {
          print(_tabController.index);
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: _widgetList),
      bottomNavigationBar: CustomNavigationBar(
        backgroundColor: COLOR_THEME['primary']!,
        currentIndex: _bottomNavIndex,
        items: [
          CustomNavigationBarItem(
            icon: Icon(
              navBarIconData[0],
              color: COLOR_THEME['secondary'],
            ),
            selectedIcon: Icon(
              navBarIconData[0],
              color: Colors.white,
            ),
            title: Text(
              'Approvals',
              style: TextStyle(
                color: COLOR_THEME['secondary'],
                fontSize: screenWidth * 0.03,
              ),
            ),
            selectedTitle: Text(
              'Approvals',
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.03,
              ),
            ),
          ),
          CustomNavigationBarItem(
            icon: Icon(
              navBarIconData[1],
              color: COLOR_THEME['secondary'],
            ),
            selectedIcon: Icon(
              navBarIconData[1],
              color: Colors.white,
            ),
            title: Text(
              'Notifications',
              style: TextStyle(
                color: COLOR_THEME['secondary'],
                fontSize: screenWidth * 0.03,
              ),
            ),
            selectedTitle: Text(
              'Notifications',
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.03,
              ),
            ),
          ),
          CustomNavigationBarItem(
            icon: Icon(
              navBarIconData[2],
              color: COLOR_THEME['secondary'],
            ),
            selectedIcon: Icon(
              navBarIconData[2],
              color: Colors.white,
            ),
            title: Text(
              'Stats',
              style: TextStyle(
                color: COLOR_THEME['secondary'],
                fontSize: screenWidth * 0.03,
              ),
            ),
            selectedTitle: Text(
              'Stats',
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.03,
              ),
            ),
          ),
          CustomNavigationBarItem(
            icon: Icon(
              navBarIconData[3],
              color: COLOR_THEME['secondary'],
            ),
            selectedIcon: Icon(
              navBarIconData[3],
              color: Colors.white,
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                color: COLOR_THEME['secondary'],
                fontSize: screenWidth * 0.03,
              ),
            ),
            selectedTitle: Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.03,
              ),
            ),
          ),
        ],
        onTap: (index) => setState(
          () {
            _bottomNavIndex = index;
            _tabController.index = index;
          },
        ),
      ),
    );
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
