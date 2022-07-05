import 'package:MouTracker/common_widgets/my_bottom_navbar.dart';
import 'package:flutter/material.dart';

import 'Tabs/Delayed/Delayed.dart';
import 'Tabs/On Track/OnTrack.dart';

class ApprovalsPage extends StatefulWidget {
  const ApprovalsPage({Key? key}) : super(key: key);

  @override
  ApprovalsPageState createState() => ApprovalsPageState();
}

class ApprovalsPageState extends State<ApprovalsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final colors = [const Color(0xff64C636), const Color(0XFFCD364E)];
  Color? indicatorColor;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    indicatorColor = const Color(0xff64C636);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      indicatorColor = colors[_tabController.index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const MyBottomNavBar(),
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   centerTitle: true,
        //   title: const Text(
        //     "Approvals",
        //     style: TextStyle(color: Colors.black),
        //   ),
        //   actions: const [
        //     Padding(
        //       padding: EdgeInsets.all(16.0),
        //       child: Icon(Icons.search, color: Colors.black),
        //     ),
        //   ],
        // ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: const Color(0xff2D376E),
              child: Column(
                children: [
                  Container(
                      alignment: Alignment.bottomCenter,
                      color: const Color(0xff2D376E),
                      // padding: EdgeInsets.only(bottom: 20),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: const Text(
                        'Approvals',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      )),
                  Container(
                    color: const Color(0xff2D376E),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    padding: const EdgeInsets.fromLTRB(45, 10, 45, 18),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TabBar(
                          padding: const EdgeInsets.all(2.5),
                          // isScrollable: true,
                          labelStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          unselectedLabelColor: Colors.black.withOpacity(0.25),
                          indicator: BoxDecoration(
                            color:
                                // colors[0],
                                indicatorColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          controller: _tabController,
                          tabs: const [
                            Tab(text: "On Track"),
                            Tab(text: "Delayed"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  OnTrackTab(),
                  DelayedTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
