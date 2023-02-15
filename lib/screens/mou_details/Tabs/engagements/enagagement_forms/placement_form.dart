import 'package:MouTracker/common_utils/upload_file.dart';
import 'package:MouTracker/common_widgets/widgets.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/screens/home_page/new_nav_bar.dart';
import 'package:MouTracker/screens/mou_creation/creation_page_utils/create_mou_widgets.dart';
import 'package:MouTracker/common_widgets/fields.dart';
import 'package:MouTracker/services/Firebase/firestore/firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:io' as io;

class PlacementForm extends StatefulWidget {
  final String mouId;
  final String title;

  const PlacementForm(
      {this.title = "Engagement activity", super.key, required this.mouId});

  @override
  State<PlacementForm> createState() => _PlacementFormState();
}

class _PlacementFormState extends State<PlacementForm> {
  TextEditingController yearController = TextEditingController();

  TextEditingController divisionController = TextEditingController();

  TextEditingController schoolController = TextEditingController();

  TextEditingController studentDetailsController = TextEditingController();

  TextEditingController docController = TextEditingController();

  static io.File? file;
  static UploadTask? task;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    file = null;
    task = null;
    super.initState();
  }

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

                  // submitButton(screenWidth, screenHeight, context, formKey),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenWidth * 0.05),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }
                        formKey.currentState!.save();

                        // try {
                        //   await DataBaseService().uploadEngagementData(
                        //       mouId: widget.mouId,
                        //       activityName: 'placements',
                        //       data: {
                        //         'year': yearController.text,
                        //         'division': divisionController.text,
                        //         'school': schoolController.text,
                        //         'doc-name': docController.text,
                        //       });

                        //   await DataBaseService().updateEngagementList(
                        //       mouId: widget.mouId,
                        //       activityName: 'placements',
                        //       activityDesc: 'Details of yearwise placements');
                        // } catch (err) {
                        //   print("Error occurred - $err");
                        // }

                        Navigator.of(context, rootNavigator: true)
                            .pushReplacement(MaterialPageRoute(
                                builder: (_) => const NewHomePage()));
                      },
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
