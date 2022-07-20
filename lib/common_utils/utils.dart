import 'package:MouTracker/screens/main_tabs/profile_tab.dart';
import 'package:MouTracker/screens/main_tabs/stats_page/stats_page.dart';
import 'package:flutter/material.dart';

class MyRoute {
  static String profileRoute = "/profile";
  static String reportIssuesRoute = "/reportIssues";
  static String startPageRoute = "/startPage";
  static String statsPageRoute = "/statsPage";
}

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  int curr = 0;
  static const List<Widget> _widgetList = [
    Text("data"),
    Text("data"),
    StatsPage(),
    ProfileTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgetList.elementAt(curr),
        bottomNavigationBar: _bottomNavbar(curr));
  }

  void _onItemTapped(int index) {
    // print(index);
    setState(() => curr = index);
  }

  Widget _bottomNavbar(int curr) {
    return BottomNavigationBar(
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.black,
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
