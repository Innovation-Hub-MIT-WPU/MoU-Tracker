// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:MouTracker/common_utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:MouTracker/classes/personalized_text.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PreviewScreen extends StatelessWidget {
  final pw.Document doc;

  const PreviewScreen({Key? key, required this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: PdfPreview(
        build: (format) => doc.save(),
        allowSharing: true,
        allowPrinting: true,
        initialPageFormat: PdfPageFormat.a4,
        pdfFileName: "mydoc.pdf",
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          size: 30,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: hexStringToColor("2D376E"),
      bottom: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: PText(
              "Preview",
              style: TextStyle(
                color: Colors.white,
                fontFamily: Theme.of(context).textTheme.headline2!.fontFamily,
                fontSize: Theme.of(context).textTheme.headline3!.fontSize,
              ),
            ),
          ),
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.1)),
      centerTitle: true,
    );
  }
}
