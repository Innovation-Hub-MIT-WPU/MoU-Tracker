import 'package:MouTracker/common_widgets/search.dart';
import 'package:MouTracker/screens/home_page/main_tabs/approvals_page/Tabs/mou_deadline_status.dart';
import 'package:MouTracker/common_utils/utils.dart';
import 'package:flutter/material.dart';

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
    indicatorColor = kTabBarGreen;
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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
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
                      width: screenWidth,
                      height: screenHeight * 0.07,
                      child: const Text(
                        'Approvals',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      )),
                  Container(
                    color: const Color(0xff2D376E),
                    width: screenWidth,
                    height: screenHeight * 0.1,
                    padding: EdgeInsets.fromLTRB(
                        screenWidth * 0.125,
                        screenHeight * 0.010,
                        screenWidth * 0.125,
                        screenHeight * 0.02),
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
                child: MouStatusTab(
              tabController: _tabController,
            )),
          ],
        ),
      ),
    );
  }
}
