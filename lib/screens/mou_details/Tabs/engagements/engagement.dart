import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/common_widgets/buttons.dart';
import 'package:MouTracker/models/mou.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/screens/Loading/loading_spinner.dart';
import 'package:MouTracker/screens/mou_details/Tabs/engagements/engagement_utlis/add_activity.dart';
import 'package:MouTracker/screens/mou_details/Tabs/engagements/engagement_utlis/bottom_sheet.dart';
import 'package:MouTracker/services/Firebase/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../models/activity.dart';

class EngagementTab extends StatelessWidget {
  final MOU mou;
  const EngagementTab({required this.mou, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: floatingButtonUI(screenWidth, screenHeight, context,
          title: "Add activity",
          nextPage: AddActivity(
            mouId: mou.mouId,
          )),
      body: FutureBuilder(
          future: DataBaseService().getEngagementList(mouId: mou.mouId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List activityList = snapshot.data as List;
              return EngagementList(mouId: mou.mouId, activities: activityList);
            } else if (snapshot.hasError) {
              return Center(
                  child: PText("No Engagement Data found",
                      style: GoogleFonts.figtree(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.04)));
            } else {
              return const Loading();
            }
          }),
    );
  }
}

class EngagementList extends StatelessWidget {
  final String mouId;
  final List activities;
  const EngagementList(
      {super.key, required this.mouId, required this.activities});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
                itemBuilder: (_, i) => _buildListTile(
                    context, mouId, activities[i], screenWidth, screenHeight),
                separatorBuilder: (_, i) => SizedBox(
                    height: screenHeight * 0.015), // Use dynamic height here
                itemCount: activities.length),
          )
        ],
      ),
    );
  }
}

// Widget to build the List tile for a single activity
Widget _buildListTile(BuildContext context, String mouId, Activity activity,
    double screenWidth, double screenHeight) {
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

      trailing: _buildViewButton(
          context, mouId, activity.name, screenWidth, screenHeight),

      // trailing: activity.status == true ?
      //      _buildViewButton(
      //         context, mouId, activity.name, screenWidth, screenHeight)
      //     : PText(
      //         "Ongoing",
      //         style: GoogleFonts.figtree(
      //             color: Colors.grey, fontSize: screenWidth * 0.036),
      //       ), // view button is only for completed activities
      //todo: Implement Activity Status via forms
    ),
  );
}

// View button - To View all the details of an activity.
// todo - Display full details of an activity.
TextButton _buildViewButton(BuildContext context, String mouId,
    String activityName, double screenWidth, double screenHeight) {
  return TextButton(
    onPressed: () {
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        useRootNavigator: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(screenWidth * 0.08),
              topRight: Radius.circular(screenWidth * 0.08)),
        ),
        context: context,
        builder: (context) => ActivityBottomSheet(
            mouId: mouId, activityName: activityName.toLowerCase()),
      );
    },
    child: PText("View",
        style: GoogleFonts.figtree(color: Colors.black, fontSize: 15)),
  );
}
