import 'package:flutter/material.dart';
import 'package:MouTracker/classes/personalized_text.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../classes/mou.dart';
import '../../../../../common_utils/utils.dart';

class BuildBottomSheet extends StatefulWidget {
  final int index;
  final MOU mou;
  // bool isApproved;

  const BuildBottomSheet({
    super.key,
    required this.mou,
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
    mou = widget.mou;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      // padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: screenWidth * 0.05,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.01 - 2,
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.white70),
          ),
          SizedBox(
            height: screenWidth * 0.045,
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
                color: mou.isApproved
                    ? const Color(0XFFCD364E).withOpacity(0.6)
                    : kTabBarGreen.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: PText(
                '${mou.companyName} \n ${mou.docName} ',
                style: GoogleFonts.figtree(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.05,
                  color: mou.isApproved ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
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
              child: PText(
                mou.description,
                textAlign: TextAlign.center,
                style: GoogleFonts.figtree(
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
              child: PText(
                'Amount : ₹ 10000',
                textAlign: TextAlign.center,
                style: GoogleFonts.figtree(
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
              child: PText(
                'Author : ${mou.authName}',
                textAlign: TextAlign.center,
                style: GoogleFonts.figtree(
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
