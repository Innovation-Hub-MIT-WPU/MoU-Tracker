import 'package:MouTracker/models/personalized_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget floatingButtonUI(
    double screenWidth, double screenHeight, BuildContext context,
    {required String title, required Widget nextPage}) {
  return Container(
    alignment: Alignment.bottomRight,
    margin: EdgeInsets.only(bottom: screenWidth * 0.04),
    child: FloatingActionButton.extended(
      onPressed: () => Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => nextPage)),
      // Navigator.pushNamed(context, '/create_mou'),
      backgroundColor: const Color(0xff2D376E),
      label: PText(title,
          style: GoogleFonts.figtree(fontSize: screenWidth * 0.04)),
      icon: Icon(
        Icons.add,
        size: screenWidth * 0.06,
      ),
    ),
  );
}

Widget submitButton(double screenWidth, double screenHeight,
    BuildContext context, GlobalKey<FormState> formKey) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05, vertical: screenWidth * 0.05),
    child: ElevatedButton(
      onPressed: () {
        if (!formKey.currentState!.validate()) {
          return;
        }
        formKey.currentState!.save();

        try {
            

        } catch (err) {
          print("Error occurred - $err");
        }
      },
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: const PText("Submit"),
      ),
    ),
  );
}

