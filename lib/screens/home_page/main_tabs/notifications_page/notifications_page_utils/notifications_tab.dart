import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/globals.dart';
import 'package:flutter/material.dart';

import '../../../../../services/Firebase/fcm/notification_service.dart';

Widget tabs(TabController _tabController, int index, BuildContext context) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return Padding(
    padding:
        EdgeInsets.fromLTRB(width / 10, height / 60, width / 10, height / 40),
    child: Column(
      children: [
        Container(
          // height: 40,
          // width: 300,
          height: MediaQuery.of(context).size.height * 0.060,
          width: MediaQuery.of(context).size.width * 0.73,

          decoration: BoxDecoration(
            color: kBgClr1,
            borderRadius: BorderRadius.circular(
              15.0,
            ),
          ),
          child: TabBar(
            padding: const EdgeInsets.all(3),
            controller: _tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(
                12.0,
              ),
              color: index == 0 ? kTabBarGreen : kTabBarRed,
            ),
            labelColor: kBgClr1,
            labelStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            unselectedLabelColor: black.withOpacity(0.25),
            tabs: const [
              Tab(
                text: 'On Track',
              ),
              Tab(
                text: 'Delayed',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

PreferredSizeWidget appbar(
    TabController _tabController, int index, BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: COLOR_THEME['primary'],
    bottom: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.10),
        child: tabs(_tabController, index, context)),
    title: Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 30,
      ),
      child: Center(
        child: TextButton(
          child: Text(
            'Notifications',
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 15,
                color: kBgClr1,
                fontWeight: FontWeight.w400),
          ),
          onPressed: () {
            NotificationService().sendPushMessage(
                "You may have some new messages...", "Team Mou");
          },
        ),
      ),
    ),
  );
}
