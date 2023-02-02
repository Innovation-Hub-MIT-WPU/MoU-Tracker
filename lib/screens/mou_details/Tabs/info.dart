import 'package:MouTracker/common_utils/webview.dart';
import 'package:MouTracker/services/Firebase/firestore/upload_service.dart';
import 'package:google_fonts/google_fonts.dart';
import '/classes/mou.dart';
import '/common_utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:MouTracker/services/Firebase/firestore/firestore.dart';

class InfoTab extends StatefulWidget {
  final String? heroTag;
  final MOU mou;
  const InfoTab({Key? key, required this.mou,this.heroTag = null}) : super(key: key);

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
      child: 
         SingleChildScrollView(
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Information", style: titleStyle(screenWidth * 0.055)),
              _buildDivider(screenWidth, screenHeight),
              Text("Title", style: subtitleStyle(screenWidth * 0.04)),
              _displayText(widget.mou.docName, screenHeight, titleStyle(screenWidth * 0.05)),
              Text("Description", style: GoogleFonts.figtree(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500)),
              _writeDesc(screenWidth, screenHeight),
              Text("Date", style: subtitleStyle(screenWidth * 0.04)),
              _displayText(date, screenHeight, GoogleFonts.figtree(fontSize: screenWidth * 0.04, fontWeight: FontWeight.normal)),
              ElevatedButton(
                onPressed: () async {
                  String link = widget.mou.companyWebsite;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WebViewClass(url: link),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                child: Text("Company Website",
                    style: GoogleFonts.figtree(color: Colors.white, fontSize: screenWidth * 0.045, fontWeight: FontWeight.w600)),
              ),
              _buildDivider(screenWidth, screenHeight),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
                child: _fileDownload(),
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
      child: Text(widget.mou.description,
          softWrap: true, textAlign: TextAlign.justify, style: normalStyle(screenWidth * 0.045)),
    );
  }

  Padding _displayText(String text, double screenHeight, TextStyle style) {
    return Padding(
      padding: EdgeInsets.only(
          top: screenHeight * 0.002, bottom: screenHeight * 0.02),
      child: Text(
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
  ListTile _fileDownload() {
    return ListTile(
      title: Text("${widget.mou.docName}.pdf",
          style: const TextStyle(fontSize: 16, color: Colors.black)),
      subtitle: const Text("10.0 MB", style: TextStyle(fontSize: 12)),
      tileColor: kTileClr,
      leading: const Icon(Icons.file_present, size: 25),
      trailing: (downloadChecker[widget.mou.docName] == 0)
          ? IconButton(
              onPressed: () async {
                // this is to show the circular progress indicator
                setState(() {
                  downloadChecker[widget.mou.docName] = -1;
                });

                // Download MOU's PDF for firebase storage.
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
                //               child: Text(
                //                 "Downloaded",
                //                 style: TextStyle(
                //                     fontWeight: FontWeight.w600,
                //                     color: Colors.white),
                //               ),
                //             )
                //           ],
                //         ),
                //         content: const Text(
                //           'saved in your device\'s downloads folder',
                //           style: TextStyle(color: kBgClr1),
                //         ),
                //         actions: <Widget>[
                //           TextButton(
                //             style: ButtonStyle(
                //                 backgroundColor: MaterialStateProperty.all(
                //                     const Color(0xFFF2C32C))),
                //             child: const Text('Ok'),
                //             onPressed: () {
                //               Navigator.pop(context);
                //             },
                //           ),
                //         ],
                //       );
                //     });
              },
              icon: const Icon(Icons.file_download_outlined, size: 25))
          : (downloadChecker[widget.mou.docName] == -1)
              ? const CircularProgressIndicator()
              : const Icon(Icons.download_done_outlined, size: 25),
    );
  }
}
