import 'package:MouTracker/screens/home_page/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class MOUApproved extends StatelessWidget {
  const MOUApproved({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2D376E),
        // The title text which will be shown on the action bar
        title: const Text(""),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          icon: const Icon(Icons.home),
        ),
      ),
      body: Center(
        child: Image.asset('assets/images/approved.png'),
      ),
    );
  }
}
