import 'package:flutter/material.dart';

import '../../../../../classes/mou.dart';
import '../../../../../common_utils/utils.dart';

class BuildBottomSheet extends StatefulWidget {
  final int index;
  // bool isApproved;

  const BuildBottomSheet({
    required this.index,
  });

  @override
  State<BuildBottomSheet> createState() => _BuildBottomSheetState();
}

class _BuildBottomSheetState extends State<BuildBottomSheet> {
  int k = 0;
  late MOU mou;
  @override
  void initState() {
    k = widget.index;
    mou = MOU(
      docName: DocName[k],
      authName: AuthName[k],
      companyName: CompanyName[k],
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
    return SingleChildScrollView(
      // padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.01 - 2,
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.white70),
          ),
          const SizedBox(
            height: 20,
          ),

          // DOCUMENT TITLE
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: mou.isApproved ? const Color(0XFFCD364E) : kTabBarGreen,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${mou.docName}  ${mou.companyName}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: mou.isApproved ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),

          // OTHER CONTENT
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width - 100,
              child: Text(
                mou.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // Amount
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width - 100,
              child: const Text(
                'Amount : ₹ 10000',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // Author
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width - 100,
              child: Text(
                'Author : ${mou.authName}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
