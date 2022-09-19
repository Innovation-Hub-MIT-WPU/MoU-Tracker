import 'package:MouTracker/classes/mou.dart';
import 'package:MouTracker/screens/Loading/loading_spinner.dart';
import 'package:MouTracker/screens/home_page/main_tabs/approvals_page/approvals_page_utils/card_view_types/my_card.dart';
import 'package:MouTracker/screens/home_page/main_tabs/approvals_page/approvals_page_utils/card_view_types/my_card_2.dart';
import 'package:MouTracker/screens/home_page/main_tabs/approvals_page/approvals_page_utils/card_view_types/my_card_3.dart';
import 'package:MouTracker/services/Firebase/firestore/firestore.dart';
import 'package:flutter/material.dart';

class MouStatusTab extends StatefulWidget {
  final String due;
  const MouStatusTab({required this.due, Key? key}) : super(key: key);

  @override
  _MouStatusTabState createState() => _MouStatusTabState();
}

class _MouStatusTabState extends State<MouStatusTab> {
  String dropdownvalue = "Type A";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DataBaseService().getmouData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MOU> mouList = snapshot.data as List<MOU>;
          return mouCards(mouList);
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          return const Loading();
        }
      },
    );
  }

  Widget mouCards(List<MOU> mouList) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          buildList(mouList, dropdownvalue),
          dropDownSelector(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/create_mou'),
        backgroundColor: const Color(0xff2D376E),
        label:
            Text('Create MOU', style: TextStyle(fontSize: screenWidth * 0.04)),
        icon: const Icon(
          Icons.add,
          size: 50,
        ),
      ),
    );
  }

  Padding dropDownSelector() {
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: DropdownButton<String>(
        elevation: 50,
        icon: const Icon(
          Icons.keyboard_arrow_down,
          size: 15,
        ),
        autofocus: true,
        borderRadius: BorderRadius.circular(20),
        dropdownColor: Colors.white,
        hint: Row(
          children: [
            Image.asset(
              'assets/images/carousel.png',
              width: 15,
            ),
            const Text(
              ' Views',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        items: <String>['Type A', 'Type B', 'Type C'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newvalue) {
          setState(() {
            dropdownvalue = newvalue!;
          });
        },
      ),
    );
  }
}

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
