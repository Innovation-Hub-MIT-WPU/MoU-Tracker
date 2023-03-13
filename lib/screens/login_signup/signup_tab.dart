// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors
import 'package:MouTracker/screens/home_page/new_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

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

  final _multiSelectKey = GlobalKey<FormFieldState>();

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
  final List<MultiSelectItem<String>> _list = [
    MultiSelectItem('Initiator', "Initiator"),
    MultiSelectItem('SPOC', "SPOC"),
    MultiSelectItem('Head', "Head"),
    MultiSelectItem('Directors', "Directors"),
    MultiSelectItem('CEO', "CEO"),
    MultiSelectItem('Dean', "Dean"),
    MultiSelectItem('Vice Chancellor', "Vice Chancellor"),
  ];
  List selectedList = [];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    Widget signupButton() {
      return SizedBox(
        width: screenWidth * 0.5,
        height: screenHeight * 0.05,
        child: ElevatedButton(
          onPressed: () {
            signupFunction(emailController.text, passwordController.text);
          },
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(AppColors.buttonYellow),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))))),
          child: PText("SIGN UP",
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
                        content: PText(
                          "Forgot password",
                          textAlign: TextAlign.center,
                        ),
                        behavior: SnackBarBehavior.floating,
                        width: screenWidth * 0.5,
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
                  PText(
                    "DESIGNATION",
                    style: GoogleFonts.figtree(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  const SizedBox(height: kFormSpacing / 2),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: MultiSelectDialogField(
                      key: _multiSelectKey,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        border: Border.all(color: Colors.white),
                      ),
                      items: _list,
                      chipDisplay: MultiSelectChipDisplay(
                        items: _list,
                      ),
                      onConfirm: (List<dynamic> list) {
                        setState(() {
                          selectedList = list;
                        });
                        // print(selectedList);
                        // print(
                        // "_list.indexOf(selectedList[0]) ${designations.indexOf(selectedList[0])} \n selectedList.toString() ${selectedList.toString()} \n selectedList[0] ${selectedList[0]}");
                      },
                    ),
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
    if (_formKey.currentState!.validate() && selectedList.isNotEmpty) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        postUserDetails();
      }).catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    } else {
      Fluttertoast.showToast(msg: "Select DESIGNATION ");
    }
  }

  postUserDetails() async {
    //calling firestore
    //calling user model
    //sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();
    // ignore: unused_local_variable
    String positions = "";
    for (String i in selectedList) {
      positions += "$i ";
    }
    //writing all the values
    userModel.email = user!.email;
    userModel.lastName = lastNameController.text;
    userModel.firstName = firstNameController.text;
    userModel.designation = selectedList[0];
    userModel.positions = selectedList;
    userModel.pos = designations.indexOf(selectedList[0]);
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    Fluttertoast.showToast(msg: "Account created successfully !");
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => NewHomePage()));
    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NewNavBar()));
  }
}
