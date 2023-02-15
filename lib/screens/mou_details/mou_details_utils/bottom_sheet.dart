import 'package:MouTracker/screens/Loading/loading_spinner.dart';
import 'package:MouTracker/screens/mou_details/mou_details_utils/activity_data/advisory.dart';
import 'package:MouTracker/screens/mou_details/mou_details_utils/activity_data/lab_and_excellence.dart';
import 'package:MouTracker/screens/mou_details/mou_details_utils/activity_data/not_found.dart';
import 'package:MouTracker/services/Firebase/firestore/firestore.dart';
import 'package:flutter/material.dart';

class ActivityBottomSheet extends StatefulWidget {
  final String mouId;
  final String activityName;
  const ActivityBottomSheet(
      {super.key, required this.mouId, required this.activityName});

  @override
  State<ActivityBottomSheet> createState() => ActivityBottomSheetState();
}

class ActivityBottomSheetState extends State<ActivityBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: DataBaseService().getEngagementData(
            docId: widget.mouId, collId: widget.activityName),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            if (widget.activityName == 'advisory boards') {
              return ActivityData1(
                activityName: widget.activityName,
                activityData: snapshot.data,
              );
            } else if (widget.activityName == 'lab equipment' ||
                widget.activityName == 'center of excellence') {
              return ActivityData2(
                  activityName: widget.activityName,
                  activityData: snapshot.data);
            } else {
              return NotFound(activityName: widget.activityName);
            }
          } else {
            return const Loading();
          }
        });
  }
}
