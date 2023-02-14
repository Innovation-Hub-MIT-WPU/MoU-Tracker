import 'package:MouTracker/common_utils/webview.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/services/Firebase/firestore/upload_service.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/mou.dart';
import '/common_utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:MouTracker/services/Firebase/firestore/firestore.dart';

class InfoTab extends StatefulWidget {
  final String? heroTag;
  final MOU mou;
  const InfoTab({Key? key, required this.mou, this.heroTag}) : super(key: key);

  @override
  _InfoTabState createState() => _InfoTabState();
}

class _InfoTabState extends State<InfoTab> {
  int k = 0;
  DataBaseService db = DataBaseService();

  // Setup a Provider stream here to get MOU data from firestore
  @override
  void initState() {
    super.initState();
    setState(() {
      // default value to show download iconbutton
      downloadChecker[widget.mou.docName] = 0;
      print(downloadChecker[widget.mou.docName]);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    String date = widget.mou.dueDate;
    return Padding(
      padding: EdgeInsets.only(
          top: screenHeight * 0.06,
          left: screenWidth * 0.02,
          right: screenWidth * 0.02),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PText("Information", style: titleStyle(screenWidth * 0.04)),
            _buildDivider(screenWidth, screenHeight),
            PText("Title", style: subtitleStyle(screenWidth * 0.035)),
            _displayText(widget.mou.docName, screenHeight,
                titleStyle(screenWidth * 0.038)),
            PText("Description",
                style: GoogleFonts.figtree(
                    fontSize: screenWidth * 0.033,
                    fontWeight: FontWeight.w500)),
            _writeDesc(screenWidth, screenHeight),
            PText("Date", style: subtitleStyle(screenWidth * 0.033)),
            _displayText(
                date,
                screenHeight,
                GoogleFonts.figtree(
                    fontSize: screenWidth * 0.033,
                    fontWeight: FontWeight.normal)),
            ElevatedButton(
              onPressed: () async {
                String link = widget.mou.companyWebsite;
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(
                    builder: (context) => WebViewClass(url: link),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              child: PText("Company Website",
                  style: GoogleFonts.figtree(
                      color: Colors.white,
                      fontSize: screenWidth * 0.038,
                      fontWeight: FontWeight.w600)),
            ),
            _buildDivider(screenWidth, screenHeight),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.02),
              child: _fileDownload(screenWidth, screenHeight),
            ),
          ],
        ),
      ),
    );
  }

  Padding _writeDesc(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(
          left: screenWidth * 0.09,
          top: screenHeight * 0.005,
          right: screenWidth * 0.09,
          bottom: screenHeight * 0.02),
      child: PText(widget.mou.description,
          softWrap: true,
          textAlign: TextAlign.justify,
          style: normalStyle(screenWidth * 0.038)),
    );
  }

  Padding _displayText(String text, double screenHeight, TextStyle style) {
    return Padding(
      padding: EdgeInsets.only(
          top: screenHeight * 0.002, bottom: screenHeight * 0.02),
      child: PText(
        text,
        style: style,
      ),
    );
  }

  Padding _buildDivider(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, vertical: screenHeight * 0.01),
      child: Divider(thickness: screenHeight * 0.003),
    );
  }

// Card to download MOU's PDF file
  ListTile _fileDownload(double width, double height) {
    return ListTile(
      title: PText("${widget.mou.docName}.pdf",
          style: GoogleFonts.figtree(
              fontSize: width * 0.038, color: Colors.black)),
      subtitle:
          PText("10.0 MB", style: GoogleFonts.figtree(fontSize: width * 0.03)),
      tileColor: kTileClr,
      leading: const Icon(Icons.file_present, size: 22),
      // onTap: () async {
      //   await FirebaseApi.download(widget.mou.docName);
      // },
      trailing: (downloadChecker[widget.mou.docName] == 0)
          ? IconButton(
              onPressed: () async {
                // this is to show the circular progress indicator
                setState(() {
                  downloadChecker[widget.mou.docName] = -1;
                });

                // Download MOU's PDF for firebase storage, or open it if exists already.
                await FirebaseApi.download(widget.mou.docName);

                // this is to show the downloaded icon
                setState(() {
                  downloadChecker[widget.mou.docName] = 1;
                });

                // showDialog(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return AlertDialog(
                //         backgroundColor: kBgClr2,
                //         title: Row(
                //           children: const <Widget>[
                //             Padding(
                //               padding: EdgeInsets.only(right: 8.0),
                //               child: Icon(
                //                 Icons.done,
                //                 color: Color(0xFFF2C32C),
                //               ),
                //             ),
                //             Flexible(
                //               child: PaTaTa(
                //                 "Downloaded",
                //                 style: GoogleFonts.figtree(
                //                     fontWeight: FontWeight.w600,
                //                     color: Colors.white),
                //               ),
                //             )
                //           ],
                //         ),
                //         content: const PaTaTa(
                //           'saved in your device\'s downloads folder',
                //           style: GoogleFonts.figtree(color: kBgClr1),
                //         ),
                //         actions: <Widget>[
                //           TextButton(
                //             style: ButtonStyle(
                //                 backgroundColor: MaterialStateProperty.all(
                //                     const Color(0xFFF2C32C))),
                //             child: const PaTaTa('Ok'),
                //             onPressed: () {
                //               Navigator.pop(context);
                //             },
                //           ),
                //         ],
                //       );
                //     });
              },
              icon: Icon(Icons.file_open, size: width * 0.06))
          : (downloadChecker[widget.mou.docName] == -1)
              ? const CircularProgressIndicator()
              : SizedBox(
                  // color: Colors.amber,
                  width: width * 0.15,
                  child: IconButton(
                    onPressed: () async {
                      await FirebaseApi.download(widget.mou.docName);
                    },
                    icon: PText('OPEN',
                        style: GoogleFonts.figtree(fontSize: width * 0.03)),
                  ),
                ),
    );
  }
}
