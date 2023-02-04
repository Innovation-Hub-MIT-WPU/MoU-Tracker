import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/globals.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar appBar(String title, BuildContext context) {
  return AppBar(
    backgroundColor: COLOR_THEME['primary'],
    bottom: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.04),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: PText(
            title,
            style: GoogleFonts.figtree(
              color: Colors.white,
              fontSize: 28,
            ),
          ),
        )),
    centerTitle: true,
  );
}
