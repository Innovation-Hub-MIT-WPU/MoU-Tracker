import 'package:MouTracker/classes/personalized_text.dart';
import 'package:MouTracker/common_widgets/search.dart';
import 'package:MouTracker/screens/home_page/main_tabs/approvals_page/Tabs/mou_deadline_status.dart';
import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/screens/mou_creation/mou_creation_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        floatingActionButton: Container(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(bottom: screenWidth * 0.04),
          child: FloatingActionButton.extended(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CreateForm())),
            // Navigator.pushNamed(context, '/create_mou'),
            backgroundColor: const Color(0xff2D376E),
            label: PText('Create MOU',
                style: GoogleFonts.figtree(fontSize: screenWidth * 0.04)),
            icon: Icon(
              Icons.add,
              size: screenWidth * 0.06,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: const Color(0xff2D376E),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,

                    // padding: EdgeInsets.only(bottom: 20),
                    width: screenWidth,
                    height: screenHeight * 0.06,
                    child: PText(
                      'Approvals',
                      style: GoogleFonts.figtree(
                          fontSize: screenWidth * 0.05, color: Colors.white),
                    ),
                  ),
                  Container(
                    color: const Color(0xff2D376E),
                    width: screenWidth,
                    height: screenHeight * 0.09,
                    padding: EdgeInsets.fromLTRB(
                        screenWidth * 0.125,
                        screenHeight * 0.0075,
                        screenWidth * 0.125,
                        screenHeight * 0.014),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TabBar(
                          padding: EdgeInsets.all(screenWidth * 0.007),
                          // isScrollable: true,
                          labelStyle: GoogleFonts.figtree(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.bold),
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
            Container(
              height: screenHeight * 0.005,
              color: const Color(0xff2D376E),
              // color: Colors.white,
              child: Divider(
                color: Colors.black.withOpacity(0.25),
                thickness: 1,
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
