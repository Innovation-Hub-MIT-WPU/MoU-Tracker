import 'package:MouTracker/screens/home_page/main_tabs/approvals_page/approvals_page_utlis/BuildBottomSheet.dart';
import 'package:flutter/material.dart';

import '../../../../../../../classes/mou.dart';
import '../../../../../../../common_utils/utils.dart';

class MyCard3 extends StatefulWidget {
  // final String docName;
  // final String authName;
  // final int amount;
  // final String description;
  // final date;
  final int index;
  // bool isApproved;

  MyCard3({
    //   required this.docName,
    // required this.authName,
    // required this.amount,
    // required this.description,
    // required this.date,
    required this.index,
    // required this.isApproved
  });

  @override
  State<MyCard3> createState() => _MyCard3State();
}

class _MyCard3State extends State<MyCard3> {
  int k = 0;
  late MOU mou;
  @override
  void initState() {
    k = widget.index;
    mou = MOU(
      docName: DocName[k],
      authName: AuthName[k],
      amount: Amount[k],
      description: Description[k],
      day: 22,
      month: months[k],
      year: 2022,
      index: 0,
      isApproved: k % 2 == 0 ? isApproved : !isApproved,
    ); //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      // index % 2 == 0 ? Colors.teal : Colors.pink
      height: 105,
      width: screenWidth,
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 7,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // const SizedBox(height: 10),

          // SizedBox(height: 6),
          // Text(
          //   'No. $index           $authName',
          //   style: const TextStyle(fontSize: 12),
          // ),
          SizedBox(height: screenHeight * 0.015),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                mou.docName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 18,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.005),
                    child: Text(
                      'Before ${mou.day} ${mou.month}, ${mou.year} ',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                child: const Icon(Icons.arrow_forward_ios),
                onTap: () => showModalBottomSheet(
                  backgroundColor: const Color(0xff2D376E),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  context: context,
                  builder: (context) => BuildBottomSheet(index: widget.index),
                ),
              ),
              // IconButton(
              //   onPressed: () => showModalBottomSheet(
              //       context: context, builder: (context) => buildBottomSheet()),
              //   icon: Icon(Icons.arrow_forward_ios),
              // ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: mou.isApproved ? kCardRed : kTabBarGreen,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'STATUS : ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  !mou.isApproved ? 'APPROVED' : 'IN FOR APPROVAL',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
