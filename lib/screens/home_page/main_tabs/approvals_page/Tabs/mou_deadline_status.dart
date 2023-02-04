import 'package:MouTracker/models/mou.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/screens/Loading/loading_spinner.dart';
import 'package:MouTracker/screens/home_page/main_tabs/approvals_page/approvals_page_utils/card_view_types/my_card.dart';
import 'package:MouTracker/screens/home_page/main_tabs/approvals_page/approvals_page_utils/card_view_types/my_card_3.dart';
import 'package:MouTracker/services/Firebase/firestore/firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

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

  late TextEditingController searchQueryController;
  @override
  void initState() {
    searchQueryController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchQueryController.dispose();
    super.dispose();
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

          onTrackMouList.sort(((a, b) => b.createdOn!.compareTo(a.createdOn!)));
          delayedMouList.sort(((a, b) => b.createdOn!.compareTo(a.createdOn!)));
          return Stack(
            children: [
              TabBarView(
                controller: widget.tabController,
                children: [
                  mouCards(onTrackMouList),
                  mouCards(delayedMouList),
                ],
              ),
              searchBox(),
            ],
          );
        } else if (snapshot.hasError) {
          return Center(child: PText(snapshot.error.toString()));
        } else {
          return const Loading();
        }
      },
    );
  }

  Widget mouCards(List<MOU> mouList) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: buildList(mouList, dropdownvalue),
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
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
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
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
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
      if ((data.due)!.difference(DateTime.now()).isNegative) {
        res.add(data);
      }
    }
    return res;
  }

  List<MOU> onTrackSort(List<MOU> allData) {
    List<MOU> res = [];
    for (MOU data in allData) {
      if ((data.due)!.difference(DateTime.now()).isNegative) {
      } else {
        res.add(data);
      }
    }
    return res;
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
        borderRadius: BorderRadius.circular(20),
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

Widget buildList(List<MOU> mouList, String type) {
  return ListView.builder(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 55),
    // physics: const PageScrollPhysics(),
    itemCount: mouList.length,
    itemBuilder: (context, index) {
      if (type == "Detailed") {
        return MyCard(
          index: index,
          mou: mouList[index],
          key: UniqueKey(),
        );
      }
   
      else {
        return MyCard3(
          index: index,
          mou: mouList[index],
          key: UniqueKey(),
        );
      }
    },
  );
}
