import 'package:MouTracker/models/personalized_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget floatingButtonUI(
    double screenWidth, double screenHeight, BuildContext context,
    {required String title, required Widget nextPage}) {
  return Container(
    alignment: Alignment.bottomRight,
    margin: EdgeInsets.only(bottom: screenWidth * 0.04),
    child: FloatingActionButton.extended(
      onPressed: () => Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => nextPage)),
      // Navigator.pushNamed(context, '/create_mou'),
      backgroundColor: const Color(0xff2D376E),
      label: PText(title,
          style: GoogleFonts.figtree(fontSize: screenWidth * 0.04)),
      icon: Icon(
        Icons.add,
        size: screenWidth * 0.06,
      ),
    ),
  );
}
