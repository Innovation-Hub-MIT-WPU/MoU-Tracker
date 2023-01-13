import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/screens/home_page/main_tabs/notifications_page/notifications_tab_bar.dart';

import 'package:flutter/material.dart';

import '../../../../../classes/notifications_data.dart';

Widget tabview(TabController tabController, double height, double width,
    BuildContext context) {
  return TabBarView(
    controller: tabController,
    children: [
      // first tab bar view widget
      makeOnTrack(height, width, context),
      // second tab bar view widget
      makeDelayed(height, width, context),
    ],
  );
}

Widget makeOnTrack(double height, double width, BuildContext context) =>
    Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: NotificationsState.ontracklist.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              onTap: () {
                // Navigator.pushNamed(context, Details.routeName);
              },
              child: makeCard(NotificationsState.ontracklist[index], height,
                  width, context));
        },
      ),
    );

Widget makeDelayed(double height, double width, BuildContext context) =>
    Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: NotificationsState.delayedlist.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              onTap: () {
                // Navigator.pushNamed(context, Details.routeName);
              },
              child: makeCard(NotificationsState.delayedlist[index], height,
                  width, context));
        },
      ),
    );

// Container makeCard(onTrack onTrack, double height, double width) => Container(
Container makeCard(NotificationsData onTrack, double height, double width,
        BuildContext context) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin:
          EdgeInsets.symmetric(horizontal: width / 30, vertical: height / 80),
      child: Container(
        decoration: BoxDecoration(
          color: notiCardColor1.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: makeListTile(onTrack, height, width, context),
      ),
    );

// Column makeListTile(onTrack onTrack, double height, double width) =>

Widget makeListTile(NotificationsData onTrack, double height, double width,
        BuildContext context) =>
    Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
          backgroundColor: Colors.transparent,
          leading: Leading(height, width),
          title: Text(
            // onTrack.title,
            onTrack.title,
            style: const TextStyle(
              color: kBgClr2,
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(
                        left: width / 20,
                        right: width / 40,
                        bottom: height / 100),
                    child: Text(
                      // onTrack.description,
                      onTrack.body,
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
                        left: width / 20,
                        top: height / 120,
                        bottom: height / 80),
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

                            "${onTrack.on.day}-${onTrack.on.month}-${onTrack.on.year}",

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
            ),
          ]),
    );
// );

Widget Leading(
  double height,
  double width,
) {
  return Wrap(
    children: [
      Container(
        decoration: BoxDecoration(
            color: const Color(0XFFEFF3F6),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  offset: Offset(2, 2),
                  blurRadius: 2.0,
                  spreadRadius: 1.0),
            ]),
        child: Padding(
          padding: EdgeInsets.all(width / 45),
          child: const Icon(
            color: kBgClr2,
            Icons.notifications,
          ),
        ),
      )
    ],
  );
}
