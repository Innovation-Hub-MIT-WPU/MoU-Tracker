import 'package:MouTracker/screens/home_page/main_tabs/approvals_page/approvals_page_utils/card_view_types/my_card.dart';
import 'package:MouTracker/screens/home_page/main_tabs/approvals_page/approvals_page_utils/card_view_types/my_card_2.dart';
import 'package:MouTracker/screens/home_page/main_tabs/approvals_page/approvals_page_utils/card_view_types/my_card_3.dart';
import 'package:flutter/material.dart';

Widget buildList(List<dynamic> mouList, String type) {
  return ListView.builder(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
    // physics: const PageScrollPhysics(),
    itemCount: mouList.length,
    itemBuilder: (context, index) {
      if (type == "Type A") {
        return MyCard(index: index, mouList: mouList);
      } else if (type == "Type B") {
        return MyCard2(index: index, mouList: mouList);
      } else {
        return MyCard3(index: index, mouList: mouList);
      }
    },
  );
}

// Widget buildListType1(List<dynamic> mouList) {
//   return ListView.builder(
//     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
//     // physics: const PageScrollPhysics(),
//     itemCount: mouList.length,
//     itemBuilder: (context, index) {
//       return MyCard(index: index, mouList: mouList);
//     },
//   );
// }

// Widget buildListType2(List<dynamic> mouList) {
//   return ListView.builder(
//     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
//     itemCount: 8,
//     itemBuilder: (context, index) {
//       return MyCard2(index: index, mouList: mouList);
//     },
//   );
// }

// Widget buildListType3(List<dynamic> mouList) {
//   return ListView.builder(
//     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
//     itemCount: 8,
//     // _DelayedTabState().DocName.length,
//     itemBuilder: (context, index) {
//       return MyCard3(index: index, mouList: mouList);
//     },
//   );
// }
