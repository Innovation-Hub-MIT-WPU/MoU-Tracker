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

Widget formButtons(ControlsDetails details, List<Step> Function() getSteps) {
  bool isLastStep = details.currentStep == getSteps().length - 1;
  return Padding(
    padding: details.currentStep == 0
        ? const EdgeInsets.all(22.0)
        : const EdgeInsets.all(12.0),
    child: Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: details.onStepContinue,
            child: isLastStep ? const PText("Submit") : const PText("Next"),
          ),
        ),
        const SizedBox(width: 12),
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
    padding: const EdgeInsets.all(8.0),
    child: Container(
      // height: 60,
      // width: 300,
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
          style: GoogleFonts.figtree(fontSize: 20),
        ),
      ),
    ),
  );
}

Widget dialog(BuildContext cnt) {
  return SimpleDialog(
    backgroundColor: const Color(0xFF2D376E),
    title: Row(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(right: 8.0),
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
    contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
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

              Navigator.pop(cnt);
              Navigator.of(cnt).pushReplacementNamed('/submitted');
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
