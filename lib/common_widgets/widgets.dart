import 'package:MouTracker/globals.dart';
import 'package:flutter/material.dart';

AppBar appBar(String title, BuildContext context) {
  return AppBar(
    backgroundColor: COLOR_THEME['primary'],
    bottom: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.04),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontFamily:
                  Theme.of(context).textTheme.headlineMedium!.fontFamily,
              fontSize: 28,
            ),
          ),
        )),
    centerTitle: true,
  );
}
