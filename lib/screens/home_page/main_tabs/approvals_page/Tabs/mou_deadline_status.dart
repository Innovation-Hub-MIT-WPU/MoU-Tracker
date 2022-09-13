import 'package:MouTracker/screens/home_page/main_tabs/approvals_page/approvals_page_utils/list_builders.dart';
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
    return StreamBuilder(
      stream: DataBaseService().getmouData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<dynamic> mouList = snapshot.data as List<dynamic>;
          return mouCards(mouList);
        } else {
          return const Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        }
      },
    );
  }

  Widget mouCards(List<dynamic> mouList) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          buildList(mouList, dropdownvalue),
          Padding(
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
          ),
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
}
