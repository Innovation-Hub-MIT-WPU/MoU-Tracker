import 'package:MouTracker/models/mou.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/screens/Loading/loading_spinner.dart';
import 'package:MouTracker/screens/home_page/main_tabs/approvals_page/approvals_page_utils/card_view_types/my_card.dart';
import 'package:MouTracker/screens/home_page/main_tabs/approvals_page/approvals_page_utils/card_view_types/my_card_3.dart';
import 'package:MouTracker/services/Firebase/firestore/firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../services/Firebase/fireauth/model.dart';

class MouStatusTab extends StatefulWidget {
  final TabController tabController;
  const MouStatusTab({required this.tabController, Key? key}) : super(key: key);

  @override
  _MouStatusTabState createState() => _MouStatusTabState();
}

class _MouStatusTabState extends State<MouStatusTab> {
  late List<MOU> mouList;
  late List<MOU> onTrackMouList;
  late List<MOU> delayedMouList;
  String dropdownvalue = "Detailed";
  late UserModel userData;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  var refreshKey2 = GlobalKey<RefreshIndicatorState>();

  late TextEditingController searchQueryController;
  @override
  void initState() {
    searchQueryController = TextEditingController();
    getUserData();
    // refreshList();
    super.initState();
  }

  void getUserData() async {
    userData = await DataBaseService().getuserData();
  }

  @override
  void dispose() {
    searchQueryController.dispose();
    super.dispose();
  }

  Future<void> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    refreshKey2.currentState?.show(atTop: false);
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      DataBaseService().getmouData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DataBaseService().getmouData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          mouList = snapshot.data as List<MOU>;
          mouList = _runFilter(searchQueryController.text.toString().trim());
          onTrackMouList = onTrackSort(mouList);
          delayedMouList = delayedSort(mouList);

          onTrackMouList
              .sort(((a, b) => b.createdDate.compareTo(a.createdDate)));
          delayedMouList
              .sort(((a, b) => b.createdDate.compareTo(a.createdDate)));
          return Stack(
            children: [
              TabBarView(
                physics: const BouncingScrollPhysics(),
                controller: widget.tabController,
                children: [
                  onTrackMouList.isEmpty
                      ? Center(
                          child:
                              PText("You currently have no MoUs for approval",
                                  style: GoogleFonts.figtree(
                                    fontWeight: FontWeight.bold,
                                  )))
                      : mouCards(onTrackMouList, 1),
                  delayedMouList.isEmpty
                      ? Center(
                          child:
                              PText("You currently have no MoUs for approval",
                                  style: GoogleFonts.figtree(
                                    fontWeight: FontWeight.bold,
                                  )))
                      : mouCards(delayedMouList, 2),
                ],
              ),
              searchBox(),
            ],
          );
        } else if (snapshot.hasError) {
          return Center(child: PText(snapshot.error.toString()));
        } else {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            loop: 5,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.05,
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.02,
                    ),
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // Colors.lightBlueAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 4,
                            blurRadius: 7,
                            offset: const Offset(0, 3)),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05,
                        vertical: MediaQuery.of(context).size.height * 0.02),
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // Colors.lightBlueAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 4,
                            blurRadius: 7,
                            offset: const Offset(0, 3)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget mouCards(List<MOU> mouList, int flag) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: RefreshIndicator(
      displacement: screenWidth * 0.15,
      edgeOffset: screenWidth * 0.1,
      key: flag == 1 ? refreshKey : refreshKey2,
      onRefresh: refreshList,
      // () async {
      //   await Future.delayed(const Duration(seconds: 1));
      //   setState(() {});
      // },

      child: ListView.builder(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.02, vertical: screenWidth * 0.2),
        // physics: const BouncingScrollPhysics(),
        itemCount: mouList.length,
        itemBuilder: (context, index) {
          if (dropdownvalue == "Detailed") {
            return MyCard(
              index: index,
              mou: mouList[index],
              userPos: userData.pos!,
              key: UniqueKey(),
            );
          } else {
            return MyCard3(
              index: index,
              mou: mouList[index],
              userPos: userData.pos!,
              key: UniqueKey(),
            );
          }
        },
      ),
    )
        // buildList(mouList, dropdownvalue, refreshKey),
        );
  }

  Widget searchBox() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: kBgClr2,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(screenWidth * 0.08),
          bottomRight: Radius.circular(screenWidth * 0.08),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: screenWidth * 0.7,
            margin: EdgeInsets.only(
              top: screenWidth / 50,
              bottom: screenWidth / 50,
              // left: screenWidth * 0.04
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenWidth * 0.5)),
            child: TextField(
              controller: searchQueryController,
              onChanged: (value) {
                setState(() {
                  mouList = _runFilter(value);
                });
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    vertical: screenHeight / 70, horizontal: screenWidth / 20),
                hintText: "Search MoU",
                hintStyle: GoogleFonts.figtree(
                    fontSize: screenWidth * 0.04, color: Colors.grey),
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.5),
                  // borderSide: const BorderSide(),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.5),
                  borderSide: const BorderSide(color: kBgClr2),
                ),
              ),
            ),
          ),
          dropDownSelector()
        ],
      ),
    );
  }

  List<MOU> delayedSort(List<MOU> allData) {
    List<MOU> res = [];

    for (MOU data in allData) {
      bool condition1 = (data.due).difference(DateTime.now()).isNegative;
      bool condition2 = data.appLvl >= userData.pos!;
      if (condition1 && condition2) {
        res.add(data);
      }
    }
    return res;
  }

  List<MOU> onTrackSort(List<MOU> allData) {
    List<MOU> res2 = [];
    for (MOU data in allData) {
      bool condition1 = (data.due).difference(DateTime.now()).isNegative;
      bool condition2 = data.appLvl >= userData.pos!;
      if (!(condition1) && condition2) {
        res2.add(data);
      }
    }
    return res2;
  }

  List<MOU> _runFilter(String value) {
    List<MOU> search1 = mouList.where((element) {
      final doc = element.docName.toString().toLowerCase();
      final company = element.companyName.toString().toLowerCase();
      final desc = element.description.toString().toLowerCase();
      final date = element.dueDate.toString().toLowerCase();
      final query = value.toLowerCase();

      if (company.contains(query)) {
        return company.contains(query);
      } else if (doc.contains(query)) {
        return doc.contains(query);
      } else if (desc.contains(query)) {
        return desc.contains(query);
      } else {
        return date.contains(query);
      }
    }).toList();

    return search1;
  }

  Widget dropDownSelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: DropdownButton<String>(
          underline: Container(),
          elevation: 50,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black,
            size: 17,
          ),
          autofocus: true,
          borderRadius: BorderRadius.circular(20),
          dropdownColor: Colors.white,
          hint: Row(
            children: [
              Image.asset(
                'assets/images/carousel.png',
                width: 17,
              ),
              PText(
                'Views',
                style: GoogleFonts.figtree(
                    fontSize: 13, fontWeight: FontWeight.normal),
              ),
            ],
          ),
          items: <String>['Detailed', 'Short'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: PText(value),
            );
          }).toList(),
          onChanged: (String? newvalue) {
            setState(() {
              dropdownvalue = newvalue!;
            });
          },
        ),
      ),
    );
  }
}

// Widget buildList(List<MOU> mouList, String type, GlobalKey<RefreshIndicatorState> refreshKey) {
//   return RefreshIndicator(
//     key: refreshKey,
//     onRefresh: () async {
//       await Future.delayed(const Duration(seconds: 1));
//       setState(() {});
//     },

//     child: ListView.builder(
  
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 55),
//       physics: const BouncingScrollPhysics(),
//       itemCount: mouList.length,
//       itemBuilder: (context, index) {
//         if (type == "Detailed") {
//           return MyCard(
//             index: index,
//             mou: mouList[index],
//             key: UniqueKey(),
//           );
//         } else {
//           return MyCard3(
//             index: index,
//             mou: mouList[index],
//             key: UniqueKey(),
//           );
//         }
//       },
//     ),
//   );
// }
