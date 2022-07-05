import '/common_utils/utils.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBarState createState() => _BottomNavBarState();
}

// Todo - bottomNavigationBar needs better design
class _BottomNavBarState extends State<BottomNavBar> {
  int curr = 0;
  static const List<Widget> _widgetList = [
    // Status(),
    // Notifications(),
    // Track(),
    // Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgetList.elementAt(curr),
        bottomNavigationBar: _bottomNavbar(curr));
  }

  void _onItemTapped(int index) {
    setState(() => curr = index);
  }

  Widget _bottomNavbar(int curr) {
    return BottomNavigationBar(
      type: BottomNavigationBarType
          .fixed, // the shifting animation overrides any color we put on the nav bar, so removed the animation.
      backgroundColor: kBgClr2,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.white,
      iconSize: 30,
      items: const [
        BottomNavigationBarItem(
          label: "",
          icon: ImageIcon(AssetImage("assets/checkBox.png")),
        ),
        BottomNavigationBarItem(
          label: "",
          icon: Icon(Icons.notifications),
        ),
        BottomNavigationBarItem(
          label: "",
          icon: ImageIcon(AssetImage("assets/notepad.png")),
        ),
        BottomNavigationBarItem(
          label: "",
          icon: Icon(Icons.person_outlined),
        ),
      ],
      currentIndex: curr,
      onTap: _onItemTapped,
    );
  }
}
