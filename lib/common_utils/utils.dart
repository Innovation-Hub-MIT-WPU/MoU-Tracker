import 'package:flutter/material.dart';

// Padding & spacing values -> Modify Later Using media query
// Values are kept const for now since setState has to be called for changing variable values
// Change to variables later

// const double kDefaultHorizontal = 12.0;
// const double kDefaultVertical = 8.0;

// will be used to check if the file is downloaded or not, in info.dart
Map downloadChecker =   {

};

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
TextStyle titleStyle() {
  return const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
}

TextStyle normalStyle() {
  return const TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
}

TextStyle subtitleStyle() {
  return const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
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

final List DocName = [
  'MoU 1',
  'MoU 2',
  'MoU 3',
  'MoU 4',
  'MoU 5',
  'MoU 6',
  'MoU 7',
  'MoU 8'
];

final List CompanyName = [
  'Company 1',
  'Company 2',
  'Company 3',
  'Company 4',
  'Company 5',
  'Company 6',
  'Company 7',
  'Company 8'
];
final List AuthName = [
  'Bob',
  'Adam',
  'Greg',
  'Chris',
  'Max',
  'Jordan',
  'Spencer',
  'Mark'
];
final List Amount = [
  10000,
  100000,
  1000000,
  109999,
  10000,
  100000,
  1000000,
  109999
];
final List Description = [
  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam posuere aliquam ex a auctor.. ',
  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam posuere aliquam ex a auctor.. ',
  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam posuere '
      'aliquam ex a auctor.. ',
  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam posuere '
      'aliquam ex a auctor.. ',
  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam posuere aliquam ex a auctor.. ',
  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam posuere aliquam ex a auctor.. ',
  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam posuere '
      'aliquam ex a auctor.. ',
  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam posuere '
      'aliquam ex a auctor.. ',
];
final List DueDate = [
  '2 Feb, 2022',
  '2 Mar, 2022',
  '2 Apr, 2022',
  '2 May, 2022',
  '2 Jun, 2022',
  '2 Jul, 2022',
  '2 Aug, 2022',
  '2 Sep, 2022',
];
bool isApproved = true;

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
