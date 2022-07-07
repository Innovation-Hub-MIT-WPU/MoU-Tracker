import 'package:flutter/material.dart';

import '../../common_utils/utils.dart';

Widget tabs(TabController _tabController, int index, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(45, 10, 45, 20),
    child: Column(
      children: [
        // give the tab bar a height [can change hheight to preferred height]
        Container(
          // height: 40,
          // width: 300,
          height: MediaQuery.of(context).size.height * 0.0565,
          width: MediaQuery.of(context).size.width * 0.75,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              15.0,
            ),
          ),
          child: TabBar(
            padding: const EdgeInsets.all(3),
            controller: _tabController,
            // give the indicator a decoration (color and border radius)

            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(
                15.0,
              ),
              color: index == 0
                  ? const Color(0xFF64C636)
                  : const Color(0xFFCD364E),
            ),
            labelColor: Colors.white,
            labelStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.black.withOpacity(0.25),
            tabs: const [
              // first tab [you can add an icon using the icon property]
              Tab(
                text: 'On Track',
              ),

              // second tab [you can add an icon using the icon property]
              Tab(
                text: 'Delayed',
              ),
            ],
          ),
        ),
        // tab bar view here
      ],
    ),
  );
}

PreferredSizeWidget appbar(
    TabController _tabController, int index, BuildContext context) {
  return AppBar(
    backgroundColor: Color(0xFF2D376E),
    bottom: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: tabs(_tabController, index, context)),
    title: const Padding(
      padding: EdgeInsets.only(
        top: 35,
      ),
      child: Center(
        child: Text(
          'Notifications',
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.w400),
        ),
      ),
    ),
  );
}
