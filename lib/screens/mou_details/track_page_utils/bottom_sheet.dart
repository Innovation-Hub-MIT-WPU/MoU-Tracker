import 'package:MouTracker/models/personalized_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivityBottomSheet extends StatefulWidget {
  const ActivityBottomSheet({super.key});

  @override
  State<ActivityBottomSheet> createState() => ActivityBottomSheetState();
}

class ActivityBottomSheetState extends State<ActivityBottomSheet> {
  @override
  Widget build(BuildContext context) {
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
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.5),
                color: Colors.white70),
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
                color: const Color(0XFFCD364E).withOpacity(0.6),
                borderRadius: BorderRadius.circular(screenWidth * 0.5),
              ),
              child: PText(
                'Bottom Shit',
                style: GoogleFonts.figtree(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.05,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // OTHER CONTENT
          SizedBox(height: MediaQuery.of(context).size.width * 0.05),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
                "Description",
                textAlign: TextAlign.center,
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
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width - 100,
              child: PText(
                'Amount : ',
                textAlign: TextAlign.center,
                style: GoogleFonts.figtree(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // Author
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
              child: PText(
                'Author : ',
                textAlign: TextAlign.center,
                style: GoogleFonts.figtree(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
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
