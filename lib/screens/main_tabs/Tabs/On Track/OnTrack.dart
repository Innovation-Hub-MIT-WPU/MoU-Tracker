import 'package:flutter/material.dart';
import 'Card View Types/MyCard.dart';
import 'Card View Types/MyCard2.dart';
import 'Card View Types/MyCard3.dart';

class OnTrackTab extends StatefulWidget {
  const OnTrackTab({Key? key}) : super(key: key);

  @override
  _OnTrackTabState createState() => _OnTrackTabState();
}

class _OnTrackTabState extends State<OnTrackTab> {
  final List DocName = ['MoU 1', 'MoU 2', 'MoU 3'];
  final List AuthName = ['Bob', 'Adam', 'Greg'];
  final List Amount = [10000, 100000, 1000000];
  final List Description = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam posuere aliquam ex a auctor.. ',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam posuere aliquam ex a auctor.. ',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam posuere aliquam ex a auctor.. '
  ];
  final List DueDate = [
    '2 Feb, 2022',
    '2 Mar, 2022',
    '2 Apr, 2022',
  ];
  bool isApproved = true;

  String dropdownvalue = "Type A";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // dropdownvalue == "Type A" ? _BuildListType1() : _BuildListType2(),
          dropdownvalue == "Type A"
              ? _BuildListType1()
              : dropdownvalue == "Type B"
                  ? _BuildListType2()
                  : _BuildListType3(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/create_mou'),
        backgroundColor: const Color(0xff64C636),
        child: const Icon(
          Icons.add,
          size: 50,
        ),
      ),
    );
  }
}

Widget _BuildListType1() {
  return ListView.builder(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
    itemCount: _OnTrackTabState().DocName.length,
    itemBuilder: (context, index) {
      return MyCard(
        docName: _OnTrackTabState().DocName[index],
        authName: _OnTrackTabState().AuthName[index],
        amount: _OnTrackTabState().Amount[index],
        description: _OnTrackTabState().Description[index],
        date: _OnTrackTabState().DueDate[index],
        index: index,
        isApproved: index % 2 == 0
            ? _OnTrackTabState().isApproved
            : !_OnTrackTabState().isApproved,
      );
    },
  );
}

Widget _BuildListType2() {
  return ListView.builder(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
    itemCount: _OnTrackTabState().DocName.length,
    itemBuilder: (context, index) {
      return MyCard2(
        docName: _OnTrackTabState().DocName[index],
        authName: _OnTrackTabState().AuthName[index],
        amount: _OnTrackTabState().Amount[index],
        description: _OnTrackTabState().Description[index],
        date: _OnTrackTabState().DueDate[index],
        index: index,
        isApproved: index % 2 == 0
            ? _OnTrackTabState().isApproved
            : !_OnTrackTabState().isApproved,
      );
    },
  );
}

Widget _BuildListType3() {
  return ListView.builder(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
    itemCount: _OnTrackTabState().DocName.length,
    itemBuilder: (context, index) {
      return MyCard3(
        docName: _OnTrackTabState().DocName[index],
        authName: _OnTrackTabState().AuthName[index],
        amount: _OnTrackTabState().Amount[index],
        description: _OnTrackTabState().Description[index],
        date: _OnTrackTabState().DueDate[index],
        index: index,
        isApproved: index % 2 == 0
            ? _OnTrackTabState().isApproved
            : !_OnTrackTabState().isApproved,
      );
    },
  );
}
