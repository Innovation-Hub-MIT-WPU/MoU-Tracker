import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Padding & spacing values -> Modify Later Using media query
// Values are kept const for now since setState has to be called for changing variable values
// Change to variables later

// const double kDefaultHorizontal = 12.0;
// const double kDefaultVertical = 8.0;

// will be used to check if the file is downloaded or not, in info.dart
Map downloadChecker = {};

const double kFormHorizontal = 26.0;
const double kFormSpacing = 20.0;
// const double kTabBarHorizontal = 16.0;
// const double kTabBarVertical = 18.0;

const double kBorderWidth = 1.5;

//Colors

// Background colors
const Color kBgClr1 = Color(0xffffffff);
const Color kBgClr2 = Color(0xff2d376e);

// Tab bar
const Color kTabBarGreen = Color(0xff64c636);
const Color kTabBarRed = Color(0xFFCD364E);
const Color kTabBarYellow = Color(0xfff2c32c);
const Color kTabBarBlue = Color(0xff00a9ce);
const Color kCardRed = Color(0XFFCD364E);
const Color notiCardColor1 = Colors.lightBlueAccent;
const Color notiCardColor2 = Color.fromARGB(255, 137, 197, 247);
const Color notiShadow1 = Colors.grey;
const Color black = Colors.black;

// List Tile color
const Color kTileClr = Color(0xffedf9ff);

//TextStyles

// Used in Mou details - Info tab
TextStyle titleStyle(double size) {
  return GoogleFonts.figtree(fontSize: size, fontWeight: FontWeight.bold);
  // return const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
}

TextStyle normalStyle(double size) {
  return GoogleFonts.figtree(fontSize: size, fontWeight: FontWeight.w400);
  // return const TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
}

TextStyle subtitleStyle(double size) {
  return GoogleFonts.figtree(fontSize: size, fontWeight: FontWeight.w500);
  // return const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
}

//designations
var designations = [
  'Initiator',
  'SPOC',
  'Head',
  'Directors',
  'CEO',
  'Dean',
  'Vice Chancellor'
];

//App colors
class AppColors {
  static const Color darkBlue = Color(0xFF2D376E);
  static const Color buttonYellow = Color(0xFFF2C32C);
}

class MyRoute {
  static String profileRoute = "/profile";
  static String reportIssuesRoute = "/reportIssues";
  static String startPageRoute = "/startPage";
  static String statsPageRoute = "/statsPage";
}

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}
