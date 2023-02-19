import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/screens/home_page/main_tabs/approvals_page'
    '/approvals_page_utils/BuildBottomSheet.dart';
import 'package:flutter/material.dart';

import '../../../../../../models/mou.dart';
import '../../../../../../../common_utils/utils.dart';

class MyCard3 extends StatefulWidget {
  // final String docName;
  // final String authName;
  // final int amount;
  // final String description;
  // final date;
  final int index;
  final MOU mou;
  // bool isApproved;

  const MyCard3(
      {
      //   required this.docName,
      // required this.authName,
      // required this.amount,
      // required this.description,
      // required this.date,
      required this.index,
      required this.mou,
      // required this.isApproved
      Key? key})
      : super(key: key);

  @override
  State<MyCard3> createState() => _MyCard3State();
}

class _MyCard3State extends State<MyCard3> {
  int k = 0;
  late MOU mou;

  @override
  void initState() {
    k = widget.index;
    mou = widget.mou;
    // mou = MOU(
    //   docName: widget.mouList[k]['doc-name'],
    //   authName: "",
    //   companyName: widget.mouList[k]['company-name'],
    //   description: widget.mouList[k]['description'],
    //   day: 22,
    //   month: "Sept",
    //   year: 2022,
    //   index: 0,
    //   isApproved: widget.mouList[k]['status'],
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent, 
          // Colors.white, 
          isScrollControlled: true,
          // anchorPoint: const Offset(0.5, 0.9),
          // const Color(0xff2D376E),
          useRootNavigator: true,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.only(
          //       topLeft: Radius.circular(screenWidth * 0.08),
          //       topRight: Radius.circular(screenWidth * 0.08)),
          // ),
          context: context,
          builder: (context) => BuildBottomSheet(index: widget.index, mou: mou),
        );
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        // index % 2 == 0 ? Colors.teal : Colors.pink
        height: screenHeight * 0.12,
        width: screenWidth,
        decoration: BoxDecoration(
          color: Colors.white,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // const SizedBox(height: 10),

            // SizedBox(height: 6),
            // PaTaTa(
            //   'No. $index           $authName',
            //   style: const TextStyle(fontSize: 12),
            // ),
            SizedBox(height: screenHeight * 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PText(
                  '${mou.docName}  ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04),
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
                      child: PText(
                        'Before ${mou.dueDate} ',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios),
                // IconButton(
                //   onPressed: () => showModalBottomSheet(
                //       context: context, builder: (context) => buildBottomSheet()),
                //   icon: Icon(Icons.arrow_forward_ios),
                // ),
              ],
            ),
            SizedBox(height: screenWidth * 0.03),
            Container(
              height: screenWidth * 0.09,
              decoration: BoxDecoration(
                color: mou.isApproved ? kCardRed : kTabBarGreen,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PText(
                    'STATUS : ',
                    style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  PText(
                    !mou.isApproved ? 'APPROVED' : 'IN FOR APPROVAL',
                    style: TextStyle(
                        fontSize: screenWidth * 0.035, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
