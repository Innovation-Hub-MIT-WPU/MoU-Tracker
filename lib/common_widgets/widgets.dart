import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/globals.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar appBar(String title, BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  return AppBar(
    toolbarHeight: screenWidth * 0.24,
    shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(screenWidth * 0.05),
          ),
        ),
    backgroundColor: COLOR_THEME['primary'],
    bottom: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.04),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, screenWidth * 0.15),
          child: PText(
            title,
            style: GoogleFonts.figtree(
              color: Colors.white,
              fontSize: screenWidth * 0.05,
            ),
          ),
        )),
    centerTitle: true,
  );
}
