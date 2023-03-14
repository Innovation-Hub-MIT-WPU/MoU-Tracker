// ignore_for_file: must_be_immutable

import 'package:MouTracker/common_widgets/widgets.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/common_widgets/fields.dart';
import 'package:MouTracker/screens/home_page/new_nav_bar.dart';
import 'package:MouTracker/services/Firebase/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Guest session
// Projects
// Advisory boards
class EngagementForm extends StatelessWidget {
  final String mouId;
  final String title;
  final String desc;
  EngagementForm(
      {this.title = "Engagement activity",
      super.key,
      required this.mouId,
      required this.desc});

  // Projects & boards
  final TextEditingController nameController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController companyController = TextEditingController();

  // Guest sessions
  final TextEditingController divisionController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  GlobalKey formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar(title, context),
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
                  title == 'guest sessions'
                      ? GuestSessionForm(context, screenWidth, screenHeight)
                      : ProjectsForm(screenWidth, screenHeight),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenWidth * 0.05),
                    child: ElevatedButton(
                      onPressed: () async {
                        Map<String, dynamic> data = {};
                        if (title == 'consultancy projects' ||
                            title == 'advisory boards') {
                          data = {
                            'name': nameController.text,
                            'designation': designationController.text,
                            'company': companyController.text
                          };
                        } else {
                          data = {
                            'division': divisionController.text,
                            'school': schoolController.text,
                            'date': selectedDate
                          };
                        }
                        await DataBaseService().uploadEngagementData(
                          mouId: mouId,
                          activityName: title,
                          data: data,
                        );
                        await DataBaseService().updateEngagementList(
                          mouId: mouId,
                          activityName: title,
                          activityDesc: desc,
                        );
                        // ignore: use_build_context_synchronously
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

  Widget ProjectsForm(double screenWidth, double screenHeight) {
    return Column(
      children: [
        PText(
          "Name of Authority",
          style: GoogleFonts.figtree(
              fontSize: screenWidth * 0.040, fontWeight: FontWeight.bold),
        ),
        CreateMouField(
            hintText: "Enter the name",
            textInputType: TextInputType.multiline,
            textEditingController: nameController),
        PText(
          "Designation",
          style: GoogleFonts.figtree(
              fontSize: screenWidth * 0.040, fontWeight: FontWeight.bold),
        ),
        CreateMouField(
            hintText: "Enter the Designation",
            textInputType: TextInputType.text,
            textEditingController: designationController),
        PText(
          "Company",
          style: GoogleFonts.figtree(
              fontSize: screenWidth * 0.040, fontWeight: FontWeight.bold),
        ),
        CreateMouField(
            hintText: "Enter company name",
            textInputType: TextInputType.text,
            textEditingController: companyController),
      ],
    );
  }

  Widget GuestSessionForm(
      BuildContext context, double screenWidth, double screenHeight) {
    return Column(
      children: [
        PText(
          "Division",
          style: GoogleFonts.figtree(
              fontSize: screenWidth * 0.040, fontWeight: FontWeight.bold),
        ),
        CreateMouField(
            hintText: "Enter the division",
            textInputType: TextInputType.multiline,
            textEditingController: divisionController),
        PText(
          "School",
          style: GoogleFonts.figtree(
              fontSize: screenWidth * 0.040, fontWeight: FontWeight.bold),
        ),
        CreateMouField(
            hintText: "Enter the School name",
            textInputType: TextInputType.text,
            textEditingController: schoolController),
        PText(
          "Date(s)",
          style: GoogleFonts.figtree(
              fontSize: screenWidth * 0.040, fontWeight: FontWeight.bold),
        ),
        selectDueDate(context, selectedDate),
      ],
    );
  }
}
