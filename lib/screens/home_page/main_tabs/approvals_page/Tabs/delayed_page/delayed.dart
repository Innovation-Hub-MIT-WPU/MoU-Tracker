import 'package:flutter/material.dart';
import '../../approvals_page_utils/list_builders.dart';

class DelayedTab extends StatefulWidget {
  const DelayedTab({Key? key}) : super(key: key);

  @override
  _DelayedTabState createState() => _DelayedTabState();
}

class _DelayedTabState extends State<DelayedTab> {
  bool isApproved = true;

  String dropdownvalue = "Type A";

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          // dropdownvalue == "Type A" ? _BuildListType1() : _BuildListType2(),
          dropdownvalue == "Type A"
              ? buildListType1()
              : dropdownvalue == "Type B"
                  ? buildListType2()
                  : buildListType3(),
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

              // icon: Image.asset(
              //   'assets/images/carousel.png',
              //   width: 15,
              // ),
              // value: dropdownvalue,
              hint:
                  // Text(
                  //   ' Views',
                  //   style: TextStyle(fontSize: 12),
                  // ),
                  Row(
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
