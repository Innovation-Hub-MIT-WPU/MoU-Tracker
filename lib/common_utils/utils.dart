import 'package:flutter/material.dart';





// Padding & spacing values -> Modify Later Using media query
// Values are kept const for now since setState has to be called for changing variable values
// Change to variables later

const double kDefaultHorizontal = 12.0;
const double kDefaultVertical = 8.0;

const double kFormHorizontal = 26.0;
const double kFormSpacing = 20.0;
const double kTabBarHorizontal = 16.0;
const double kTabBarVertical = 18.0;

const double kBorderWidth = 1.5;

//Colors

// Background colors
const Color kBgClr1 = Color(0xffffffff);
const Color kBgClr2 = Color(0xff2d376e);

// Tab bar
const Color kTabBarGreen = Color(0xff64c636);
const Color kTabBarYellow = Color(0xfff2c32c);
const Color kTabBarBlue = Color(0xff00a9ce);

// List Tile color
const Color kTileClr = Color(0xffedf9ff);

//misc
List<String> months = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "June",
  "July",
  "Aug",
  "Sept",
  "Oct",
  "Nov",
  "Dec"
];
