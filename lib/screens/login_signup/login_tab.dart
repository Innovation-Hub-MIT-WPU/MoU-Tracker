// ignore_for_file: prefer_const_constructors
import 'package:MouTracker/screens/home_page/new_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth_page_utlis/login_signup_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import '/common_utils/utils.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  //form key
  final _formKey = GlobalKey<FormState>();

  //editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController designationController = TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;

  String? designation;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    Widget loginButton() {
      return SizedBox(
        width: 125,
        height: 35,
        child: ElevatedButton(
          onPressed: () {
            logInFunction(emailController.text, passwordController.text);
          },
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(AppColors.buttonYellow),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))))),
          child: PText("LOG IN",
              textAlign: TextAlign.center,
              style: GoogleFonts.figtree(
                fontSize: 16,
                color: Colors.white,
              )),
        ),
      );
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.066),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.024),

                emailFormElement(emailController, screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.024),

                passwordFormElement(
                    passwordController, screenHeight, screenWidth),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: PText(
                        "Forgot password",
                        textAlign: TextAlign.center,
                      ),
                      behavior: SnackBarBehavior.floating,
                      width: 200,
                      duration: Duration(milliseconds: 1000),
                      shape: StadiumBorder(),
                    ));
                  },
                  child: PText("Forgot Password?",
                      style: GoogleFonts.figtree(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400)),
                ),
                //SizedBox(height: kFormSpacing),

                //formElement("DESIGNATION", ""),
                // FormAndDropDown(
                //   designationController: designationController,
                //   designation: designation,
                //   screenHeight: screenHeight,
                //   screenWidth: screenWidth,
                // ),
                SizedBox(height: screenHeight * 0.024),

                Center(
                  child: loginButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///Checks if form key is validated
  ///Logs the user in using firebase authentication
  void logInFunction(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      //if login is successful then display toast else display error toast
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((userid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => NewHomePage()))
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
