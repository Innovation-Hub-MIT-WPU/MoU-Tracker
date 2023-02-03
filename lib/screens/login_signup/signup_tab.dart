// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:MouTracker/screens/home_page/new_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

import '/common_utils/utils.dart';
import '/services/Firebase/fireauth/model.dart';
import 'auth_page_utlis/login_signup_widgets.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //form key
  final _formKey = GlobalKey<FormState>();

  //Send Data to Firebase
  //editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController designationController = TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;

  String? designation;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    Widget signupButton() {
      return SizedBox(
        width: 125,
        height: 35,
        child: ElevatedButton(
          onPressed: () {
            signupFunction(emailController.text, passwordController.text);
          },
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(AppColors.buttonYellow),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))))),
          child: Text("SIGN UP",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              )),
        ),
      );
    }

    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kFormHorizontal),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.024),
                  nameFormElement("FIRST NAME", firstNameController,
                      screenHeight, screenWidth),
                  SizedBox(height: screenHeight * 0.024),
                  nameFormElement("LAST NAME", lastNameController, screenHeight,
                      screenWidth),
                  SizedBox(height: screenHeight * 0.024),
                  emailFormElement(emailController, screenWidth, screenHeight),
                  SizedBox(height: screenHeight * 0.024),
                  passwordFormElement(
                      passwordController, screenWidth, screenHeight),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "Forgot password",
                          textAlign: TextAlign.center,
                        ),
                        behavior: SnackBarBehavior.floating,
                        width: 200,
                        duration: Duration(milliseconds: 1000),
                        shape: StadiumBorder(),
                      ));
                    },
                    child: const Text("Forgot Password?",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400)),
                  ),
                  FormAndDropDown(
                    designationController: designationController,
                    designation: designation,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  SizedBox(height: screenHeight * 0.024),
                  Center(
                    child: signupButton(),
                  ),
                  SizedBox(
                    height: screenHeight * 0.024,
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void signupFunction(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => postUserDetails())
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postUserDetails() async {
    //calling firestore
    //calling user model
    //sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    //writing all the values
    userModel.email = user!.email;
    userModel.lastName = lastNameController.text;
    userModel.firstName = firstNameController.text;
    userModel.designation = designationController.text;
    userModel.pos = designations.indexOf(designationController.text);
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    Fluttertoast.showToast(msg: "Account created successfully !");

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => NewHomePage()));
  }
}
