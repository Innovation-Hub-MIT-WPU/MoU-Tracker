import 'package:flutter/material.dart';

import '../../../../../../../classes/mou.dart';
import '../../../../../../../common_utils/screen_arguments.dart';
import '../../../../../../../common_utils/utils.dart';
import '../../../../../../mou_details/mou_details_page.dart';

class MyCard extends StatefulWidget {
  final int index;
  const MyCard({
    required this.index,
  });

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, '/mou_details');
        // print('Tapped card {${widget.index}}');
        Navigator.pushNamed(
          context,
          Details.routeName,
          arguments: ScreenArguments(k),
        );
        // print('Tapped card ${mou.index}');
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
        // index % 2 == 0 ? Colors.teal : Colors.pink
        height: screenHeight * 0.3,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: screenHeight * 0.01),
            Text(
              mou.docName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            // SizedBox(height: MediaQuery.of(context).size.height * 0.001),
            Text(
              'No. ${mou.index}           ${mou.authName}             ${mou.companyName}',
              style: const TextStyle(fontSize: 15),
            ),
            // const SizedBox(height: 4),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
              child: Text(
                mou.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.6)),
              ),
            ),
            // GestureDetector(
            // onTap: () => _selectDate(context),
            // child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child:
                      // Text("${selectedDate.toLocal()}".split(' ')[0]),
                      Text(
                    'Before ${mou.day}/${mou.month}/${mou.year} ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            // ),
            SizedBox(height: screenHeight * 0.01),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: screenHeight * 0.06,
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
            ),
          ],
        ),
      ),
    );
  }
}
