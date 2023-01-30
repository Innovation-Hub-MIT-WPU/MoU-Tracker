import 'package:MouTracker/classes/mou.dart';
import 'package:google_fonts/google_fonts.dart';

import '/common_utils/utils.dart';
import 'package:flutter/material.dart';
import '/screens/mou_details/Tabs/info.dart';
import '/screens/mou_details/Tabs/track.dart';
import '/screens/mou_details/Tabs/engagement.dart';

/* MOU Tracking Page
    This Page is supposed to -
      Info tab - Display detailed information of Selected MOU (MOU selected from Approvals tab)
                      Details - [Activities, name, desc, due date, etc]
      Engagement - Display Activity Details 
                      Activities - Events which the org that signs that MOU intends to perform in the clg (hiring,internships,etc)
*/

class Details extends StatefulWidget {
  final MOU mou;
  final String? heroTag;
  const Details({Key? key, required this.mou, this.heroTag = null}) : super(key: key);
  static const routeName = '/mou_details';

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _tabIndex = 0;
  List colors = [
    kTabBarGreen,
    kTabBarYellow,
    kTabBarBlue,
  ]; // Each Tab bar has a different color when selected

  @override
  void initState() {
    _tabController = TabController(length: colors.length, vsync: this)
      ..addListener(() {
        setState(() {
          _tabIndex = _tabController
              .index; // change tabIndex everything Tab is switched
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBgClr2,
        centerTitle: true,
        title: Text(
          "Tracking",
          style: GoogleFonts.figtree(color: Colors.white, fontSize: screenWidth * 0.07),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(16.0),
        //     child: IconButton(
        //         onPressed: () {},
        //         icon: const Icon(Icons.search),
        //         color: Colors.white),
        //   ),
        // ],
        // bottom only accepts normal TabBar(), but ours is wrapped for custom style.
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight * 0.1),
            child: _customTabBar(screenWidth, screenHeight)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                InfoTab(mou: widget.mou,heroTag: widget.heroTag,),
                const EngagementTab(),
                TrackTab(mou: widget.mou),
              ],
            ),
          ),
        ],
      ),
      );
  }

  // Function to build a single tab for tab bar
  /* Note -
      TabBar widget also has a color property, but Its using the updated value of index unless we hot reload.
      Color change only works between 2 colors I guess. - Fixed
  */
  Widget _buildTab(String title, int i) {
    return Container(
      decoration: BoxDecoration(
        color: _tabIndex == i ? colors[_tabIndex] : Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Center(
          child: Text(
        title,
        style: const TextStyle(fontSize: 16),
      )),
    );
  }

  // Function to make rounded tab bar
  Widget _customTabBar(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.1,
        right: screenWidth * 0.1,
        bottom: screenHeight * 0.03,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.065,
        decoration: BoxDecoration(
          border: Border.all(width: kBorderWidth, color: Colors.white),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(child: _buildTabBar()),
      ),
    );
  }

  // In-built Flutter Tab bar Widget
  TabBar _buildTabBar() {
    return TabBar(
        labelPadding: const EdgeInsets.all(1),
        controller: _tabController,
        unselectedLabelColor: Colors.grey,
        indicator:
            const BoxDecoration(), // Keep empty, This Tab bar doesnt have indicator
        tabs: [
          _buildTab('Info', 0), // index is for color in the list
          _buildTab('Engagement', 1),
          _buildTab('Track', 2),
        ],
        labelStyle: _labelStyle(Colors.white),
        unselectedLabelStyle: _labelStyle(Colors.grey));
  }

  // All the labels have same style except for color
  TextStyle _labelStyle(Color clr) {
    return TextStyle(color: clr, fontSize: 13, fontWeight: FontWeight.w600);
  }
}
