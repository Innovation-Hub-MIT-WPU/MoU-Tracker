import 'package:MouTracker/common_widgets/widgets.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/common_widgets/fields.dart';
import 'package:MouTracker/screens/home_page/new_nav_bar.dart';
import 'package:MouTracker/services/Firebase/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class GuestSessionForm extends StatelessWidget {
  final String mouId;
  final String title;
  GuestSessionForm(
      {this.title = "Engagement activity", super.key, required this.mouId});

  TextEditingController nameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController companyController = TextEditingController();
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
                  PText(
                    "Name of Authority",
                    style: GoogleFonts.figtree(
                        fontSize: screenWidth * 0.040,
                        fontWeight: FontWeight.bold),
                  ),
                  CreateMouField(
                      hintText: "Enter the name",
                      textInputType: TextInputType.multiline,
                      textEditingController: nameController),
                  PText(
                    "Designation",
                    style: GoogleFonts.figtree(
                        fontSize: screenWidth * 0.040,
                        fontWeight: FontWeight.bold),
                  ),
                  CreateMouField(
                      hintText: "Enter the Designation",
                      textInputType: TextInputType.text,
                      textEditingController: designationController),
                  PText(
                    "Company",
                    style: GoogleFonts.figtree(
                        fontSize: screenWidth * 0.040,
                        fontWeight: FontWeight.bold),
                  ),
                  CreateMouField(
                      hintText: "Enter company name",
                      textInputType: TextInputType.text,
                      textEditingController: companyController),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenWidth * 0.05),
                    child: ElevatedButton(
                      onPressed: () async {
                        await DataBaseService().uploadEngagementData(
                            mouId: mouId,
                            activityName: 'advisory boards',
                            data: {
                              'name': nameController.text,
                              'designation': designationController.text,
                              'company': companyController.text
                            });
                        await DataBaseService().updateEngagementList(
                          mouId: mouId,
                          activityName: 'advisory boards',
                          activityDesc:
                              'Industry Advisory boards setted up for the company',
                        );
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
}

Future pickFile() async {
  return;
}
