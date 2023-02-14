import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/screens/Loading/loading_spinner.dart';
import 'package:MouTracker/services/Firebase/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivityBottomSheet extends StatefulWidget {
  final String mouId;
  const ActivityBottomSheet({super.key, required this.mouId});

  @override
  State<ActivityBottomSheet> createState() => ActivityBottomSheetState();
}

class ActivityBottomSheetState extends State<ActivityBottomSheet> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder<Object>(
        future: DataBaseService().getEngagementData(widget.mouId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ActivityData(screenWidth: screenWidth);
          } else {
            return const Loading();
          }
        });
  }
}

class ActivityData extends StatelessWidget {
  const ActivityData({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.5),
              color: const Color(0xff2D376E),
            ),
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
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.5),
            ),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: kTabBarGreen.withOpacity(0.6),
                borderRadius: BorderRadius.circular(screenWidth * 0.5),
              ),
              child: PText(
                'Data ',
                style: GoogleFonts.figtree(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.05,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // OTHER CONTENT
          SizedBox(height: MediaQuery.of(context).size.width * 0.05),

          Container(
            padding: EdgeInsets.symmetric(
                vertical: screenWidth * 0.02, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight:
                    Radius.circular(MediaQuery.of(context).size.width * 0.05),
                topLeft:
                    Radius.circular(MediaQuery.of(context).size.width * 0.05),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width - 100,
              child: PText(
                'description',
                textAlign: TextAlign.left,
                style: GoogleFonts.figtree(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.035,
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
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width - 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PText(
                    'Amount ',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.figtree(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Colors.black,
                    ),
                  ),
                  PText(
                    ' : ',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.figtree(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Colors.black,
                    ),
                  ),
                  PText(
                    '₹ 10000',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.figtree(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Author
          Container(
            padding: EdgeInsets.symmetric(
                vertical: screenWidth * 0.008, horizontal: screenWidth * 0.05),
            margin: EdgeInsets.only(bottom: screenWidth * 0.04),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomRight:
                    Radius.circular(MediaQuery.of(context).size.width * 0.05),
                bottomLeft:
                    Radius.circular(MediaQuery.of(context).size.width * 0.05),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width - 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PText(
                    'Authour ',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.figtree(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Colors.black,
                    ),
                  ),
                  PText(
                    ' : ',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.figtree(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Colors.black,
                    ),
                  ),
                  PText(
                    "Some Name",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.figtree(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
