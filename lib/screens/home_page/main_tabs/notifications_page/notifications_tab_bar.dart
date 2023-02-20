import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/models/mou.dart';
import 'package:MouTracker/screens/mou_details/mou_details_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:MouTracker/models/personalized_text.dart';
import '../../../../models/notifications_data.dart';
import '../../../../services/Firebase/firestore/firestore.dart';
import 'notifications_page_utils/notifications_tab.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  NotificationsState createState() => NotificationsState();
}

class NotificationsState extends State<Notifications>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController searchQueryController = TextEditingController();
  int index = 0;
  static List<NotificationsData> ontracklist = [];
  static List<NotificationsData> delayedlist = [];
  static late List<NotificationsData> allData;

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
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
    searchQueryController.dispose();
  }

  Future<void> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      DataBaseService().getNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: appbar(_tabController, index, context, screenHeight),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: kBgClr2,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(screenWidth * 0.08),
                  bottomRight: Radius.circular(screenWidth * 0.08),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(screenWidth / 50),
                child: searchBox(screenHeight, screenWidth),
              ),
            ),
            FutureBuilder(
                future: DataBaseService().getNotifications(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    ontracklist =
                        onTrackSort(snapshot.data as List<NotificationsData>);
                    delayedlist =
                        delayedSort(snapshot.data as List<NotificationsData>);
                    ontracklist = _runFilter(
                        searchQueryController.text.toString().trim());
                    delayedlist = _runFilter2(
                        searchQueryController.text.toString().trim());
                    ontracklist.sort(((a, b) => b.on.compareTo(a.on)));
                    delayedlist.sort(((a, b) => b.on.compareTo(a.on)));
                    return Expanded(
                        child: TabBarView(
                      controller: _tabController,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        // first tab bar view widget
                        makeOnTrack(screenHeight, screenWidth, context),
                        // second tab bar view widget
                        makeDelayed(screenHeight, screenWidth, context),
                      ],
                    ));
                    // tabview(_tabController, screenHeight,
                    //     screenWidth, context));
                  } else if (snapshot.hasError) {
                    return Center(child: PText(snapshot.error.toString()));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget searchBox(double height, double width) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(width * 0.06),
      child: Container(
        alignment: Alignment.center,
        color: Colors.white,
        padding: EdgeInsets.all(width * 0.004),
        child: TextField(
          controller: searchQueryController,
          textAlignVertical: TextAlignVertical.center,
          onChanged: (value) {
            setState(() {
              ontracklist = _runFilter(value);
              delayedlist = _runFilter2(value);
            });
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: height * 0.005, horizontal: width / 20),
            hintText: "Search MoU",
            hintStyle: GoogleFonts.figtree(
              color: Colors.grey,
              fontSize: width * 0.04,
            ),
            suffixIcon: const Icon(Icons.search),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  List<NotificationsData> _runFilter(String value) {
    final search1 = ontracklist.where((element) {
      final name = element.title.toString().toLowerCase();
      final desc = element.body.toString().toLowerCase();
      final docName = element.docName.toString().toLowerCase();
      final q = value.toLowerCase();
      if (name.contains(q)) {
        return name.contains(q);
      } else if (docName.contains(q)) {
        return docName.contains(q);
      } else {
        return desc.contains(q);
      }
    }).toList();
    // print(search1);
    return ontracklist = search1;
  }

  List<NotificationsData> _runFilter2(String value) {
    final search2 = delayedlist.where((element) {
      final name = element.title.toString().toLowerCase();
      final desc = element.body.toString().toLowerCase();

      final docName = element.docName.toString().toLowerCase();
      final q = value.toLowerCase();
      if (name.contains(q)) {
        return name.contains(q);
      } else if (docName.contains(q)) {
        return docName.contains(q);
      } else {
        return desc.contains(q);
      }
    }).toList();
    // print(search1);
    return delayedlist = search2;
  }

  List<NotificationsData> delayedSort(List<NotificationsData> allData) {
    List<NotificationsData> res = [];
    for (NotificationsData data in allData) {
      if ((data.due).difference(DateTime.now()).isNegative) {
        res.add(data);
      }
    }
    return res;
  }

  List<NotificationsData> onTrackSort(List<NotificationsData> allData) {
    List<NotificationsData> res = [];
    for (NotificationsData data in allData) {
      if ((data.due).difference(DateTime.now()).isNegative) {
      } else {
        res.add(data);
      }
    }
    return res;
  }

  Widget makeOnTrack(double height, double width, BuildContext context) =>
      RefreshIndicator(
        displacement: width * 0.15,
        // edgeOffset: width * 0.1,
        // key: flag == 1 ? refreshKey : refreshKey2,
        onRefresh: () async {
          await NotificationsState().refreshList();
          setState(() {});
        },
        // NotificationsState().refreshList,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: NotificationsState.ontracklist.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
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
              margin: EdgeInsets.symmetric(
                  horizontal: width / 30, vertical: height / 80),
              child: Container(
                decoration: BoxDecoration(
                  color: notiCardColor1.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: makeListTile(NotificationsState.ontracklist[index],
                    height, width, context),
              ),
            );

            // makeCard(
            //     NotificationsState.ontracklist[index], height, width, context);
          },
        ),
      );

  Widget makeDelayed(double height, double width, BuildContext context) =>
      RefreshIndicator(
        displacement: width * 0.15,
        // edgeOffset: width * 0.05,
        // key: flag == 1 ? refreshKey : refreshKey2,
        onRefresh: () async {
          await NotificationsState().refreshList();
          setState(() {});
        },
        // NotificationsState().refreshList,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: NotificationsState.delayedlist.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
                onTap: () {
                  // Navigator.pushNamed(context, Details.routeName);
                },
                child: Container(
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
                  margin: EdgeInsets.symmetric(
                      horizontal: width / 30, vertical: height / 80),
                  child: Container(
                    decoration: BoxDecoration(
                      color: notiCardColor1.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: makeListTile(NotificationsState.delayedlist[index],
                        height, width, context),
                  ),
                )
                // makeCard(NotificationsState.delayedlist[index], height,
                //     width, context),
                );
          },
        ),
      );

  Widget makeListTile(NotificationsData onTrack, double height, double width,
      BuildContext context) {
    String title = onTrack.title;
    String docName = onTrack.docName.toUpperCase();
    Color bottomColor = title.contains("Rejected") ? kCardRed : kTabBarGreen;
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
              fontWeight: FontWeight.w600,
              fontSize: width * 0.04,
            ),
          ),
          subtitle: PText(
            docName,
            style: GoogleFonts.figtree(
                color: kBgClr2,
                fontWeight: FontWeight.w500,
                fontSize: width * 0.032,
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
                          fontSize: width * 0.033,
                          fontWeight: FontWeight.w600,
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
                          companyWebsite: data['company-website'],
                          description: data['description'],
                          isApproved: data['status'],
                          appLvl: data['approval-lvl'],
                          due: date,
                          dueDate: dueDate);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Details(
                                    mou: mou,
                                  )));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: height / 120, bottom: height / 80),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: width / 60),
                            child: PText(
                              "Go To Track",
                              style: GoogleFonts.figtree(
                                color: black,
                                fontWeight: FontWeight.w600,
                                fontSize: width * 0.04,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.ads_click_sharp,
                            size: height * 0.025,
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
}
