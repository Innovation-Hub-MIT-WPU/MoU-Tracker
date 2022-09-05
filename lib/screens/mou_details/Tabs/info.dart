import '/classes/mou.dart';
import '/common_utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:MouTracker/services/Firebase/firestore/firestore.dart';

class InfoTab extends StatefulWidget {
  final int index;
  final MOU mou;
  const InfoTab({Key? key, required this.index, required this.mou})
      : super(key: key);

  @override
  _InfoTabState createState() => _InfoTabState();
}

class _InfoTabState extends State<InfoTab> {
  int k = 0;
  DataBaseService db = DataBaseService();
  // Setup a Provider stream here to get MOU data from firestore
  @override
  void initState() {
    k = widget.index;
    // mou = MOU(
    //   docName: DocName[k],
    //   authName: AuthName[k],
    //   companyName: CompanyName[k],
    //   description: Description[k],
    //   day: 22,
    //   month: months[k],
    //   year: 2022,
    //   index: 0,
    //   isApproved: k % 2 == 0 ? isApproved : !isApproved,
    // );
    super.initState();
  }

  final Uri _url = Uri.parse('https://flutter.dev');
  // This is just Dummy data, there are more fields in the actual MOU collection
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    String date = "${widget.mou.day} ${widget.mou.month} ${widget.mou.year}";
    return Padding(
      padding: EdgeInsets.only(
          top: screenHeight * 0.06,
          left: screenWidth * 0.02,
          right: screenWidth * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Information", style: titleStyle()),
          _buildDivider(screenWidth, screenHeight),
          Text("Title", style: subtitleStyle()),
          _displayText(widget.mou.docName, screenHeight, titleStyle()),
          Text("Description", style: subtitleStyle()),
          _writeDesc(screenWidth, screenHeight),
          Text("Date", style: subtitleStyle()),
          _displayText(date, screenHeight, normalStyle()),
          ElevatedButton(
            onPressed: () async {
              final Uri url = Uri.parse('https://flutter.dev');
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
            ),
            child: const Text("Company Website",
                style: TextStyle(color: Colors.white, fontSize: 17)),
          ),
          _buildDivider(screenWidth, screenHeight),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
            child: _fileDownload(),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  Padding _writeDesc(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(
          left: screenWidth * 0.09,
          right: screenWidth * 0.09,
          bottom: screenHeight * 0.02),
      child: Text(widget.mou.description,
          softWrap: true, textAlign: TextAlign.center, style: normalStyle()),
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
      title: const Text("file_name.pdf",
          style: TextStyle(fontSize: 16, color: Colors.black)),
      subtitle: const Text("10.0 MB", style: TextStyle(fontSize: 12)),
      tileColor: kTileClr,
      leading: const Icon(Icons.file_present, size: 25),
      trailing: IconButton(
          onPressed: () {
            // Download MOU's PDF for firebase storage.
          },
          icon: const Icon(Icons.file_download_outlined, size: 25)),
    );
  }
}
