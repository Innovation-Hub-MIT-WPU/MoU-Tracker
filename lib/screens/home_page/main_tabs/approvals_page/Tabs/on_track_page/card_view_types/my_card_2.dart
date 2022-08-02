import 'package:MouTracker/screens/home_page/main_tabs/approvals_page'
    '/approvals_page_utils/BuildBottomSheet.dart';
import 'package:flutter/material.dart';

import '../../../../../../../classes/mou.dart';
import '../../../../../../../common_utils/utils.dart';

class MyCard2 extends StatefulWidget {
  // final String docName;
  // final String authName;
  // final int amount;
  // final String description;
  // final date;
  final int index;
  // bool isApproved;

  const MyCard2({
    //   required this.docName,
    // required this.authName,
    // required this.amount,
    // required this.description,
    // required this.date,
    required this.index,
    // required this.isApproved
  });

  @override
  State<MyCard2> createState() => _MyCard2State();
}

class _MyCard2State extends State<MyCard2> {
  int k = 0;
  late MOU mou;
  @override
  void initState() {
    k = widget.index;
    mou = MOU(
      docName: DocName[k],
      authName: AuthName[k],
      companyName: CompanyName[k],
      amount: Amount[k],
      description: Description[k],
      day: 22,
      month: months[k],
      year: 2022,
      index: k,
      isApproved: k % 2 == 0 ? isApproved : !isApproved,
    ); //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        backgroundColor: const Color(0xff2D376E),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        context: context,
        builder: (context) => BuildBottomSheet(index: widget.index),
      ),
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        // index % 2 == 0 ? Colors.teal : Colors.pink
        height: 135,
        width: MediaQuery.of(context).size.width,
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
            const SizedBox(height: 10),
            Text(
              '${mou.docName}  ${mou.companyName}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            // SizedBox(height: 6),
            // Text(
            //   'No. $index           $authName',
            //   style: const TextStyle(fontSize: 12),
            // ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'Before ${mou.day} ${mou.month}, ${mou.year}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
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
      ),
    );
  }
}