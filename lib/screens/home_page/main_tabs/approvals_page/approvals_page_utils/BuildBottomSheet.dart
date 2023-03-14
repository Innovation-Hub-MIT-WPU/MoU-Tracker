import 'package:MouTracker/models/mou.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/screens/mou_details/mou_details_page.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
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
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      builder: (context, scrollController) =>  Container(
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
            // mainAxisSize: MainAxisSize.min,
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
                    color: mou.isApproved
                        ? const Color(0XFFCD364E).withOpacity(0.6)
                        : kTabBarGreen.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(screenWidth * 0.5),
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
                    mou.description,
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
              // Container(
              //   padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              //   decoration: const BoxDecoration(
              //     color: Colors.white,
              //   ),
              //   child: Container(
              //     alignment: Alignment.centerLeft,
              //     padding: const EdgeInsets.symmetric(vertical: 10),
              //     width: MediaQuery.of(context).size.width - 100,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         PText(
              //           'Amount ',
              //           textAlign: TextAlign.center,
              //           style: GoogleFonts.figtree(
              //             fontWeight: FontWeight.bold,
              //             fontSize: MediaQuery.of(context).size.width * 0.04,
              //             color: Colors.black,
              //           ),
              //         ),
              //         PText(
              //           ' : ',
              //           textAlign: TextAlign.center,
              //           style: GoogleFonts.figtree(
              //             fontWeight: FontWeight.bold,
              //             fontSize: MediaQuery.of(context).size.width * 0.04,
              //             color: Colors.black,
              //           ),
              //         ),
              //         PText(
              //           '₹ 10000',
              //           textAlign: TextAlign.center,
              //           style: GoogleFonts.figtree(
              //             fontWeight: FontWeight.bold,
              //             fontSize: MediaQuery.of(context).size.width * 0.04,
              //             color: Colors.black,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
    
              // Author
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: screenWidth * 0.008,
                    horizontal: screenWidth * 0.05),
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
                        'SPOC Name ',
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
                        mou.spocName,
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

               Container(
                padding: EdgeInsets.symmetric(
                    vertical: screenWidth * 0.008,
                    horizontal: screenWidth * 0.05),
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
                        'SPOC Designation ',
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
                        mou.spocDesignation,
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

               Container(
                padding: EdgeInsets.symmetric(
                    vertical: screenWidth * 0.008,
                    horizontal: screenWidth * 0.05),
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
                        'SPOC Phone ',
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
                        mou.spocNo,
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
    
              Padding(
                padding: EdgeInsets.only(bottom: screenWidth * 0.04),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Details(
                          heroTag: 'mou',
                          mou: mou,
                        ),
                      ),
                    );
                  },
                  child: PText(
                    'More Details',
                    style: GoogleFonts.figtree(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.035,
                      color: Colors.white,
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
