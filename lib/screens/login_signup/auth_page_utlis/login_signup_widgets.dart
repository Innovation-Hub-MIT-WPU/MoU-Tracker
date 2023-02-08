import 'package:flutter/material.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:google_fonts/google_fonts.dart';
import '/common_utils/utils.dart';

//designations array used in DropDownButtonFormField items

//A widget using DropDropDownButtonFormField to give dropdown for var _designations
///A widget to create DropDownButtonFormField

//for each _designation element, we are mapping it to 'buildMenuItem' function and then converting to List:
//" items: _designations.map(buildMenuItem).toList()  "
DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Container(
        child: PText(item,
            style: GoogleFonts.figtree(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.black)),
      ),
    );

//----------------------------------------

///form field for email validation
Widget emailFormElement(TextEditingController emailController,
    double screenHeight, double screenWidth) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      PText(
        "EMAIL",
        style: GoogleFonts.figtree(
            color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
      ),
      const SizedBox(height: kFormSpacing / 2),
      TextFormField(
        style: GoogleFonts.figtree(color: Colors.white),
        autofocus: false,
        onSaved: (value) {
          emailController.text = value!;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your email";
          }
          //reg ex for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return "Please enter a valid email";
          }
          return null;
        },
        cursorColor: AppColors.buttonYellow,
        decoration: InputDecoration(
          hintText: "abc@gmail.com",
          hintStyle: GoogleFonts.figtree(color: Colors.white.withOpacity(0.5)),
          contentPadding: EdgeInsets.all(screenWidth * 0.02),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: kBorderWidth)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: kBorderWidth)),
          focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColors.buttonYellow, width: kBorderWidth),
          ),
        ),
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
      ),
    ],
  );
}

///form field for password validation
Widget passwordFormElement(TextEditingController passwordController,
    double screenHeight, double screenWidth) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      PText(
        "PASSWORD",
        style: GoogleFonts.figtree(
            color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
      ),
      const SizedBox(height: kFormSpacing / 2),
      TextFormField(
        style: GoogleFonts.figtree(color: Colors.white),
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Please enter a password");
          }
          if (!regex.hasMatch(value)) {
            return ("Please enter a valid passowrd (min. 6 characters)");
          }
          return null;
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.next,
        cursorColor: AppColors.buttonYellow,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(screenWidth * 0.02),
            enabledBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.white, width: kBorderWidth)),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.buttonYellow, width: kBorderWidth),
            ),
            border: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.white, width: kBorderWidth))),
      ),
    ],
  );
}

///form field for names (first name, last name)
Widget nameFormElement(String text, TextEditingController nameController,
    double screenHeight, double screenWidth) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      PText(
        text,
        style: GoogleFonts.figtree(
            color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
      ),
      const SizedBox(height: kFormSpacing / 2),
      TextFormField(
        style: GoogleFonts.figtree(color: Colors.white),
        autofocus: false,
        controller: nameController,
        validator: (value) {
          //RegExp regex = RegExp("/(^[a-zA-Z][a-zA-Zs]{0,20}[a-zA-Z])/");
          if (value!.isEmpty) {
            return "Please enter name";
          }
          /*if(!regex.hasMatch(value)){
            return "Enter a valid name (no numericals and special characters)";
          }*/
          return null;
        },
        onSaved: (value) {
          nameController.text = value!;
        },
        cursorColor: AppColors.buttonYellow,
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.white, width: kBorderWidth)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.buttonYellow, width: kBorderWidth),
            ),
            border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.white, width: kBorderWidth))),
        textInputAction: TextInputAction.next,
      ),
    ],
  );
}

//----------------------------------------

//Button widget: used in 'Get Started' screen
Widget appButton(String text, Widget newRoute, BuildContext context) {
  double h = MediaQuery.of(context).size.height;
  double w = MediaQuery.of(context).size.width;
  return SizedBox(
    // width: 315,
    // height: 58,
    height: h * 0.07,
    width: w * 0.8,
    child: ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (builder) => newRoute));
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.buttonYellow),
          shape: MaterialStateProperty.all(const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))))),
      child: PText(text,
          textAlign: TextAlign.center,
          style: GoogleFonts.figtree(
            fontSize: 24,
            color: Colors.white,
          )),
    ),
  );
}

//----------------------------------------

///A text footer -> 'Privacy policy . TOC . Content Policy'
Widget footer(BuildContext context, double screenWidth) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      footerText("Privacy Policy", context),
      SizedBox(
        width: screenWidth * 0.05,
      ),
      const Icon(
        Icons.circle,
        size: 6,
        color: Colors.white,
      ),
      SizedBox(
        width: screenWidth * 0.05,
      ),
      footerText("TOS", context),
      SizedBox(
        width: screenWidth * 0.05,
      ),
      const Icon(Icons.circle, size: 6, color: Colors.white),
      SizedBox(
        width: screenWidth * 0.05,
      ),
      footerText("Content Policy", context),
    ],
  );
}

//Clickable text used in above footer widget
Widget footerText(String text, BuildContext context) {
  return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: PText(
            text,
            textAlign: TextAlign.center,
          ),
          behavior: SnackBarBehavior.floating,
          width: MediaQuery.of(context).size.width * 0.4,
          duration: const Duration(milliseconds: 1000),
          shape: const StadiumBorder(),
        ));
      },
      child: PText(text,
          style: GoogleFonts.figtree(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          )));
}
