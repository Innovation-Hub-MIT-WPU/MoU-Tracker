import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/services/Firebase/firestore/upload_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ActivityData extends StatefulWidget {
  final String mouId;
  final String activityName;
  final Map<String, dynamic> activity;
  const ActivityData(
      {super.key,
      required this.activity,
      required this.activityName,
      required this.mouId});

  @override
  State<ActivityData> createState() => _ActivityDataState();
}

addToListSeparated(List<Widget> list, String val, TextAlign textAlign,
    double screenWidth, double screenHeight) {
  list.add(PText(
    val,
    textAlign: TextAlign.left,
    style: GoogleFonts.figtree(
      fontWeight: FontWeight.w600,
      fontSize: screenWidth * 0.04,
      color: Colors.black,
    ),
  ));
  list.add(SizedBox(height: screenHeight * 0.05));
}

class _ActivityDataState extends State<ActivityData> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    List<Widget> fields = [];
    List<Widget> colons = [];

    List<Widget> values = [];

    for (var key in widget.activity.keys) {
      var value = widget.activity[key];

      // Key
      addToListSeparated(
          fields, key, TextAlign.left, screenWidth, screenHeight);

      // Colon
      addToListSeparated(
          colons, ":", TextAlign.center, screenWidth, screenHeight);

      // Value

      // TODO: Write Utility Function to Convert DateTime to String
      if (value.runtimeType == Timestamp) {
        DateTime date = value.toDate();
        value = "${date.year}-${date.month}-${date.day}";
      }
      addToListSeparated(
          values, value, TextAlign.right, screenWidth, screenHeight);
    }

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
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
                    widget.activityName,
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
                    'Description',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.figtree(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.035,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              // Field 1
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: fields,
                    ),
                    Column(
                      children: colons,
                    ),
                    Column(
                      children: values,
                    ),
                  ],
                ),
              ),
              FutureBuilder<Widget>(
                future: _fileDownload(screenWidth, screenHeight),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return snapshot.data!;
                  } else {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      loop: 5,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.01,
                            vertical:
                                MediaQuery.of(context).size.height * 0.003),
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          // Colors.lightBlueAccent.withOpacity(0.1),
                          // borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<ListTile> _fileDownload(double width, double height) async {
    final ref = FirebaseStorage.instance.ref('/${widget.mouId}');
    final result = await ref.listAll();
    final url = await result.items[0].getDownloadURL();
    // print('url: $url');
    final FullMetadata metaData = await result.items[0].getMetadata();
    String extensionName = metaData.contentType.toString().split('/').last;
    return ListTile(
      title: PText("${widget.activityName}.$extensionName",
          style: GoogleFonts.figtree(
              fontSize: width * 0.038, color: Colors.black)),
      subtitle: (metaData.size! / 1000 > 100)
          ? PText("${metaData.size! / 1000000} MB",
              style: GoogleFonts.figtree(fontSize: width * 0.03))
          : PText("${metaData.size! / 1000} KB",
              style: GoogleFonts.figtree(fontSize: width * 0.03)),
      tileColor: kTileClr,
      leading: const Icon(Icons.file_present, size: 22),
      // onTap: () async {
      //   await FirebaseApi.download(widget.mou.mouId);
      // },
      onTap: () async {
        // this is to show the circular progress indicator
        setState(() {
          downloadChecker[widget.mouId] = -1;
        });

        // Download MOU's PDF for firebase storage, or open it if exists already.
        await FirebaseApi.download(widget.mouId);

        // this is to show the downloaded icon
        setState(() {
          downloadChecker[widget.mouId] = 1;
        });
      },
      trailing: (downloadChecker[widget.mouId] == 0)
          ? IconButton(
              onPressed: () async {
                // this is to show the circular progress indicator
                setState(() {
                  downloadChecker[widget.mouId] = -1;
                });

                // Download MOU's PDF for firebase storage, or open it if exists already.
                await FirebaseApi.download(
                    "$widget.mouId/Activities/${widget.activityName}/");

                // this is to show the downloaded icon
                setState(() {
                  downloadChecker[widget.mouId] = 1;
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
          : (downloadChecker[widget.mouId] == -1)
              ? const CircularProgressIndicator()
              : SizedBox(
                  // color: Colors.amber,
                  width: width * 0.15,
                  child: IconButton(
                    onPressed: () async {
                      await FirebaseApi.download(widget.mouId);
                    },
                    icon: PText('OPEN',
                        style: GoogleFonts.figtree(fontSize: width * 0.03)),
                  ),
                ),
    );
  }
}
