import 'package:MouTracker/classes/mou.dart';
import 'package:MouTracker/classes/personalized_text.dart';
import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/screens/mou_details/mou_details_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCard extends StatefulWidget {
  final MOU mou;
  final int index;
  const MyCard({
    required this.mou,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  int k = 0;
  late MOU mou;
  late String heroTag;
  final GlobalKey _key = GlobalKey();
  @override
  void initState() {
    k = widget.index;
    mou = widget.mou; //
    super.initState();
    heroTag = _key.toString();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Hero(
      tag: heroTag,
      child: GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, '/mou_details');
            // print('Tapped card {${widget.index}}');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Details(
                  heroTag: heroTag,
                  mou: mou,
                ),
              ),
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
              color: Colors.white,
              // Colors.lightBlueAccent.withOpacity(0.1),
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
                Container(
                  width: screenWidth,
                  // padding: EdgeInsets.only(left: screenWidth * 0.04),
                  alignment: Alignment.center,
                  child:
                      // Ro
                      PText(
                    mou.docName,
                    style: GoogleFonts.figtree(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold),
                  ),
                  // ),
                  // ],
                  // ),
                ),

                // SizedBox(height: MediaQuery.of(context).size.height * 0.001),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.09),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PText(
                        'Authorized By ',
                        style: GoogleFonts.figtree(
                            fontSize: screenWidth * 0.03,
                            fontWeight: FontWeight.bold),
                      ),
                      PText(
                        mou.authName,
                        style:
                            GoogleFonts.figtree(fontSize: screenWidth * 0.03),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 4),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.09),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // PaTaTa(
                      //   'No. $k',
                      //   style: GoogleFonts.figtree(fontSize: screenWidth * 0.04),
                      // ),
                      PText(
                        'Company  ',
                        style: GoogleFonts.figtree(
                          fontSize: screenWidth * 0.03,
                          fontWeight: FontWeight.bold,
                          // shadows: [
                          //   Shadow(
                          //     blurRadius: screenWidth * 0.01,
                          //     color: Colors.black,
                          //     offset: Offset(0.1, 0.1),
                          //   ),
                          // ],
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.1,
                        child: PText(
                          mou.companyName,
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              GoogleFonts.figtree(fontSize: screenWidth * 0.03),
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: screenWidth * 0.045,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child:
                          // PaTaTa("${selectedDate.toLocal()}".split(' ')[0]),
                          PText(
                        'Before ${mou.dueDate}',
                        style: GoogleFonts.figtree(
                          fontWeight: FontWeight.w500,
                          fontSize: screenWidth * 0.03,
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.09),
                  child: PText(
                    mou.description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.figtree(
                        fontSize: screenWidth * 0.03,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                // GestureDetector(
                // onTap: () => _selectDate(context),
                // child:
                // ),
                // SizedBox(height: screenHeight * 0.01),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: screenHeight * 0.06,
                    decoration: BoxDecoration(
                      color: mou.isApproved ? kTabBarGreen : kCardRed,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PText(
                          'STATUS : ',
                          style: GoogleFonts.figtree(
                              fontSize: screenWidth * 0.03,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        PText(
                          mou.isApproved ? 'APPROVED' : 'IN FOR APPROVAL',
                          style: GoogleFonts.figtree(
                              fontSize: screenWidth * 0.03,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
