import 'package:MouTracker/globals.dart';
import 'package:MouTracker/services/Firebase/fcm/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'main_tabs/approvals_page/approvals_page.dart';
import 'main_tabs/notifications_page/notifications_tab_bar.dart';
import 'main_tabs/profile_page/profile_tab.dart';
import 'main_tabs/stats_page/stats_page.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({Key? key}) : super(key: key);

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _widgetList = [];

  @override
  void initState() {
    _widgetList = [
      const ApprovalsPage(),
      const Notifications(),
      const StatsPage(),
      ProfileTab(
        controller: _controller,
      ),
    ];
    NotificationService().requestPermission();
    NotificationService().addToken();
    NotificationService().checkNotifications(context);
    NotificationService().onOpenBackNotification(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return PersistentTabView(
      context,
      screens: _widgetList,
      navBarHeight: screenHeight * 0.07,
      items: [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.check_box_outlined, size: screenWidth * 0.07),
          inactiveIcon:
              Icon(Icons.check_box_outlined, size: screenWidth * 0.07),
          title: 'Approvals',
          contentPadding: 1,
          textStyle: GoogleFonts.figtree(
            fontSize: screenWidth * 0.025,
          ),
          // iconSize: screenWidth * 0.05,
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: COLOR_THEME['secondary']!,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.notifications_outlined, size: screenWidth * 0.07),
          inactiveIcon:
              Icon(Icons.notifications_outlined, size: screenWidth * 0.07),
          title: 'Notifications',
          contentPadding: 1,
          textStyle: GoogleFonts.figtree(
            fontSize: screenWidth * 0.025,
          ),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: COLOR_THEME['secondary']!,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.picture_as_pdf_outlined, size: screenWidth * 0.07),
          inactiveIcon:
              Icon(Icons.picture_as_pdf_outlined, size: screenWidth * 0.07),
          title: 'Stats',
          contentPadding: 1,
          textStyle: GoogleFonts.figtree(
            fontSize: screenWidth * 0.025,
          ),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: COLOR_THEME['secondary']!,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.person_outline, size: screenWidth * 0.07),
          inactiveIcon: Icon(Icons.person_outline, size: screenWidth * 0.07),
          title: 'Profile',
          contentPadding: 1,
          textStyle: GoogleFonts.figtree(
            fontSize: screenWidth * 0.025,
          ),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: COLOR_THEME['secondary']!,
        ),
      ],
      confineInSafeArea: true,
      backgroundColor: COLOR_THEME['primary']!,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(screenWidth * 0.05),
          topRight: Radius.circular(screenWidth * 0.05),
        ),
        colorBehindNavBar: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInBack,
      ),
      screenTransitionAnimation: 
      const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style8,
    );
  }
}
