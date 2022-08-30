import 'package:MouTracker/screens/home_page/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class MOUApproved extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2D376E),
        // The title text which will be shown on the action bar
        title: Text(""),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: Icon(Icons.home),
        ),
      ),
      body: Center(
        child: Image.asset('assets/images/approved.png'), // <-- SEE HERE
      ),
    );
  }
}
