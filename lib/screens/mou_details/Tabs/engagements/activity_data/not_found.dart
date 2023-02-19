import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotFound extends StatelessWidget {
  final String activityName;

  const NotFound({
    super.key,
    required this.activityName,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      builder: (context, scrollController) => Container(
        height: screenHeight * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(screenWidth * 0.08),
            topRight: Radius.circular(screenWidth * 0.08),
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: scrollController,
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
                    activityName,
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
                    topRight: Radius.circular(
                        MediaQuery.of(context).size.width * 0.05),
                    topLeft: Radius.circular(
                        MediaQuery.of(context).size.width * 0.05),
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width - 100,
                  child: PText(
                    'Data not Found',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.figtree(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
