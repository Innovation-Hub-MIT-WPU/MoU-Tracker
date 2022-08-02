import 'package:flutter/material.dart';

Widget tabs(TabController _tabController, int index, BuildContext context) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return Padding(
    padding:
    EdgeInsets.fromLTRB(width / 10, height / 60, width / 10, height / 40),
    child: Column(
      children: [
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
              Tab(
                text: 'On Track',
              ),
              Tab(
                text: 'Delayed',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

PreferredSizeWidget appbar(
    TabController _tabController, int index, BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Color(0xFF2D376E),
    bottom: PreferredSize(
        preferredSize:
        Size.fromHeight(MediaQuery.of(context).size.height * 0.10),
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
