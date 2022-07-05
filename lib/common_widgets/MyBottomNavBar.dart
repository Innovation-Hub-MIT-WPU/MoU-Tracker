import 'package:flutter/material.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({Key? key}) : super(key: key);

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      decoration: BoxDecoration(
        color: Color(0xff2D376E),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {},
            icon: Image.asset('assets/images/bnb1.png'),
            // icon: const Icon(
            //   Icons.check_box_outlined,
            //   color: Colors.white,
            //   size: 35,
            // ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {},
            icon: Image.asset('assets/images/bnb2.png'),
            // icon: const Icon(
            //   Icons.notifications_none_outlined,
            //   color: Colors.white,
            //   size: 35,
            // ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {},
            icon: Image.asset('assets/images/bnb3.png'),
            // icon: const Icon(
            //   Icons.list,
            //   color: Colors.white,
            //   size: 35,
            // ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {},
            icon: Image.asset('assets/images/bnb4.png'),
            // icon: const Icon(
            //   Icons.person_outline,
            //   color: Colors.white,
            //   size: 35,
            // ),
          ),
        ],
      ),
    );
  }
}
