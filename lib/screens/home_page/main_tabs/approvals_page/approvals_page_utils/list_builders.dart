import 'package:flutter/material.dart';
import 'package:MouTracker/classes/mou.dart';
import 'package:MouTracker/screens/home_page/main_tabs/approvals_page/approvals_page_utils/card_view_types/my_card.dart';
import 'package:MouTracker/screens/home_page/main_tabs/approvals_page/approvals_page_utils/card_view_types/my_card_2.dart';
import 'package:MouTracker/screens/home_page/main_tabs/approvals_page/approvals_page_utils/card_view_types/my_card_3.dart';

Widget buildList(List<MOU> mouList, String type) {
  return ListView.builder(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
    // physics: const PageScrollPhysics(),
    itemCount: mouList.length,
    itemBuilder: (context, index) {
      if (type == "Type A") {
        return MyCard(index: index, mou: mouList[index]);
      } else if (type == "Type B") {
        return MyCard2(index: index, mou: mouList[index]);
      } else {
        return MyCard3(index: index, mou: mouList[index]);
      }
    },
  );
}
