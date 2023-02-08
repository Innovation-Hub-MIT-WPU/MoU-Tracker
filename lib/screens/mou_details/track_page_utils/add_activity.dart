import 'package:MouTracker/common_utils/upload_file.dart';
import 'package:MouTracker/common_widgets/widgets.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/screens/mou_creation/creation_page_utils/create_mou_widgets.dart';
import 'package:MouTracker/screens/mou_creation/creation_page_utils/fields.dart';
import 'package:MouTracker/services/Firebase/fireauth/model.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class AddActivity extends StatefulWidget {
  const AddActivity({super.key});

  @override
  State<AddActivity> createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  TextEditingController yearController = TextEditingController();
  TextEditingController divisionController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  TextEditingController studentDetailsController = TextEditingController();
  TextEditingController docController = TextEditingController();

  // static io.File? file;
  // static UploadTask? task;

  final _formKey = GlobalKey<FormState>();
  late UserModel userData;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: appBar("Add Activity", context),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: Form(
              key: _formKey,
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

                      fileName(),
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
        ));
  }

  Future pickFile() async {
    return;
  }
}