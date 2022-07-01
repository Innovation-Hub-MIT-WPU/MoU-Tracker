// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../common_utils/utils.dart';
import '../../common_widgets/login_signup_widgets.dart';
import '../../services/Firebase/fireauth/model.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  //form key
  final _formKey = GlobalKey<FormState>();

  //editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {

    Widget signupButton(){
      return SizedBox(
        width: 125,
        height: 35,
        child: ElevatedButton(
          onPressed: (){
            signupFunction(emailController.text, passwordController.text);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.buttonYellow),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
              )
            )
          ),
          child: Text("SIGN UP", textAlign: TextAlign.center, style: TextStyle(
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
              SizedBox(height: kFormSpacing),
      
              nameFormElement("FIRST NAME", "", firstNameController),
              SizedBox(height: kFormSpacing),
      
              nameFormElement("LAST NAME", "", lastNameController),
              SizedBox(height: kFormSpacing),
      
              emailFormElement("EMAIL ADDRESS", "abc@gmail.com", emailController),
              SizedBox(height: kFormSpacing),
      
              formAndDropDown(text: "DESIGNATION", hintText: "Choose designation"),
              //formElement("DESIGNATION", ""),
              SizedBox(height: kFormSpacing),
      
              passwordFormElement("PASSWORD", "", passwordController),
              TextButton(
                onPressed: () { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Forgot password", textAlign: TextAlign.center,), behavior: SnackBarBehavior.floating, width: 200, duration: Duration(milliseconds: 1000) , shape: StadiumBorder(),));},
                child: const Text("Forgot Password?",
                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400)),
              ),
      
              Center(
                child: signupButton(),
              ),
              SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    ));
  }

  void signupFunction(String email, String password) async {
    if(_formKey.currentState!.validate()){
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
        .then( (value) => postDetailsToFirestore())
        .catchError((e){
          Fluttertoast.showToast(msg: e!.message);
        });
    }
  }
  postDetailsToFirestore() async {

    //calling firestore
    //calling user model
    //sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    
    UserModel userModel = UserModel();

    //writing all the values
    userModel.email = user!.email;
    userModel.userid = user.uid;
    userModel.firstName = firstNameController.text;
    userModel.lastName = lastNameController.text;

    await firebaseFirestore
      .collection("users")
      .doc(user.uid)
      .set(userModel.toMap());

    Fluttertoast.showToast(msg: "Account created successfully !");

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => EmptyPage(previousPageName: "Sign up tab")), (route) => false);

  }
}
