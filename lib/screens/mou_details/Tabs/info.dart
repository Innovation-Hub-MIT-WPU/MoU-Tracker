import 'package:flutter/material.dart';
import '/common_utils/utils.dart';

import '/classes/mou.dart';

class InfoTab extends StatefulWidget {

  
  const InfoTab({Key? key}) : super(key: key);

  @override
  _InfoTabState createState() => _InfoTabState();
}

// todo - Remove the constant Padding values
class _InfoTabState extends State<InfoTab> {
  // Setup a Provider stream here to get MOU data from firestore
  MOU mou = MOU(
      title: "MOU 1",
      desc:
          '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam posuere aliquam ex a auctor..''',
      day: 2,
      month: months[1],
      year: 2022,
      amount:
          10000); // This is just Dummy data, there are more fields in the actual MOU collection
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    String date = "${mou.day} ${mou.month} ${mou.year}";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Information", style: titleStyle()),
        _buildDivider(screenWidth, screenHeight),
        Text("Title", style: subtitleStyle()),
        _displayText(mou.title, screenHeight, titleStyle()),
        Text("Description", style: subtitleStyle()),
        _writeDesc(screenWidth, screenHeight),
        Text("Date", style: subtitleStyle()),
        _displayText(date, screenHeight, normalStyle()),
        Text("Required Amount", style: subtitleStyle()),
        Text("₹ ${mou.amount}", style: normalStyle()),
        _buildDivider(screenWidth, screenHeight),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
          child: _fileDownload(),
        )
      ],
    );
  }

  Padding _writeDesc(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(
          left: screenWidth * 0.09,
          right: screenWidth * 0.09,
          bottom: screenHeight * 0.02),
      child: Text(mou.desc,
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
