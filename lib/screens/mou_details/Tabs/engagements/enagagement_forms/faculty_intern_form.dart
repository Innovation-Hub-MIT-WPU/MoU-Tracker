import 'package:MouTracker/common_utils/upload_file.dart';
import 'package:MouTracker/common_widgets/widgets.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/screens/mou_creation/creation_page_utils/create_mou_widgets.dart';
import 'package:MouTracker/common_widgets/fields.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io' as io;

class FacultyInternForm extends StatefulWidget {
  final String title;
  const FacultyInternForm({this.title = "Engagement activity", super.key});


  @override
  State<FacultyInternForm> createState() => _FacultyInternFormState();
}

class _FacultyInternFormState extends State<FacultyInternForm> {
  TextEditingController yearController = TextEditingController();

  TextEditingController divisionController = TextEditingController();

  TextEditingController schoolController = TextEditingController();

  TextEditingController studentDetailsController = TextEditingController();

  TextEditingController docController = TextEditingController();

   static io.File? file;
  static UploadTask? task;

  GlobalKey formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar(widget.title, context),
      body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PText(
                    "Year",
                    style: GoogleFonts.figtree(
                        fontSize: screenWidth * 0.040,
                        fontWeight: FontWeight.bold),
                  ),
                  CreateMouField(
                      hintText: "Academic Year",
                      textInputType: TextInputType.multiline,
                      textEditingController: yearController),
                  PText(
                    "Division",
                    style: GoogleFonts.figtree(
                        fontSize: screenWidth * 0.040,
                        fontWeight: FontWeight.bold),
                  ),
                  CreateMouField(
                      hintText: "Department Division",
                      textInputType: TextInputType.text,
                      textEditingController: divisionController),
                  PText(
                    "School",
                    style: GoogleFonts.figtree(
                        fontSize: screenWidth * 0.040,
                        fontWeight: FontWeight.bold),
                  ),
                  CreateMouField(
                      hintText: "School",
                      textInputType: TextInputType.text,
                      textEditingController: schoolController),

                  fileName(file),
                  Center(child: chooseFileButton(context, pickFile)),

                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenWidth * 0.05),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        child: const PText("Submit"),
                      ),
                    ),
                  ),
                  // selectDueDate(context),
                ],
              ),
            ),
          )),
    );
  }

  Future pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) {
      print("result null");
      return;
    } else {
      final filepath = result.files.single.path!;
      setState(() {
        file = io.File(filepath);
      });
    }
  }
}