import 'package:flutter/material.dart';
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
        name: "Workshop",
        desc: "Lorem ipsum dolor sit amet, consectetur",
        status: true),
    Activity(
        name: "Placement",
        desc: "Lorem ipsum dolor sit amet, consectetur",
        status: false),
    Activity(
        name: "Workshop",
        desc: "Lorem ipsum dolor sit amet, consectetur",
        status: false)
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
              itemBuilder: (_, i) => _buildActivityTile(activities[i]),
              separatorBuilder: (_, i) => const SizedBox(height: 12), // Use dynamic height here
              itemCount: activities.length),
        )
      ],
    );
  }

  // Widget to build the List tile for a single activity
  Widget _buildActivityTile(Activity activity) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: kTileClr,
        ),
        child: ListTile(
          leading: activity.status == true
              ? const Icon(Icons
                  .check_box_outlined) // tick check box only on completed activities
              : const Icon(Icons.check_box_outline_blank),
          title: Text(activity.name),
          subtitle: Text(activity.desc),
          trailing: activity.status == true
              ? _buildTextButton("View")
              : null, // view button is only for completed activities
        ),
      ),
    );
  }

  // View button - To View all the details of an activity.
  // todo - Display full details of an activity.
  TextButton _buildTextButton(String buttonTxt) {
    return TextButton(
      onPressed: () {},
      child: Text(buttonTxt),
    );
  }
}
