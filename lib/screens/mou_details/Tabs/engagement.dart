import 'package:flutter/material.dart';
import 'package:MouTracker/classes/personalized_text.dart';
import 'package:google_fonts/google_fonts.dart';
import '/common_utils/utils.dart';
import '/classes/activity.dart';

class EngagementTab extends StatefulWidget {
  const EngagementTab({Key? key}) : super(key: key);

  @override
  _EngagementTabState createState() => _EngagementTabState();
}

class _EngagementTabState extends State<EngagementTab> {
  // Receive Activity information here
  List<Activity> activities = [
    Activity(
      name: "Placement",
      desc: "Lorem ipsum dolor sit amet, consectetur",
      status: true,
    ),
    Activity(
      name: "Internship",
      desc: "Lorem ipsum dolor sit amet, consectetur",
      status: true,
    ),
    Activity(
      name: "Faculty Internships",
      desc: "Lorem ipsum dolor sit amet, consectetur",
      status: true,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
          top: screenHeight * 0.06,
          left: screenWidth * 0.04,
          right: screenWidth * 0.04),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (_, i) => _buildActivityTile(
                    activities[i], screenWidth, screenHeight),
                separatorBuilder: (_, i) => SizedBox(
                    height: screenHeight * 0.015), // Use dynamic height here
                itemCount: activities.length),
          )
        ],
      ),
    );
  }

  // Widget to build the List tile for a single activity
  Widget _buildActivityTile(
      Activity activity, double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03, vertical: screenHeight * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: kTileClr,
      ),
      child: ListTile(
        title: PText(activity.name,
            style: GoogleFonts.figtree(color: Colors.black, fontSize: 18)),
        subtitle: PText(activity.desc,
            style: GoogleFonts.figtree(color: Colors.grey, fontSize: 14)),
        trailing: activity.status == true
            ? _buildTextButton("View")
            : null, // view button is only for completed activities
      ),
    );
  }

  // View button - To View all the details of an activity.
  // todo - Display full details of an activity.
  TextButton _buildTextButton(String buttonTxt) {
    return TextButton(
      onPressed: () {},
      child: PText(buttonTxt,
          style: GoogleFonts.figtree(color: Colors.black, fontSize: 15)),
    );
  }
}
