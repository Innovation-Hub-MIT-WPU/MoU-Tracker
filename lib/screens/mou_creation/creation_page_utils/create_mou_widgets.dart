import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/screens/mou_creation/mou_creation_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;

Widget fileName(io.File? file) {
  return Center(
    child: PText(file == null ? "No File Selected" : file.path.split('/').last,
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
