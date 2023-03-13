import 'package:MouTracker/screens/Loading/loading_spinner.dart';
import 'package:MouTracker/screens/mou_details/Tabs/engagements/engagement_utlis/activity_data.dart';
import 'package:MouTracker/screens/mou_details/Tabs/engagements/engagement_utlis/not_found.dart';
import 'package:MouTracker/services/Firebase/firestore/firestore.dart';
import 'package:flutter/material.dart';

class ActivityBottomSheet extends StatefulWidget {
  final String mouId;
  final String activityName;
  const ActivityBottomSheet({
    super.key,
    required this.mouId,
    required this.activityName,
  });

  @override
  State<ActivityBottomSheet> createState() => ActivityBottomSheetState();
}

class ActivityBottomSheetState extends State<ActivityBottomSheet> {
  @override
  Widget build(BuildContext context) {
    bool fetchSubCollection = widget.activityName == 'placements' ||
        widget.activityName == 'internships' ||
        widget.activityName == 'faculty internships';

    print(fetchSubCollection);
    return fetchSubCollection
        ? FutureBuilder<Object>(
            future: DataBaseService().getPlacementData(
                docId: widget.mouId, collId: widget.activityName, year: '2023'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                List placementactivity =
                    snapshot.data as List<Map<String, dynamic>>;
                return ActivityData(
                    activity: placementactivity[0],
                    activityName: widget.activityName);
              } else if (snapshot.hasError) {
                return NotFound(activityName: widget.activityName);
              } else {
                return const Loading();
              }
            })
        : FutureBuilder<Object>(
            future: DataBaseService().getEngagementData(
                docId: widget.mouId, collId: widget.activityName),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                Map<String, dynamic> activity =
                    snapshot.data as Map<String, dynamic>;
                return ActivityData(
                    activity: activity, activityName: widget.activityName);
              } else if (snapshot.hasError) {
                return NotFound(activityName: widget.activityName);
              } else {
                return const Loading();
              }
            });
  }
}
