import 'package:flutter/material.dart';

class MyRoute {
  static String profileRoute = "/profile";
  static String reportIssuesRoute = "/reportIssues";
}

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}
