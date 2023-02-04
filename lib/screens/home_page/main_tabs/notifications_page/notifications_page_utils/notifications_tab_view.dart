import 'package:MouTracker/models/mou.dart';
import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/screens/home_page/main_tabs/notifications_page/notifications_tab_bar.dart';
import 'package:MouTracker/screens/mou_details/mou_details_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../models/notifications_data.dart';

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
          return makeCard(
              NotificationsState.ontracklist[index], height, width, context);
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
        borderRadius: BorderRadius.circular(width * 0.05),
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
    BuildContext context) {
  String title = onTrack.title;
  String docName = onTrack.docName.toUpperCase();

  String state = title.contains("Approved")
      ? "Approved"
      : title.contains("Rejected")
          ? "Rejected"
          : "Created";
  String by = onTrack.by;
  String on = "${onTrack.on.day}-${onTrack.on.month}-${onTrack.on.year}";
  return Theme(
    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
    child: ExpansionTile(
        backgroundColor: Colors.transparent,
        leading: Leading(height, width),
        title: PText(
          title,
          style: GoogleFonts.figtree(
            color: kBgClr2,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        subtitle: PText(
          docName,
          style: GoogleFonts.figtree(
              color: kBgClr2,
              fontWeight: FontWeight.w500,
              fontSize: 13,
              fontStyle: FontStyle.italic),
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
                  child: PText(
                    " Company  :  $docName \n $state By :  $by \n $state On :  $on",
                    style: GoogleFonts.figtree(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: kBgClr2.withOpacity(0.7)),
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
                child: InkWell(
                  onTap: () async {
                    var query = await FirebaseFirestore.instance
                        .collection('mou')
                        .doc(onTrack.mouId.trim())
                        .get();

                    final data = query.data();
                    DateTime date = data!['due-date'].toDate();
                    String dueDate = "${date.year}-${date.month}-${date.day}";

                    MOU mou = MOU(
                        mouId: onTrack.mouId.trim(),
                        docName: data['doc-name'],
                        authName: data['auth-name'],
                        companyName: data['company-name'],
                        companyWebsite: data[0]['company-website'],
                        description: data['description'],
                        isApproved: data['status'],
                        appLvl: data['approval-lvl'],
                        dueDate: dueDate);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Details(
                                  mou: mou,
                                )));
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: height / 120, bottom: height / 80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: width / 60),
                          child: PText(
                            "Go To Track",
                            style: GoogleFonts.figtree(
                              color: black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.ads_click_sharp,
                          size: 19,
                          color: black,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
  );
}
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
