import 'package:flutter/material.dart';

import '../Tabs/on_track_page/card_view_types/my_card.dart';
import '../Tabs/on_track_page/card_view_types/my_card_2.dart';
import '../Tabs/on_track_page/card_view_types/my_card_3.dart';

Widget buildListType1() {
  return ListView.builder(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
    // physics: const PageScrollPhysics(),
    itemCount: 8,
    itemBuilder: (context, index) {
      return MyCard(index: index);
    },
  );
}

Widget buildListType2() {
  return ListView.builder(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
    itemCount: 8,
    itemBuilder: (context, index) {
      return MyCard2(index: index);
    },
  );
}

Widget buildListType3() {
  return ListView.builder(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
    itemCount: 8,
    // _DelayedTabState().DocName.length,
    itemBuilder: (context, index) {
      return MyCard3(index: index);
    },
  );
}
