import 'package:MouTracker/screens/home_page/main_tabs/notifications_page/notifications_tab_bar.dart';
import 'package:flutter/material.dart';
import 'notifications_list.dart';

Widget tabview(TabController tabController) {
  return TabBarView(
    controller: tabController,
    children: [
      // first tab bar view widget
      makeOnTrack(),
      // second tab bar view widget
      makeDelayed(),
    ],
  );
}

Widget makeOnTrack() => Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: NotificationsState.ontracklist.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(NotificationsState.ontracklist[index]);
        },
      ),
    );

Widget makeDelayed() => Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: NotificationsState.delayedlist.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(NotificationsState.delayedlist[index]);
        },
      ),
    );

Container makeCard(onTrack onTrack) => Container(
// Container makeCard(Map onTrack) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3)),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: makeListTile(onTrack),
      ),
    );

Column makeListTile(onTrack onTrack) =>

// Column makeListTile(Map onTrack) => Column(

    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Text(
            onTrack.title,
            // onTrack["MOU NAME"],
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          ),
        ),
        Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Text(
              onTrack.description,
              // onTrack["Description"],
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.6)),
            )),
        Container(
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 137, 197, 247),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 10.0, top: 10.0, bottom: 10.0),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  onTrack.date.toString(),
                  // (onTrack["Due Date"] as Timestamp).toDate().toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
// );
