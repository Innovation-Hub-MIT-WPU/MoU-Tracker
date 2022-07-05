import 'package:flutter/material.dart';
import 'package:mou_tracker/screens/skeleton/notifications/notifications_list.dart';
import 'package:mou_tracker/screens/skeleton/notifications/notifications_tab.dart';
import 'package:mou_tracker/screens/skeleton/notifications/notifications_tab_view.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  NotificationsState createState() => NotificationsState();
}

class NotificationsState extends State<Notifications>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int index = 0;
  static late List ontracklist;
  static late List delayedlist;

  @override
  void initState() {
    ontracklist = getonTracksList();
    delayedlist = getdelayedList();

    // NotificationsData.unloadData();
    // delayedlist = NotificationsData.delayedMap;
    // ontracklist = NotificationsData.onTrackMap;
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        index = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(_tabController, index),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // tab bar view here
            Expanded(child: tabview(_tabController)),
          ],
        ),
      ),
    );
  }
}
