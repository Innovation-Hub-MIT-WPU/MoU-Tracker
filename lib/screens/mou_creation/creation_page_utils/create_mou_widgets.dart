import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/screens/mou_creation/mou_creation_page.dart';
import 'package:google_fonts/google_fonts.dart';
import '/services/Firebase/firestore/upload_service.dart';
import 'package:flutter/material.dart';

Widget fileName() {
  return Center(
    child: PText(
        CreateFormState.file == null
            ? "No File Selected"
            : CreateFormState.file!.path.split('/').last,
        style: GoogleFonts.figtree(color: kBgClr2)),
  );
}

Widget formButtons(double h, double w, ControlsDetails details,
    List<Step> Function(double h, double w) getSteps) {
  bool isLastStep = details.currentStep == getSteps(h, w).length - 1;
  return Padding(
    padding: details.currentStep == 0
        ? EdgeInsets.all(w * 0.035)
        : EdgeInsets.all(w * 0.025),
    child: Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: details.onStepContinue,
            child: isLastStep ? const PText("Submit") : const PText("Next"),
          ),
        ),
        SizedBox(width: w * 0.025),
        if (details.currentStep != 0)
          Expanded(
            child: ElevatedButton(
              onPressed: details.onStepCancel,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey[300]),
              ),
              child: PText(
                "Back",
                style: GoogleFonts.figtree(color: Colors.grey),
              ),
            ),
          ),
      ],
    ),
  );
}

Widget chooseFileButton(BuildContext context, Future Function() pickFile) {
  double width = MediaQuery.of(context).size.width;
  return Padding(
    padding: EdgeInsets.all(width * 0.02),
    child: Container(
      height: MediaQuery.of(context).size.height * 0.08,
      width: width * 0.75,
      padding: EdgeInsets.fromLTRB(width / 40, width / 40, 0, 0),
      child: ElevatedButton(
        onPressed: () {
          pickFile();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xff64C636)),
          elevation: MaterialStateProperty.all(5),
        ),
        child: PText(
          'Choose File',
          style: GoogleFonts.figtree(fontSize: width * 0.055),
        ),
      ),
    ),
  );
}

Widget dialog(BuildContext cntx) {
  double width = MediaQuery.of(cntx).size.width;
  return SimpleDialog(
    backgroundColor: const Color(0xFF2D376E),
    title: Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: width * 0.020),
          child: Icon(
            Icons.error,
            // color: Color(0xFFF2C32C),
            color: kCardRed,
          ),
        ),
        Flexible(
          child: PText(
            "Please Wait",
            style: GoogleFonts.figtree(
                fontWeight: FontWeight.w600, color: Colors.white),
          ),
        )
      ],
    ),
    contentPadding: EdgeInsets.all(width * 0.025),
    // contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
    children: <Widget>[
      CreateFormState.task != null
          ? buildUploadStatus(CreateFormState.task!)
          : PText(
              "You haven't selected any file",
              style: GoogleFonts.figtree(color: Colors.white),
            ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFFF2C32C))),
            onPressed: () {
              // CreationDetails.mapping(FirebaseApi.downloadUrl, "downloadLink");
              // CreationDetails.addData();

              Navigator.pop(cntx);
              Navigator.of(cntx).pushReplacementNamed('/submitted');
            },
            child: PText(
              "Next",
              style: GoogleFonts.figtree(color: Colors.white),
            ),
          )
        ],
      )
    ],
  );
}
