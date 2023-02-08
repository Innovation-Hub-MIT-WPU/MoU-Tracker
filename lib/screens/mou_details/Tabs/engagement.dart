import 'package:MouTracker/common_widgets/buttons.dart';
import 'package:MouTracker/models/mou.dart';
import 'package:MouTracker/screens/Loading/loading_spinner.dart';
import 'package:MouTracker/screens/mou_details/mou_details_utils/add_activity.dart';
import 'package:MouTracker/screens/mou_details/mou_details_utils/bottom_sheet.dart';
import 'package:MouTracker/services/Firebase/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:google_fonts/google_fonts.dart';
import '/common_utils/utils.dart';
import '../../../models/activity.dart';

class EngagementTab extends StatefulWidget {
  final MOU mou;
  const EngagementTab({required this.mou, Key? key}) : super(key: key);

  @override
  _EngagementTabState createState() => _EngagementTabState();
}

class _EngagementTabState extends State<EngagementTab> {
  int isEngagementVisible = -1;
  // Receive Engagement information here
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
    Activity(
      name: "Advisory boards",
      desc: "Lorem ipsum dolor sit amet, consectetur",
      status: false,
    ),
    Activity(
      name: "Curriculum design",
      desc: "Lorem ipsum dolor sit amet, consectetur",
      status: false,
    ),
    Activity(
      name: "Lab equipment",
      desc: "Lorem ipsum dolor sit amet, consectetur",
      status: false,
    ),
    Activity(
      name: "Center of Execellence",
      desc: "Lorem ipsum dolor sit amet, consectetur",
      status: false,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return FutureBuilder(
        // stream: null,
        future: DataBaseService().getmouData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                body: _buildEngagementList(screenHeight, screenWidth),
                floatingActionButton: floatingButtonUI(
                    screenWidth, screenHeight, context,
                    title: "Add activity", nextPage: const AddActivity()));
          } else {
            return const Loading();
          }
        });
  }

  Padding _buildEngagementList(double screenHeight, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(
        top: screenHeight * 0.04,
        left: screenWidth * 0.04,
        right: screenWidth * 0.04,
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (_, i) =>
                    _buildListTile(i, activities[i], screenWidth, screenHeight),
                separatorBuilder: (_, i) => SizedBox(
                    height: screenHeight * 0.015), // Use dynamic height here
                itemCount: activities.length),
          )
        ],
      ),
    );
  }

  // Widget to build the List tile for a single activity
  Widget _buildListTile(
      int i, Activity activity, double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03, vertical: screenHeight * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: kTileClr,
      ),
      child: ListTile(
        title: PText(
          activity.name,
          style: GoogleFonts.figtree(
              color: Colors.black,
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.bold),
        ),
        subtitle: PText(activity.desc,
            style: GoogleFonts.figtree(
                color: Colors.grey, fontSize: screenWidth * 0.036)),
        trailing: activity.status == true
            ? _buildViewButton("View", screenWidth, screenHeight)
            : PText(
                "Ongoing",
                style: GoogleFonts.figtree(
                    color: Colors.grey, fontSize: screenWidth * 0.036),
              ), // view button is only for completed activities
      ),
    );
  }

  // View button - To View all the details of an activity.
  // todo - Display full details of an activity.
  TextButton _buildViewButton(
      String buttonTxt, double screenWidth, double screenHeight) {
    return TextButton(
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: Colors.white,
          useRootNavigator: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(screenWidth * 0.08),
                topRight: Radius.circular(screenWidth * 0.08)),
          ),
          context: context,
          builder: (context) => const ActivityBottomSheet(),
        );
      },
      child: PText(buttonTxt,
          style: GoogleFonts.figtree(color: Colors.black, fontSize: 15)),
    );
  }
}
