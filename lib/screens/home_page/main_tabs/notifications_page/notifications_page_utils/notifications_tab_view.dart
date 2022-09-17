import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/screens/home_page/main_tabs/notifications_page/notifications_tab_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
          return InkWell(
              onTap: () {
                // Navigator.pushNamed(context, Details.routeName);
              },
              child: makeCard(
                  NotificationsState.ontracklist[index], height, width));
        },
      ),
    );

Widget makeDelayed(double height, double width) => Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: NotificationsState.delayedlist.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              onTap: () {
                // Navigator.pushNamed(context, Details.routeName);
              },
              child: makeCard(
                  NotificationsState.delayedlist[index], height, width));
        },
      ),
    );

// Container makeCard(onTrack onTrack, double height, double width) => Container(
Container makeCard(Map onTrack, double height, double width) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3)),
        ],
      ),
      margin:
          EdgeInsets.symmetric(horizontal: width / 30, vertical: height / 60),
      child: Container(
        decoration: BoxDecoration(
          color: notiCardColor1.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: makeListTile(onTrack, height, width),
      ),
    );

// Column makeListTile(onTrack onTrack, double height, double width) =>

Column makeListTile(Map onTrack, double height, double width) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width / 20, vertical: height / 60),
          child: Text(
            // onTrack.title,
            onTrack["doc-name"],
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(
                left: width / 20, right: width / 40, bottom: height / 100),
            child: Text(
              // onTrack.description,
              onTrack["description"],
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: black.withOpacity(0.6)),
            )),
        Container(
          decoration: const BoxDecoration(
              color: notiCardColor2,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: notiShadow1,
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
                  color: black,
                ),
                Padding(
                  padding: EdgeInsets.only(left: width / 40),
                  child: Text(
                    // onTrack.date.toString(),
                    (onTrack["due-date"] as Timestamp).toDate().toString(),
                    style: const TextStyle(
                      color: black,
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
