import 'dart:async';

import 'package:MouTracker/screens/home_page/main_tabs/notifications_page/notifications_tab_bar.dart';
import 'package:flutter/material.dart';
import 'notifications_list.dart';

Widget tabview(TabController tabController, double height, double width) {
  return TabBarView(
    controller: tabController,
    children: [
      // first tab bar view widget
      makeOnTrack(height, width),
      // second tab bar view widget
      makeDelayed(height, width),
    ],
  );
}

Widget makeOnTrack(double height, double width) => Container(
  child: ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: NotificationsState.ontracklist.length,
    itemBuilder: (BuildContext context, int index) {
      return makeCard(NotificationsState.ontracklist[index], height, width);
    },
  ),
);

Widget makeDelayed(double height, double width) => Container(
  child: ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: NotificationsState.delayedlist.length,
    itemBuilder: (BuildContext context, int index) {
      return makeCard(NotificationsState.delayedlist[index], height, width);
    },
  ),
);

Container makeCard(onTrack onTrack, double height, double width) => Container(
// Container makeCard(Map onTrack,double height ,double width) => Container(
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
  margin:
  EdgeInsets.symmetric(horizontal: width / 30, vertical: height / 60),
  child: Container(
    decoration: BoxDecoration(
      color: Colors.lightBlueAccent.withOpacity(0.2),
      borderRadius: BorderRadius.circular(15),
    ),
    child: makeListTile(onTrack, height, width),
  ),
);

Column makeListTile(onTrack onTrack, double height, double width) =>

// Column makeListTile(Map onTrack,double height ,double width) => Column(

Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width / 20, vertical: height / 60),
      child: Text(
        onTrack.title,
        // onTrack["MOU NAME"],
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
      ),
    ),
    Padding(
        padding: EdgeInsets.only(
            left: width / 20, right: width / 40, bottom: height / 100),
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
        padding: EdgeInsets.only(
            left: width / 20, top: height / 120, bottom: height / 80),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              size: 18,
              color: Colors.black,
            ),
            Padding(
              padding: EdgeInsets.only(left: width / 40),
              child: Text(
                onTrack.date.toString(),
                // (onTrack["Due Date"] as Timestamp).toDate().toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ],
);
// );

Widget searchBox(double height, double width) {
  return TextField(
    // onChanged: (value) => _runFilter(value),
    decoration: InputDecoration(
      contentPadding:
      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
      hintText: "Search",
      suffixIcon: const Icon(Icons.search),
      // prefix: Icon(Icons.search),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(),
      ),
    ),
  );
}
