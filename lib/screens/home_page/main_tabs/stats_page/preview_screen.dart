// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:MouTracker/common_utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:pdf/pdf.dart';
// ignore: depend_on_referenced_packages
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PreviewScreen extends StatelessWidget {
  final pw.Document doc;

  const PreviewScreen({Key? key, required this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(190, 255, 255, 255),
      appBar: appBar(context),
      body: Padding(
        padding: EdgeInsets.only(top: screenWidth * 0.2),
        child: PdfPreview(
          canChangeOrientation: false,
          // canChangePageFormat: true,
          maxPageWidth: screenWidth * 0.9,
          build: (format) => doc.save(),
          allowSharing: true,
          allowPrinting: true,
          initialPageFormat: PdfPageFormat.a4,
          pdfFileName: "mydoc.pdf",
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AppBar(
      toolbarHeight: screenWidth * 0.15,
      // shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(screenWidth * 0.05),
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          size: screenWidth * 0.06,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: hexStringToColor("2D376E"),
      // foregroundColor: hexStringToColor("2D376E"),
      elevation: 0,
      bottom: PreferredSize(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, screenWidth * 0.08),
            child: PText(
              "Preview",
              style: GoogleFonts.figtree(
                color: Colors.white,
                fontSize: screenWidth * 0.06,
              ),
            ),
          ),
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.1)),
      centerTitle: true,
    );
  }
}
