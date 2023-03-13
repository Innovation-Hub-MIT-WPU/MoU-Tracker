import 'package:MouTracker/common_utils/upload_file.dart';
import 'package:MouTracker/common_widgets/widgets.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/common_widgets/fields.dart';
import 'package:MouTracker/screens/home_page/new_nav_bar.dart';
import 'package:MouTracker/screens/mou_creation/creation_page_utils/create_mou_widgets.dart';
import 'package:MouTracker/services/Firebase/firestore/firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io' as io;

class CenterForm extends StatefulWidget {
  final String mouId;
  final String title;
  const CenterForm(
      {this.title = "Engagement activity", super.key, required this.mouId});

  @override
  State<CenterForm> createState() => _CenterFormState();
}

class _CenterFormState extends State<CenterForm> {
  final TextEditingController divisionController = TextEditingController();

  final TextEditingController schoolController = TextEditingController();

  final TextEditingController labController = TextEditingController();

  final TextEditingController budgetController = TextEditingController();

  final GlobalKey formKey = GlobalKey();

  static io.File? file;

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
                    "Division",
                    style: GoogleFonts.figtree(
                        fontSize: screenWidth * 0.040,
                        fontWeight: FontWeight.bold),
                  ),
                  CreateMouField(
                      hintText: "Enter the division",
                      textInputType: TextInputType.multiline,
                      textEditingController: divisionController),
                  PText(
                    "School",
                    style: GoogleFonts.figtree(
                        fontSize: screenWidth * 0.040,
                        fontWeight: FontWeight.bold),
                  ),
                  CreateMouField(
                      hintText: "Enter the school name",
                      textInputType: TextInputType.multiline,
                      textEditingController: schoolController),
                  PText(
                    "Budget",
                    style: GoogleFonts.figtree(
                        fontSize: screenWidth * 0.040,
                        fontWeight: FontWeight.bold),
                  ),
                  CreateMouField(
                      hintText: "Enter the budget used",
                      textInputType: TextInputType.number,
                      textEditingController: budgetController),
                  PText(
                    "Upload Document",
                    style: GoogleFonts.figtree(
                        fontSize: screenWidth * 0.040,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: fileName(file),
                  ),
                  chooseFileButton(context, pickFile),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenWidth * 0.05),
                    child: ElevatedButton(
                      onPressed: () async {
                        await DataBaseService().uploadEngagementData(
                            mouId: widget.mouId,
                            activityName: 'center of excellence',
                            data: {
                              'division': divisionController.text,
                              'school': schoolController.text,
                              'lab-name': labController.text,
                              'budget': budgetController.text
                            });
                        await DataBaseService().updateEngagementList(
                            mouId: widget.mouId,
                            activityName: 'center of excellence',
                            activityDesc:
                                'Details of agreements & transactions for Center of Excellence');
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
                ],
              ),
            ),
          )),
    );
  }

  Future pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) {
      // print("result null");
      return;
    } else {
      final filepath = result.files.single.path!;
      setState(() {
        file = io.File(filepath);
      });
    }
  }
}
