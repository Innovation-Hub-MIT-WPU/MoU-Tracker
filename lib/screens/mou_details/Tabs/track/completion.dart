import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/screens/home_page/new_nav_bar.dart';
import 'package:flutter/material.dart';

class MOUApproved extends StatelessWidget {
  const MOUApproved({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2D376E),
        // The title text which will be shown on the action bar
        title: const PText(""),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (context) => const NewHomePage()),
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
