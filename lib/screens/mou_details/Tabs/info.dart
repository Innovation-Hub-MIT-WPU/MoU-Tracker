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
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Text("Information", style: titleStyle()),
          
          _buildDivider(),
          
          Text(
            "Title",
            style: subtitleStyle(),
          ),
          
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 15.0),
            child: Text(
              mou.title,
              style: titleStyle(),
            ),
          ),
          
          Text("Description", style: subtitleStyle()),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
            child: Text(mou.desc,
                softWrap: true,
                textAlign: TextAlign.center,
                style: subtitleStyle()),
          ),
          
          Text("Date", style: subtitleStyle()),
          
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Text(
              "${mou.day} ${mou.month} ${mou.year}",
              style: normalStyle(),
            ),
          ),
          
          Text("Required Amount", style: subtitleStyle()),
          
          Text("₹ ${mou.amount}", style: normalStyle()),
          
          _buildDivider(),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: _fileDownload(),
          )
        ],
      ),
    );
  }

  Padding _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Divider(thickness: 2),
    );
  }

// Card to download MOU's PDF file
  ListTile _fileDownload() {
    return ListTile(
      title: const Text("file_name.pdf", style: TextStyle(fontSize: 14)),
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

  TextStyle titleStyle() {
    return const TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  }

  TextStyle normalStyle() {
    return const TextStyle(fontSize: 14);
  }

  TextStyle subtitleStyle() {
    return const TextStyle(fontSize: 14);
  }
}
