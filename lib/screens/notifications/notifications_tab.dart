import 'package:flutter/material.dart';

Widget tabs(TabController _tabController, int index) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
    child: Column(
      children: [
        // give the tab bar a height [can change hheight to preferred height]
        Container(
          height: 40,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.grey[300],
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
            unselectedLabelColor: Colors.black,
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

PreferredSizeWidget appbar(TabController _tabController, int index) {
  return AppBar(
    backgroundColor: Color(0xFF2D376E),
    bottom: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: tabs(_tabController, index)),
    title: const Padding(
      padding: EdgeInsets.only(
        top: 35,
      ),
      child: Center(
        child: Text(
          'Notifications',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}
