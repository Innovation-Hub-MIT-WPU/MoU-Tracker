import 'package:flutter/material.dart';

import '../../../BuildBottomSheet.dart';

class MyCard2 extends StatelessWidget {
  final String docName;
  final String authName;
  final int amount;
  final String description;
  final date;
  final int index;
  bool isApproved;

  MyCard2(
      {required this.docName,
      required this.authName,
      required this.amount,
      required this.description,
      required this.date,
      required this.index,
      required this.isApproved});

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
        builder: (context) => BuildBottomSheet(
          docName: docName,
          authName: authName,
          amount: amount,
          description: description,
          date: date,
          index: index,
          isApproved: index % 2 == 0 ? isApproved : !isApproved,
        ),
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
              docName,
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
                    'Before $date',
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
                color: isApproved
                    ? const Color(0XFFCD364E)
                    : const Color(0XFF64C636),
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
                    !isApproved ? 'APPROVED' : 'IN FOR APPROVAL',
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
